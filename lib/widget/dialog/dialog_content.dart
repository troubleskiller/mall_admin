import 'package:flutter/material.dart';

double btnHeight = 60;
double borderWidth = 2;

class RenameDialogContent extends StatefulWidget {
  final String title;
  final String cancelBtnTitle;
  final String okBtnTitle;
  final Function cancelBtnTap;
  final Function okBtnTap;

  //controller for describe
  final TextEditingController describeController;

  //controller for name
  final TextEditingController nameController;

  const RenameDialogContent({
    Key? key,
    required this.title,
    this.cancelBtnTitle = "取消",
    this.okBtnTitle = "创建",
    required this.cancelBtnTap,
    required this.okBtnTap,
    required this.describeController,
    required this.nameController,
  }) : super(key: key);

  @override
  _RenameDialogContentState createState() => _RenameDialogContentState();
}

class _RenameDialogContentState extends State<RenameDialogContent> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(vertical: 20),
        height: 250,
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: const TextStyle(color: Colors.grey),
                )),
            Container(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                style: const TextStyle(color: Colors.black87),
                controller: widget.nameController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelText: "name",
                    labelStyle: TextStyle(fontSize: 18),
                    contentPadding: EdgeInsets.only(bottom: 0, left: 2)),
              ),
            ),
            Container(
              height: 5,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            //   child: TextField(
            //     style: const TextStyle(color: Colors.black87),
            //     controller: widget.describeController,
            //     decoration: const InputDecoration(
            //       enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.blue),
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.blue),
            //       ),
            //       labelText: "项目描述",
            //       labelStyle: TextStyle(fontSize: 18),
            //       contentPadding: EdgeInsets.only(bottom: 0, left: 2),
            //     ),
            //   ),
            // ),
            Container(
              // color: Colors.red,
              height: btnHeight,
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Column(
                children: [
                  Container(
                    // 按钮上面的横线
                    width: double.infinity,
                    color: Colors.blue,
                    height: borderWidth,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // widget.vc.text = "";
                          widget.cancelBtnTap();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.cancelBtnTitle,
                          style:
                              const TextStyle(fontSize: 22, color: Colors.blue),
                        ),
                      ),
                      Container(
                        // 按钮中间的竖线
                        width: borderWidth,
                        color: Colors.blue,
                        height: btnHeight - borderWidth - borderWidth,
                      ),
                      GestureDetector(
                          onTap: () {
                            widget.okBtnTap();
                          },
                          child: Text(
                            widget.okBtnTitle,
                            style: const TextStyle(
                                fontSize: 22, color: Colors.blue),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
