
import 'package:fluro/fluro.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:saller_demo01/components/contract_edit_container.dart';
import 'package:saller_demo01/routers/application.dart';
import '../../env.dart';
import '../../models/customer.dart';
// import 'package:saller_demo01/widgets/BottomNavigationWidget.dart' as BottomNavigationBarDemo;

/*
 * Created by 李卓原 on 2018/9/13.
 * email: zhuoyuan93@gmail.com
 *
 */

class CustomerChoosePage extends StatefulWidget {
  CustomerChoosePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CustomerChoosePage createState() => new _CustomerChoosePage();
}

class _CustomerChoosePage extends State<CustomerChoosePage> {
  List<Customer> list = new List(); //列表要展示的数据
  ScrollController _scrollController = ScrollController(); //listview的控制器
  final BehaviorSubject<Customer> _customer = BehaviorSubject();
  Observable<Customer> get customerEnvelope => _customer.stream;
  int _page = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
  }

  /**
   * 初始化list数据 加延时模仿网络请求
   */
  Future getData() async {
    Env.apiClient.getCustomerList(_page).then((customerEnvelope) {
      var newCustomerEnvelope = customerEnvelope;
      if (_customer.value != null) {
        newCustomerEnvelope.customers = _customer.value.customers
          ..addAll(customerEnvelope.customers);
      }
      _customer.add(newCustomerEnvelope);
      setState(() {
      list=_customer.value.customers;
      isLoading = false;
      });      
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('客户选择'),),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: list.length + 1,
          controller: _scrollController,
        ),
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
    return _getMoreWidget();
  }

  /**
   * 下拉刷新方法,为list重新赋值
   */
  Future<Null> _onRefresh() async {
    _page=0;
    Env.apiClient.getCustomerList(_page).then((customerEnvelope) {
      var newCustomerEnvelope = customerEnvelope;

      if (_customer.value != null) {
        newCustomerEnvelope.customers = _customer.value.customers
          ..addAll(customerEnvelope.customers);
      }
      _customer.add(newCustomerEnvelope);
      setState(() {
      list=_customer.value.customers;
      isLoading = false;
      });
    });
  }

  /**
   * 上拉加载更多
   */
  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      Env.apiClient.getCustomerList(_page).then((customerEnvelope) {
      var newCustomerEnvelope = customerEnvelope;
      print('加载更多');
      if (_customer.value != null) {
        newCustomerEnvelope.customers = _customer.value.customers..addAll(customerEnvelope.customers);
      }
      _customer.add(newCustomerEnvelope);
      setState(() {
      list=_customer.value.customers;
      isLoading = false;
      });
    });
    }
  }

  /**
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    if(isLoading){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}