import 'package:flutter/material.dart';

var _bDate =
    DateTime.now().add(new Duration(days: -14)).toString().substring(0, 10);
var _eDate = DateTime.now().toString().substring(0, 10);
TextEditingController bDateController =
    TextEditingController.fromValue(TextEditingValue(text: _bDate));
TextEditingController eDateController =
    TextEditingController.fromValue(TextEditingValue(text: _eDate));
TextEditingController customerController = TextEditingController();
var _status;

class ContractQuerySearch extends StatefulWidget {
  ContractQuerySearch({Key key}) : super(key: key);

  _ContractQuerySearchState createState() => _ContractQuerySearchState();
}

class _ContractQuerySearchState extends State<ContractQuerySearch> {
  _showDataPicker(flag) async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2099),
        locale: myLocale);
    setState(() {
      if (flag == "B") {
        _bDate = picker.toString().substring(0, 10);
        bDateController.text = _bDate;
      } else if (flag == "E") {
        _eDate = picker.toString().substring(0, 10);
        eDateController.text = _eDate;
      }
    });
  }

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('审批中'),
      value: '审批中',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('审批通过'),
      value: '审批通过',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text('全部'),
      value: '全部',
    );
    items.add(dropdownMenuItem3);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text('合同状态查询条件'), actions: <Widget>[
        new IconButton(
          tooltip: '确定',
          onPressed: () {
            // _goSearch();
          },
          icon: Icon(Icons.check),
        ),
      ]),
      body: Container(
        // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            ),
            Container(
              decoration: new BoxDecoration(
                // color: _color,
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
                      child: Text('开始日期:'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      controller: bDateController,
                      decoration: InputDecoration(
                        suffixIcon: new IconButton(
                          icon: Icon(
                            Icons.watch_later,
                            size: 35,
                          ),
                          onPressed: () {
                            _showDataPicker("B");
                          },
                        ),
                      ),
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
                      child: Text('结束日期:'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.datetime,
                      controller: eDateController,
                      decoration: InputDecoration(
                        suffixIcon: new IconButton(
                          icon: Icon(
                            Icons.watch_later,
                            size: 35,
                          ),
                          onPressed: () {
                            _showDataPicker("E");
                          },
                        ),
                      ),
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
                    child: new DropdownButton(
                      items: getListData(),
                      underline: new Text(''),
                      hint: new Text('请选择合同审批状态'),
                      value: _status, 
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          _status = value;
                        });
                      },
                      elevation: 24, 
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
