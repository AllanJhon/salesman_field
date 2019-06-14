import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/listData.dart';

class ContractAddDetailListWidget extends StatefulWidget {
  ContractAddDetailListWidget({Key key}) : super(key: key);
  _ContractAddDetailListState createState() => _ContractAddDetailListState();
}

class _ContractAddDetailListState extends State<ContractAddDetailListWidget> {
  int warningNum = 100;

  @override
  Widget build(BuildContext context) {
    // return ListView(children: this._getBillData1(context));
    return ListView.builder(
      itemCount: billData.length,
      itemBuilder: (context, index) {
        return Container(
          
          child: ListTile(
            title: Text(
              "" +
                  billData[index]["客户编码"] +
                  ""),
            subtitle: Text("" +
                " 销往:" +
                billData[index]["销往地区"]),
            onTap: () {
              // Navigator.pushNamed(context, '/billD',
              //     arguments: billData[index]);
            },
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
        );
      },
    );
  }
}
