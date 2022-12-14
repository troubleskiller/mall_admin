/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 登录
import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/api/user_api.dart';
// import 'package:flutter_mall_admin/context/application_context.dart';
import 'package:flutter_mall_admin/model/admin/user_model.dart';
import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/screen/layout/layout.dart';
import 'package:flutter_mall_admin/util/store_util.dart';
// import 'package:flutter_mall_admin/util/store_util.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User();
  String error = "";
  FocusNode focusNodeUserName = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool isFaceRecognition = false;

  @override
  void initState() {
    super.initState();
    focusNodeUserName.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        body: _buildPageContent(),
      ),
    );
  }

  Widget _buildPageContent() {
    var appName = Text(
      "FLUTTER_ADMIN",
      style: TextStyle(fontSize: 16, color: Colors.blue),
      textScaleFactor: 3.2,
    );
    // return isFaceRecognition
    //     ? FaceRecognition(
    //         onFountFace: (CameraImage cameraImage, String imagePath, List<Face> faces) async {
    //           String faceData = FaceService().toData(cameraImage, faces[0]);
    //           var responseBodyApi = await UserApi.loginByFace(faceData);
    //           if (!responseBodyApi.success!) {
    //             setState(() {
    //               this.isFaceRecognition = false;
    //             });
    //             return;
    //           }
    //           _loginSuccess(responseBodyApi);
    //         },
    //         onBack: () {
    //           setState(() {
    //             this.isFaceRecognition = false;
    //           });
    //         },
    //       )
    //     :
    return Container(
      color: Colors.cyan.shade100,
      child: ListView(
        children: <Widget>[
          Center(child: appName),
          SizedBox(height: 20.0),
          _buildLoginForm(),
          SizedBox(height: 20.0),
          // Column(
          //   children: [
          //     Text('admin'),
          //     Text('pwd'),
          //   ],
          // )
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 500,
              height: 360,
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        focusNode: focusNodeUserName,
                        initialValue: user.name,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '用户名',
                          icon: Icon(
                            Icons.people,
                            color: Colors.blue,
                          ),
                        ),
                        onSaved: (v) {
                          user.name = v;
                        },
                        validator: (v) {
                          return v!.isEmpty ? '请填写密码' : null;
                        },
                        onFieldSubmitted: (v) {
                          focusNodePassword.requestFocus();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        focusNode: focusNodePassword,
                        obscureText: true,
                        initialValue: user.pwd,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '密码',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                        ),
                        onSaved: (v) {
                          user.pwd = v;
                        },
                        validator: (v) {
                          return v!.isEmpty ? '请输入密码' : null;
                        },
                        onFieldSubmitted: (v) {
                          _login();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue.shade600,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 360,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 420,
              child: ElevatedButton(
                onPressed: _login,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0))),
                ),
                child: Text('登陆',
                    style: TextStyle(color: Colors.white70, fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _register() {
    // Cry.pushNamed('/register');
  }

  _login() async {
    var form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    print(user.toString());
    ResponseBodyApi responseBodyApi = await UserApi.login(user.toMap());

    if (responseBodyApi.code == 200) {
      _loginSuccess(responseBodyApi);
      return;
    }
    focusNodePassword.requestFocus();
    return;
  }

  _loginSuccess(ResponseBodyApi responseBodyApi) async {
    // StoreUtil.write(
    //     Constant.KEY_TOKEN, responseBodyApi.data[Constant.KEY_TOKEN]);
    // StoreUtil.write(Constant.KEY_CURRENT_USER_INFO,
    //     responseBodyApi.data[Constant.KEY_CURRENT_USER_INFO]);
    // await StoreUtil.loadDict();
    // await StoreUtil.loadSubsystem();
    await StoreUtil.loadMenuData();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Layout()));
    // await StoreUtil.loadDefaultTabs();
    // StoreUtil.init();
  }
}
