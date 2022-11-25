// import 'package:flutter/material.dart';
// import 'package:flutter_mall_admin/api/category_api.dart';
// import 'package:flutter_mall_admin/model/api/page_model.dart';
// import 'package:flutter_mall_admin/model/api/request_api.dart';
// import 'package:flutter_mall_admin/model/api/response_api.dart';
// import 'package:flutter_mall_admin/model/mall/category_model.dart';
// import 'package:flutter_mall_admin/widget/input/TroInput.dart';
//
// class CategoryList extends StatefulWidget {
//   const CategoryList({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return CategoryListState();
//   }
// }
//
// class CategoryListState extends State {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   int rowsPerPage = 10;
//   MyDS myDS = MyDS();
//   CategoryModel formData = CategoryModel();
//
//   _reset() {
//     formData = CategoryModel();
//     formKey.currentState!.reset();
//     myDS.requestBodyApi.params = formData.toJson();
//     myDS.loadData();
//   }
//
//   _query() {
//     formKey.currentState?.save();
//     myDS.requestBodyApi.params = formData.toJson();
//     myDS.loadData();
//   }
//
//   _edit({CategoryModel? CategoryModel}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => Dialog(
//         child: CategoryEdit(
//           CategoryModel: CategoryModel,
//         ),
//       ),
//     ).then((v) {
//       if (v != null) {
//         _query();
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     myDS.context = context;
//     myDS.state = this;
//     myDS.page.pageSize = rowsPerPage;
//     myDS.addListener(() {
//       if (mounted) setState(() {});
//     });
//     WidgetsBinding.instance.addPostFrameCallback((c) {
//       _query();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // var form = Form(
//     //   key: formKey,
//     //   child: Wrap(
//     //     children: <Widget>[
//     //       TroInput(
//     //         label: 'CategoryName',
//     //         value: formData.name,
//     //         onSaved: (v) {
//     //           formData.name = v;
//     //         },
//     //       ),
//     //       TroInput(
//     //         label: S.of(context).CategoryDepartment,
//     //         value: formData.id,
//     //         dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT),
//     //         onSaved: (v) {
//     //           formData.deptId = v;
//     //         },
//     //       ),
//     //     ],
//     //   ),
//     // );
//
//     var buttonBar = ButtonBar(
//       children: <Widget>[
//         IconButton(
//           onPressed: () => _query(),
//           icon: Icon(Icons.search),
//         ),
//         IconButton(
//             icon: Icon(
//               Icons.refresh,
//             ),
//             onPressed: () => _reset()),
//         IconButton(
//             icon: Icon(
//               Icons.add,
//             ),
//             onPressed: () => _edit()),
//         IconButton(
//           icon: Icon(
//             Icons.edit,
//           ),
//           onPressed: myDS.selectedCount != 1
//               ? null
//               : () {
//                   if (myDS.selectedRowCount != 1) {
//                     return;
//                   }
//                   CategoryModel categoryModel = myDS.dataList.firstWhere((v) {
//                     return v.selected!;
//                   });
//                   _edit(CategoryModel: categoryModel);
//                 },
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.delete,
//           ),
//           onPressed: myDS.selectedCount < 1
//               ? null
//               : () {
//                   cryConfirm(context, S.of(context).confirmDelete,
//                       (context) async {
//                     List ids = myDS.dataList.where((v) {
//                       return v.selected!;
//                     }).map<String?>((v) {
//                       return v.id;
//                     }).toList();
//                     var result = await CategoryApi.removeByIds(ids);
//                     if (result.success) {
//                       _query();
//                       CryUtils.message(S.of(Cry.context).success);
//                     }
//                   });
//                 },
//         ),
//       ],
//     );
//
//     Scrollbar table = Scrollbar(
//       child: ListView(
//         padding: const EdgeInsets.all(10.0),
//         children: <Widget>[
//           PaginatedDataTable(
//             header: Text(S.of(context).userList),
//             rowsPerPage: rowsPerPage,
//             onRowsPerPageChanged: (int? value) {
//               setState(() {
//                 if (value != null) {
//                   rowsPerPage = value;
//                   myDS.page.size = rowsPerPage;
//                   myDS.loadData();
//                 }
//               });
//             },
//             availableRowsPerPage: <int>[2, 5, 10, 20],
//             onPageChanged: myDS.onPageChanged,
//             columns: <DataColumn>[
//               DataColumn(
//                 label: Text(S.of(context).name),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('name', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).CategoryNickname),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('nick_name', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).CategoryGender),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('gender', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).CategoryBirthday),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('birthday', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).CategoryDepartment),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('dept_id', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).creationTime),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('create_time', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).updateTime),
//                 onSort: (int columnIndex, bool ascending) =>
//                     myDS.sort('update_time', ascending),
//               ),
//               DataColumn(
//                 label: Text(S.of(context).operating),
//               ),
//             ],
//             source: myDS,
//           ),
//         ],
//       ),
//     );
//
//   }
// }
//
