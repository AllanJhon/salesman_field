import 'package:flutter/material.dart';
import '../../service/CustomerMoneyAPI.dart';
import '../../untils/ProgressDialog.dart';
import '../../models/loginUser.dart';

List _dataList = new List();
bool _isSucess = true;
bool _loading = false;
var customerName;
var customerCode;
var saleCode = currentUser.salesCode;
var saleOfficeCode = currentUser.salesOffice;

class CustomerDetail extends StatefulWidget {
  final arguments;
  CustomerDetail({Key key, this.arguments}) : super(key: key);
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  int _sortColumnIndex = 1;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    customerName =
        this.widget.arguments != null ? this.widget.arguments["name"] : "";
    customerCode =
        this.widget.arguments != null ? this.widget.arguments["code"] : "";

    _dataList.clear();
    _getCustomerMoney();

    // CustomerMoney customerMoney0 =
    //     new CustomerMoney(true, "", "陕西可达设备安装有限公司", "2315852.3");
    // CustomerMoney customerMoney1 =
    //     new CustomerMoney(true, "", "陕西迅通电梯有限公司", "809124.8");
    // CustomerMoney customerMoney2 =
    //     new CustomerMoney(true, "", "唐山市特种水泥有限公司", "324");
    // _dataList.add(customerMoney0);
    // _dataList.add(customerMoney1);
    // _dataList.add(customerMoney2);
  }

  Future _getCustomerMoney() async {
    _loading = true;
    CustomerMoneyAPI.xml2List(customerCode, saleCode, saleOfficeCode)
        .then((customerMoney) {
      setState(() {
        _dataList = customerMoney.customerMoneyList;
        _isSucess = _dataList.length > 0 ? _dataList[0].isSucess : _isSucess;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("$customerName"),
        centerTitle: true,
      ),
      body: _loading
          ? new Center(
              child: ProgressDialog(
              loading: _loading,
              msg: '正在加载...',
              child: Center(),
            ))
          : !_isSucess
              ? new Center(
                  child: Text(
                    _dataList[0].message,
                    style: TextStyle(fontSize: 22, color: Colors.red[400]),
                  ),
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView(
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: [
                          DataColumn(
                            label: Text(
                              "公司描述",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '余额(元)',
                              style: TextStyle(fontSize: 16),
                            ),
                            onSort: (int index, bool ascending) {
                              setState(() {
                                _sortColumnIndex = index;
                                _sortAscending = ascending;
                                _dataList.sort((a, b) {
                                  if (!ascending) {
                                    final c = a;
                                    a = b;
                                    b = c;
                                  }
                                  // 按照标题内容的长度排序
                                  return double.parse(a.money)
                                      .compareTo(double.parse(b.money));
                                });
                              });
                            },
                          ),
                        ],
                        rows: _dataList.map((customerMoney) {
                          return DataRow(
                            cells: [
                              DataCell(Text(
                                customerMoney.qydw,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              )),
                              DataCell(Text(
                                customerMoney.money,
                                style: TextStyle(fontSize: 15),
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
    );
  }
}
