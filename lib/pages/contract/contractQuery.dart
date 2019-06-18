import 'package:flutter/material.dart';
import '../../data/listData.dart';

class ContractQuery extends StatelessWidget {
  final arguments;
  int warningNum = 100; //先模拟一个预警量的值

  ContractQuery({this.arguments});

  _getFilterListView() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          tooltip: '后退',
          onPressed: () {
            Navigator.pushNamed(context, '/tabs');
          },
        ),
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
        itemCount: contractData.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              isThreeLine:true,
              title: Text(
                "客户名称：" +
                    contractData[index]["客户名称"] +
                    ",  合同日期：" +
                    contractData[index]["合同日期"] +
                    ",  状态：" +
                    contractData[index]["状态"],
                style: contractData[index]["状态"] == "审批通过"
                    ? TextStyle(color: Colors.black)
                    : TextStyle(color: Colors.red),
              ),
              subtitle: Text("签约单位：" +
                  contractData[index]["签约单位"] +
                  ",  结算方式：" +
                  contractData[index]["结算方式"] +
                  ",  运输方式：" +
                  contractData[index]["运输方式"] +
                  ",  合同总量：" +
                  contractData[index]["合同总量"] +
                  "吨,  当前审批人：" +
                  contractData[index]["当前审批人"]),
              onTap: () {
                Navigator.pushNamed(context, '/billD',
                    arguments: contractData[index]);
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
