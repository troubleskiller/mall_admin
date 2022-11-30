import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/api/brand_api.dart';
import 'package:flutter_mall_admin/api/policy_api.dart';
import 'package:flutter_mall_admin/model/api/aliyun_policy_oss_model.dart';
import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/model/mall/brand_model.dart';
import 'package:flutter_mall_admin/model/mall/image_model.dart';
import 'package:flutter_mall_admin/screen/brand_screen/brand_screen.dart';
import 'package:flutter_mall_admin/util/tro_util.dart';
import 'package:flutter_mall_admin/widget/button/buttons.dart';
import 'package:flutter_mall_admin/widget/button/icon_button.dart';
import 'package:flutter_mall_admin/widget/input/TroInput.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final BrandModel? brandModel;
  final BrandListState? brandListState;

  const ImageUpload({super.key, required this.brandModel, this.brandListState});

  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  ImageModel imageModel = ImageModel();
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          TroInput(
            label: 'imageTitle',
            value: imageModel.title,
            onSaved: (v) => {imageModel.title = v},
            validator: (v) {
              return v!.isEmpty ? 'required' : null;
            },
          ),
          TroInput(
            label: 'imageMemo',
            value: imageModel.memo,
            onSaved: (v) => {imageModel.memo = v},
          ),
        ],
      ),
    );
    List<Widget> buttons = <Widget>[
      ButtonWithIcon(
        label: 'gallery',
        iconData: Icons.photo,
        onPressed: () => pickImage(ImageSource.gallery),
      ),
      ButtonWithIcons.save(context, pickedFile == null ? null : () => save()),
      Text(
        'sizeLimit',
        style: TextStyle(color: Colors.red),
      ),
    ];
    if (!kIsWeb) {
      buttons.insert(
        0,
        ButtonWithIcon(
          label: 'camera',
          iconData: Icons.camera,
          onPressed: () => pickImage(ImageSource.camera),
        ),
      );
    }
    var bb = ButtonBar(children: buttons);
    var result = SizedBox(
      width: 650,
      height: isDisplayDesktop(context) ? 350 : 500,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            form,
            bb,
            previewImage(),
          ],
        ),
      ),
    );

    return result;
  }

  pickImage(ImageSource source) async {
    pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile == null) {
      return;
    }
    imageBytes = await pickedFile!.readAsBytes();
    if (imageBytes!.length > 1000 * 1000 * 10) {
      pickedFile = null;
      imageBytes = null;
      setState(() {});
      return;
    }

    setState(() {
      formKey.currentState!.save();
    });
  }

  save() async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    ResponseBodyApi responseBodyApi = await beforeUpload();
    AliyunPolicyOssModel policy =
        AliyunPolicyOssModel.fromJson(responseBodyApi.data);
    var mediaType = MediaType.parse(pickedFile?.mimeType ?? '');
    String filename = '${imageModel.title}.${mediaType.subtype}';
    var file = MultipartFile.fromBytes(imageBytes!,
        contentType: mediaType, filename: filename);
    Response response = await PolicyApi.ossUpload(policy, file);
    widget.brandModel?.logo =
        'https://troubleskiller-mall.oss-cn-hangzhou.aliyuncs.com/${policy.dir}$filename';
    BrandApi.save(widget.brandModel?.toJson());
    widget.brandListState?.setState(() {});
    setState(() {
      pickedFile = null;
    });
  }

  Future<ResponseBodyApi> beforeUpload() async {
    return await PolicyApi.getPolicy();
    // print(responseBodyApi.data);
  }

  Widget previewImage() {
    if (pickedFile != null) {
      if (kIsWeb) {
        return Image.network(pickedFile!.path);
      } else {
        return Image.file(File(pickedFile!.path));
      }
    } else {
      return Container();
    }
  }
}
