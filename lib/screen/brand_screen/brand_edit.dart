import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/api/brand_api.dart';
import 'package:flutter_mall_admin/model/mall/brand_model.dart';
import 'package:flutter_mall_admin/util/tro_util.dart';
import 'package:flutter_mall_admin/widget/button/icon_button.dart';
import 'package:flutter_mall_admin/widget/input/TroInput.dart';

class BrandEdit extends StatefulWidget {
  final BrandModel? brandModel;

  const BrandEdit({Key? key, this.brandModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BrandEditState();
  }
}

class BrandEditState extends State<BrandEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BrandModel? _brandModel = BrandModel();

  @override
  void initState() {
    super.initState();
    if (widget.brandModel != null) {
      _brandModel = widget.brandModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          TroInput(
            value: _brandModel!.name,
            label: 'brandName',
            onSaved: (v) {
              _brandModel!.name = v;
            },
            validator: (v) {
              return v!.isEmpty ? 'required' : null;
            },
          ),
          TroInput(
            value: _brandModel!.logo,
            label: 'logo',
            onSaved: (v) {
              _brandModel!.logo = v;
            },
          ),
          TroInput(
            label: 'description',
            value: _brandModel!.descript,
            onSaved: (v) {
              _brandModel!.descript = v;
            },
          ),
          TroInput(
            label: 'showStatus',
            value: _brandModel!.showStatus.toString(),
            onSaved: (v) {
              _brandModel!.showStatus = int.parse(v);
            },
          ),
          TroInput(
            label: 'firstLetter',
            value: _brandModel!.firstLetter.toString(),
            onSaved: (v) {
              _brandModel!.firstLetter = v;
            },
          ),
          TroInput(
            label: 'sort',
            value: _brandModel!.sort.toString(),
            onSaved: (v) {
              _brandModel!.sort = int.parse(v);
            },
          ),
          // CrySelectDate(
          //   context,
          //   value: _brandModel!.birthday,
          //   label: S.of(context).personBirthday,
          //   onSaved: (v) {
          //     _brandModel!.birthday = v;
          //   },
          // ),
          // TroSelect(
          //   label: 'showStatus',
          //   value: _brandModel!.showStatus.toString(),
          //   dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT),
          //   onSaved: (v) {
          //     _brandModel!.deptId = v;
          //   },
          // ),
        ],
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonWithIcon(
          label: 'save',
          iconData: Icons.save,
          onPressed: () {
            FormState form = formKey.currentState!;
            if (!form.validate()) {
              return;
            }
            form.save();
            BrandApi.save(_brandModel!.toJson()).then((res) {
              Navigator.pop(context, true);
            });
          },
        ),
        ButtonWithIcon(
          label: 'cancel',
          iconData: Icons.cancel,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.brandModel == null ? 'add' : 'modify'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            form,
          ],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );
    return SizedBox(
      width: 650,
      height: isDisplayDesktop(context) ? 350 : 500,
      child: result,
    );
  }
}
