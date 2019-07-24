import 'package:flutter/material.dart';
import '../../service/contract4OAAPI.dart';
import '../../tabs.dart';
import '../../untils/ProgressDialog.dart';
import '../../models/loginUser.dart';

List _dataList = new List();
var sales = currentUser.userName;
var bDate;
var eDate;
var customer;
var status;
var qydw;
bool _isSucess = true;
bool _loading = false;

// List lt = [
//   new ContractDetail("pz", "hkdj", " yfj", "fhcj"),
//   new ContractDetail("pz1", "hkdj1", " yfj1", "fhcj1")
// ];

class ContractQuery extends StatefulWidget {
  final arguments;
  ContractQuery({this.arguments});
  _ContractQueryState createState() => _ContractQueryState();
}

class _ContractQueryState extends State<ContractQuery> {
  @override
  void initState() {
    // TODO: implement initState
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
        : DateTime.now().toString().substring(0, 10); //默认结束日期为今天

    customer =
        this.widget.arguments != null ? this.widget.arguments["customer"] : "";
    status =
        this.widget.arguments != null ? this.widget.arguments["status"] : "";
    qydw = this.widget.arguments != null ? this.widget.arguments["qydw"] : "";
    _getContractList();

    // _dataList = [
    //   new Contract4OA(true, "", "approveStatus", "jsfs", "customerTitle",
    //       "sqrq", "qdzl", "ysfs", "approver", "qydw", lt),
    // ];
  }

  List<Widget> getData(List arg) {
    List<Widget> list = new List();
    for (var i = 0; i < arg.length; i++) {
      list.add(Container(
        child: ListTile(
          title: Text("品种:" +
              arg[i].pz +
              ", 货款单价:" +
              arg[i].hkdj +
              ", 发货厂家:" +
              arg[i].fhcj +
              ", 运费单价:" +
              arg[i].yfj),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color: Colors.white70, width: .5),
        ),
      ));
    }
    return list;
  }

  Future _getContractList() async {
    Contract4OAAPI.getContractList(sales, bDate, eDate,
            customer: customer, contractStatus: status, qydw: qydw)
        .then((contract4OA) {
      setState(() {
        _dataList = contract4OA.contract4OAList;
        _isSucess = _dataList[0].isSucess;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //此处应该有更好的控制路由方式
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: '后退',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => Tabs()),
                  (route) => route == null);
              ;
            }),
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
                    style: TextStyle(fontSize: 24, color: Colors.red[400]),
                  ),
                )
              : ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ExpansionTile(
                        title: Text(
                          "客户名称:" +
                              _dataList[index].customerTitle +
                              ", 合同日期:" +
                              _dataList[index].sqrq +
                              ", 状态:" +
                              _dataList[index].approveStatus +
                              ", 签约单位:" +
                              _dataList[index].qydw +
                              ", 结算方式:" +
                              _dataList[index].jsfs +
                              ", 运输方式:" +
                              _dataList[index].ysfs +
                              ", 合同总量:" +
                              _dataList[index].qdzl +
                              "吨, 当前审批人:" +
                              _dataList[index].approver,
                          style: _dataList[index].approveStatus == "签批通过"
                              ? TextStyle(color: Colors.black)
                              : TextStyle(color: Colors.red),
                        ),
                        children: getData(_dataList[index].detailList),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(233, 233, 233, 1), width: 1),
                      ),
                    );
                  },
                ),
    );
  }
}
