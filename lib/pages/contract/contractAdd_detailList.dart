import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/contractDetail.dart';

class ContractAddDetailListWidget extends StatefulWidget {
  final List<ContractDetail> contractDetails;
  ContractAddDetailListWidget({Key key,this.contractDetails = const <ContractDetail>[]}) : super(key: key);
  _ContractAddDetailListState createState() => _ContractAddDetailListState();
}

class _ContractAddDetailListState extends State<ContractAddDetailListWidget> {
  // int warningNum = 100;
  
  @override
  Widget build(BuildContext context) {
    // return ListView(children: this._getBillData1(context));
    // return ListView.builder(
    //   itemCount: billData.length,
    //   itemBuilder: (context, index) {
    //     return Container(
          
    //       child: ListTile(
    //         title: Text(
    //           "" +
    //               billData[index]["客户编码"] +
    //               ""),
    //         subtitle: Text("" +
    //             " 销往:" +
    //             billData[index]["销往地区"]),
    //         onTap: () {
    //           // Navigator.pushNamed(context, '/billD',
    //           //     arguments: billData[index]);
    //         },
    //       ),
    //       decoration: BoxDecoration(
    //           border: Border.all(
    //               color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
    //     );
    //   },
    // );
      return Column(
      children: _buildColumns(context),
      );
  }

  List<Widget> _buildColumns(context) {
    List<Widget> _listRows = [];
    _listRows = [];
    for (int i = 0, length = widget.contractDetails.length; i < length; i ++) {
        ContractDetail item = widget.contractDetails[i];
          _listRows.add(new Material(
              color: Colors.white,
              child:InkWell(
              onTap: (){},
            child:
            Container(
              decoration: new BoxDecoration(
              // color: Colors.white,
              border: Border(
                    bottom: const BorderSide(
                    width: 1.0,color:Color(0xFFEFEFEF))),
              ),
              child: 
              ListTile(
                title: Text(
                  "水泥品种:" +
                      item.cementType +
                      ",发货企业:" +
                      item.deliveryEnterprise+
                      "客户组:" +
                      item.groups+
                      ",销往地区:" +
                      item.saleRegion),
                subtitle: Text("" +
                    " 数量:" +
                    item.count+
                    ",贷款价格:" +
                      item.loanRate+
                      ",运费价格:" +
                      item.freightPrice),
                onTap: () {
                  // Navigator.pushNamed(context, '/billD',
                  //     arguments: billData[index]);
                },
              ),
            )
          )));
      }
      if(widget.contractDetails==null||widget.contractDetails.length==0){
         _listRows.add(
             Container(child: Text('您未添加任何合同详细')),
          );
      }
    return _listRows;
  }
}
