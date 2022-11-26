import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/api/brand_api.dart';
import 'package:flutter_mall_admin/model/api/page_model.dart';
import 'package:flutter_mall_admin/model/api/request_api.dart';
import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/model/mall/brand_model.dart';
import 'package:flutter_mall_admin/widget/button/icon_button.dart';
import 'package:flutter_mall_admin/widget/input/TroInput.dart';

class BrandList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BrandListState();
  }
}

class BrandListState extends State {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///使用相同的控制器[link]https://github.com/flutter/flutter/issues/97873
  ScrollController scrollController = ScrollController();
  int rowsPerPage = 10;
  MyDS myDS = MyDS();

  BrandModel formData = BrandModel();

  _reset() {
    formData = BrandModel();
    formKey.currentState!.reset();
    myDS.requestBodyApi.params = formData.toJson();
    myDS.loadData();
  }

  _query() {
    formKey.currentState?.save();
    myDS.requestBodyApi.params = formData.toJson();
    myDS.loadData();
  }

  _edit({BrandModel? brandModel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          child:
              // BrandEdit(
              //   brandModel: brandModel,
              // ),
              Container()),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myDS.context = context;
    myDS.state = this;
    myDS.page.pageSize = rowsPerPage;
    myDS.addListener(() {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          TroInput(
            label: '品牌名称',
            value: formData.name,
            onSaved: (v) {
              formData.name = v;
            },
          ),
          // TroSelect(
          //   label: 'personDepartment',
          //   value: formData.deptId,
          //   dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT),
          //   onSaved: (v) {
          //     formData.deptId = v;
          //   },
          // ),
        ],
      ),
    );

    var buttonBar = ButtonBar(
      children: <Widget>[
        ButtonWithIcon(
            label: 'query', iconData: Icons.search, onPressed: () => _query()),
        ButtonWithIcon(
            label: 'reset', iconData: Icons.refresh, onPressed: () => _reset()),
        ButtonWithIcon(
            label: 'add', iconData: Icons.add, onPressed: () => _edit()),
        ButtonWithIcon(
          label: 'modify',
          iconData: Icons.edit,
          onPressed: myDS.selectedCount != 1
              ? null
              : () {
                  if (myDS.selectedRowCount != 1) {
                    return;
                  }
                  BrandModel brandModel = myDS.dataList.firstWhere((v) {
                    return v.selected!;
                  });
                  _edit(brandModel: brandModel);
                },
        ),
        ButtonWithIcon(
          label: 'delete',
          iconData: Icons.delete,
          onPressed: myDS.selectedCount < 1
              ? null
              : () {
                  cryConfirm(context, 'confirmDelete', (context) async {
                    List ids = myDS.dataList.where((v) {
                      return v.selected!;
                    }).map<int?>((v) {
                      return v.brandId;
                    }).toList();
                    var result = await BrandApi.removeByIds(ids);
                    if (result.success) {
                      _query();
                    }
                  });
                },
        ),
      ],
    );

    Scrollbar table = Scrollbar(
      controller: scrollController,
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        controller: scrollController,
        children: <Widget>[
          PaginatedDataTable(
            header: Text('brandList'),
            rowsPerPage: rowsPerPage,
            onRowsPerPageChanged: (int? value) {
              setState(() {
                if (value != null) {
                  rowsPerPage = value;
                  myDS.page.pageSize = rowsPerPage;
                  myDS.loadData();
                }
              });
            },
            availableRowsPerPage: <int>[2, 5, 10, 20],
            onPageChanged: myDS.onPageChanged,
            columns: <DataColumn>[
              DataColumn(
                label: Text('name'),
              ),
              DataColumn(
                label: Text('description'),
              ),
              DataColumn(
                label: Text('logo'),
              ),
              DataColumn(
                label: Text('firstLetter'),
              ),
              DataColumn(
                label: Text('sort'),
              ),
              DataColumn(
                label: Text('operating'),
              ),
            ],
            source: myDS,
          ),
        ],
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          form,
          buttonBar,
          Expanded(
            child: table,
          ),
        ],
      ),
    );
  }
}

class MyDS extends DataTableSource {
  MyDS();

  late BrandListState state;
  late BuildContext context;
  late List<BrandModel> dataList;
  int selectedCount = 0;
  RequestBodyApi requestBodyApi = RequestBodyApi();
  PageModel page = PageModel();

  sort(column, ascending) {
    loadData();
  }

  loadData() async {
    requestBodyApi.page = page;
    ResponseBodyApi responseBodyApi =
        await BrandApi.list(requestBodyApi.toMap());
    page = PageModel.fromJson(responseBodyApi.data);
    dataList = page.list!.map<BrandModel>((v) {
      BrandModel brandModel = BrandModel.fromJson(v);
      print(brandModel.name);
      brandModel.selected = false;
      return brandModel;
    }).toList();
    selectedCount = 0;
    notifyListeners();
  }

  onPageChanged(firstRowIndex) {
    page.currPage = firstRowIndex / page.pageSize + 1;
    loadData();
  }

  @override
  DataRow? getRow(int index) {
    var dataIndex = index - page.pageSize! * (page.currPage! - 1);

    if (dataIndex >= dataList.length) {
      return null;
    }
    BrandModel brandModel = dataList[dataIndex];

    return DataRow.byIndex(
      index: index,
      selected: brandModel.selected!,
      onSelectChanged: (bool? value) {
        brandModel.selected = value;
        selectedCount += value! ? 1 : -1;
        notifyListeners();
      },
      cells: <DataCell>[
        DataCell(Text(brandModel.name ?? '--')),
        DataCell(Text(brandModel.descript ?? '--')),
        DataCell(Text(brandModel.logo ?? '--')),
        DataCell(Text(brandModel.firstLetter ?? '--')),
        DataCell(Text(brandModel.sort.toString() ?? '--')),
        DataCell(ButtonBar(
          // alignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                state._edit(brandModel: brandModel);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                cryConfirm(context, 'confirmDelete', (context) async {
                  var result = await BrandApi.removeByIds([brandModel.brandId]);
                  if (result.success) {
                    loadData();
                  }
                });
              },
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => page.totalCount ?? 0;

  @override
  int get selectedRowCount => selectedCount;
}

void cryConfirm(BuildContext context, String content, onConfirm) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('information'),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('confirm'),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm(context);
            },
          ),
        ],
      );
    },
  );
}
