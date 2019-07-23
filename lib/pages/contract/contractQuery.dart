import 'package:flutter/material.dart';
import 'package:salesman_field/models/contract4OA.dart';
import '../../service/contract4OAAPI.dart';

List _dataList = new List();
var sales = "10810111";
var bDate;
var eDate;
var customer;
var status;
var qydw;
bool _isSucess;

class ContractQuery extends StatefulWidget {
  final arguments;
  ContractQuery({this.arguments});
  _ContractQueryState createState() => _ContractQueryState();
}

class _ContractQueryState extends State<ContractQuery> {
  @override
  void initState() {
    super.initState();
    _dataList.clear();
    bDate = this.widget.arguments != null
        ? this.widget.arguments["vBegDate"]
        : DateTime.now()
            .add(new Duration(days: -14))
            .toString()
            .substring(0, 10); //默认开始日期为两周前

    eDate = this.widget.arguments != null
        ? this.widget.arguments["vEendDate"]
        : DateTime.now()
            .toString()
            .substring(0, 10); //默认结束日期为今天

    customer =
        this.widget.arguments != null ? this.widget.arguments["customer"] : "";
    status =
        this.widget.arguments != null ? this.widget.arguments["status"] : "";
    qydw = this.widget.arguments != null ? this.widget.arguments["qydw"] : "";

    _getContractList();
  }

  Future _getContractList() async {
    Contract4OAAPI.getContractList(sales, bDate, eDate,
            customer: customer, contractStatus: status, qydw: qydw)
        .then((contract4OA) {
      setState(() {
        _dataList = contract4OA.contract4OAList;
        _isSucess = _dataList[0].isSucess;
        // _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // leading: new IconButton(
        //   icon: new Icon(Icons.arrow_back),
        //   tooltip: '后退',
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/tabs');
        //   },
        // ),
        centerTitle: true,
        title: new Text(
          '合同审批查询',
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {
                Navigator.pushNamed(context, '/contractQuerySearch');
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              isThreeLine: true,
              title: Text(
                "客户名称:" +
                    _dataList[index].customerTitle +
                    ",  合同日期:" +
                    _dataList[index].sqrq +
                    ",  状态:" +
                    _dataList[index].approveStatus,
                style: _dataList[index].approveStatus == "签批通过"
                    ? TextStyle(color: Colors.black)
                    : TextStyle(color: Colors.red),
              ),
              subtitle: Text("签约单位:" +
                  _dataList[index].qydw +
                  ",  结算方式:" +
                  _dataList[index].jsfs +
                  ",  运输方式:" +
                  _dataList[index].ysfs +
                  ",  合同总量:" +
                  _dataList[index].qdzl +
                  "吨,  当前审批人:" +
                  _dataList[index].approver),
              onTap: () {
                // Navigator.pushNamed(context, '/billD',
                //     arguments: contractData[index]);
              },
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 1), width: 1)),
          );
        },
      ),
    );
  }
}
