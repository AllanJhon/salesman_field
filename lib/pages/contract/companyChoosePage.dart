
import 'package:flutter/material.dart';
import '../../models/company.dart';
import '../../components/contract_edit_container.dart';

/*
 * Created by ZYL on 2019/7/05.
 * email: yingle1991@gmail.com
 *
 */

class CompanyChoosePage extends StatefulWidget {
  CompanyChoosePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CompanyChoosePage createState() => new _CompanyChoosePage();
}

class _CompanyChoosePage extends State<CompanyChoosePage> {
  List<Company> list = new List(); //列表要展示的数据
  // ScrollController _scrollController = ScrollController(); //listview的控制器
  // final BehaviorSubject<Customer> _customer = BehaviorSubject();
  // Observable<Customer> get customerEnvelope => _customer.stream;
  // int _page = 1; //加载的页数
  // bool isLoading = false; //是否正在加载数据

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
    Company company=new Company(name:'盾石信息',code:'TTX');
    list.add(company);
    Company company1=new Company(name:'冀东水泥',code:'JIDD');
    list.add(company1);
   });
  
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('签约单位选择'),),
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
    // else
    // return Text('程序员正在解决的路上...');
  }

}