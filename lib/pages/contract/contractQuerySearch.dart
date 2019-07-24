import 'package:flutter/material.dart';

var _bDate =
    DateTime.now().add(new Duration(days: -14)).toString().substring(0, 10);
var _eDate = DateTime.now().toString().substring(0, 10);
TextEditingController bDateController =
    TextEditingController.fromValue(TextEditingValue(text: _bDate));
TextEditingController eDateController =
    TextEditingController.fromValue(TextEditingValue(text: _eDate));
TextEditingController customerController = TextEditingController();
String _selectValue;

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

    _goSearch() {
    var cusName = customerController.text;
    customerController.clear();

    Navigator.popAndPushNamed(context, '/contractQuery', arguments: {
      "vBegDate": _bDate, 
      "vEendDate": _eDate,
      "customer": cusName,
      "status": _selectValue
    });

  }

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    items.add(DropdownMenuItem(child: Text('审批中'), value: '1'));
    items.add(DropdownMenuItem(child: Text('审批通过'), value: '2'));
    items.add(DropdownMenuItem(child: Text('驳回'), value: '0'));
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
            _goSearch();
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
                      child: Text('审批状态:'),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: new DropdownButton(
                              items: getListData(),
                              underline: new Text(''),
                              hint: new Text('请选择审批状态'),
                              icon: Icon(null),
                              value: _selectValue,
                              onChanged: (T) {
                                setState(() {
                                  _selectValue = T;
                                });
                              },
                              elevation: 24,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.arrow_drop_down,),),
                          ),
                        ],
                      )
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
