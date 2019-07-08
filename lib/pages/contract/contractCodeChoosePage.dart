import 'package:flutter/material.dart';
import 'package:salesman_field/models/contract.dart';
import '../../components/contract_edit_container.dart';
/*
 * Created by ZYL on 2019/7/05.
 * email: yingle1991@gmail.com
 *
 */

class ContractCodeChoosePage extends StatefulWidget {
  ContractCodeChoosePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ContractCodeChoosePage createState() => new _ContractCodeChoosePage();
}

class _ContractCodeChoosePage extends State<ContractCodeChoosePage> {
  List<Contract> list = new List(); //列表要展示的数据

  @override
  void initState() {
    super.initState();
    getData();
  }

  /*
   * 初始化list数据 加延时模仿网络请求
   */
  void getData() {
   
    setState(() {
      Contract contract=new Contract(name:'内蒙古冀东水泥有限责任公司生产管理系统',code:'TTX-XS99-2015-0010');
      list.add(contract);
      Contract contract1=new Contract(name:'唐山冀东水泥股份有限公司机房运维服务合同',code:'TTX-XS01-2017-0003-N');
      list.add(contract1);
   });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('合同选择'),),
      body: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: list.length + 1,
        ),
      //  bottomNavigationBar:BottomNavigationBarDemo.BottomNavigationBarFullDefault(),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    //设置字体样式
    TextStyle textStyle =
        new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
    if (index < list.length) {
       //设置Padding
      return Padding(
        padding: const EdgeInsets.only(left:8.0),
        child: ContractEditContainer(
          height: 60.0,
          onTap: () {
                  Navigator.pop(context, list[index]);
                  // Application.router
                  //       .navigateTo(context, "contract/contract?customerName="+list[index].name, transition: TransitionType.inFromRight);
                },
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Text(list[index].code+"/"+list[index].name,style: textStyle,maxLines: 2,),
                  ),
                  Expanded(
                    flex: 1,
                    child:Align(alignment: FractionalOffset.topRight,child:  Icon(Icons.chevron_right,),),
                  ),
                ],
              ),);
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}