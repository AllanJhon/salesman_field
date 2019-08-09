import 'package:flutter/material.dart';
import '../../service/CustomerMoneyAPI.dart';
import '../../untils/ProgressDialog.dart';
import '../../models/loginUser.dart';

List _dataList = new List();
bool _isSucess = false;
bool _loading = false;
var customerName;
var customerCode;
var saleCode = currentUser.salesCode;
var saleOfficeCode = currentUser.salesOffice;
bool _isTable = true;
var msg;

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
  }

  Future _getCustomerMoney() async {
    _loading = true;
    CustomerMoneyAPI.xml2List(customerCode, saleCode, saleOfficeCode)
        .then((customerMoney) {
      setState(() {
        _dataList = customerMoney.customerMoneyList;
        _isSucess = _dataList !=null ? _dataList[0].isSucess : _isSucess;
        msg = _dataList != null ? _dataList[0].message : "未取到数据!";
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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.toys),
                tooltip: '切换',
                onPressed: () {
                  setState(() {
                    _isTable = !_isTable;
                  });
                }),
          ],),
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
                    msg,
                    style: TextStyle(fontSize: 22, color: Colors.red[400]),
                  ),
                )
             : _isTable?
              new Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTable(
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
                              " 应收账款余额",
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
                                  return double.parse(a.money)
                                      .compareTo(double.parse(b.money));
                                });
                              });
                            },
                          ),
                          DataColumn(
                            label: Text(
                              '订单未提金额',
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
                                  return double.parse(a.ddwqje)
                                      .compareTo(double.parse(b.ddwqje));
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
                              DataCell(Text(
                                customerMoney.ddwqje,
                                style: TextStyle(fontSize: 15),
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        title: Text(_dataList[index].qydw),
                        subtitle: Text("应收账款余额: " +
                            _dataList[index].money +
                            "元,  订单未提金额: " +
                            _dataList[index].ddwqje +
                            "元"),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              width: 1)),
                    );
                  },
                ),
    );
  }
}
