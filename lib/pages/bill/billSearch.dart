import 'package:flutter/material.dart';

var _bDate =
    DateTime.now().add(new Duration(days: -14)).toString().substring(0, 10);
var _eDate = DateTime.now().toString().substring(0, 10);

TextEditingController bDateController =
    TextEditingController.fromValue(TextEditingValue(text: _bDate));
TextEditingController eDateController =
    TextEditingController.fromValue(TextEditingValue(text: _eDate));
TextEditingController customerController = TextEditingController();
TextEditingController billController = TextEditingController();

class BillSearch extends StatefulWidget {
  BillSearch({Key key}) : super(key: key);

  _BillSearchState createState() => _BillSearchState();
}

class _BillSearchState extends State<BillSearch> {
  //开始日期默认取两周前
  _showDataPicker(flag) async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2099),
        locale: myLocale);
    setState(() {
      if (picker == null) return;
      if (flag == "B") {
        _bDate = picker.toString().substring(0, 10);
      } else if (flag == "E") {
        _eDate = picker.toString().substring(0, 10);
      }
    });
  }

  _goSearch() {
    var cusName = customerController.text;
    var billNo = billController.text;

    // List filterListDate = billData1.where((value) {
    //   return DateTime.parse(value["创建日期"])
    //           .isAfter(DateTime.parse(vBegDate)) &&
    //       DateTime.parse(value["创建日期"]).isBefore(DateTime.parse(vEendDate)) &&
    //       value["客户编码"].toString().contains(cusName);
    // }).toList();

    // bDateController.clear();
    // eDateController.clear();
    customerController.clear();
    billController.clear();

    Navigator.popAndPushNamed(context, '/bill', arguments: {
      "vBegDate": _bDate.replaceAll("-", ""),
      "vEendDate": _eDate.replaceAll("-", ""),
      "cusName": cusName,
      "billNo": billNo
    });

    // Navigator.pop(context, {
    //   "vBegDate": _bDate.replaceAll("-", ""),
    //   "vEendDate": _eDate.replaceAll("-", ""),
    //   "cusName": cusName,
    //   "billNo": billNo
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text('订单查询条件'), actions: <Widget>[
        new IconButton(
          tooltip: '确定',
          onPressed: () {
            // Navigator.popUntil(context, ModalRoute.withName('/'));
            _goSearch();
          },
          icon: Icon(Icons.check),
        ),
      ]),
      body: Container(
        // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            // ),
            Container(
              decoration: new BoxDecoration(
                border: Border(
                  bottom:
                      const BorderSide(width: 1.0, color: Color(0xFFEFEFEF)),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Text(
                        '开始日期:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          _bDate,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: new IconButton(
                          icon: Icon(
                            Icons.today,
                            size: 26,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _showDataPicker("B");
                          },
                          tooltip: "选择开始日期",
                        ),
                      )
                      // TextField(
                      //   keyboardType:TextInputType.datetime,
                      //   maxLines: 1,
                      //   controller: bDateController,
                      //   decoration: InputDecoration(
                      //     suffixIcon: new IconButton(
                      //       icon: Icon(
                      //         Icons.watch_later,
                      //         size: 35,
                      //       ),
                      //       onPressed: () {
                      //         _showDataPicker("B");
                      //       },
                      //     ),
                      //   ),
                      // ),
                      ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: new BoxDecoration(
                border: Border(
                  bottom:
                      const BorderSide(width: 1.0, color: Color(0xFFEFEFEF)),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Text(
                        '结束日期:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          _eDate,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: new IconButton(
                          icon: Icon(
                            Icons.today,
                            size: 26,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _showDataPicker("E");
                          },
                          tooltip: "选择结束日期",
                        ),
                      )
                      // TextField(
                      //   maxLines: 1,
                      //   keyboardType: TextInputType.datetime,
                      //   controller: eDateController,
                      //   decoration: InputDecoration(
                      //     suffixIcon: new IconButton(
                      //       icon: Icon(
                      //         Icons.watch_later,
                      //         size: 35,
                      //       ),
                      //       onPressed: () {
                      //         _showDataPicker("E");
                      //       },
                      //     ),
                      //   ),
                      // ),
                      ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: new BoxDecoration(
                border: Border(
                  bottom:
                      const BorderSide(width: 1.0, color: Color(0xFFEFEFEF)),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text('客户名称:'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: customerController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: '请输入客户名称',
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: new BoxDecoration(
                border: Border(
                  bottom:
                      const BorderSide(width: 1.0, color: Color(0xFFEFEFEF)),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text('订单编号:'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: billController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: '请输入SAP订单编号',
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
