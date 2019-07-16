import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../../env.dart';
import '../../models/customer.dart';
import '../../service/customer_api.dart';

TextEditingController customerController = TextEditingController();
FocusNode _contentFocusNode = FocusNode();
String _search;

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CustomerPage createState() => new _CustomerPage();
}

class _CustomerPage extends State<CustomerPage> {
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

  /*
   * 初始化list数据 加延时模仿网络请求
   */
  Future getData() async {
    CustomerAPI.getCustomerList(_page).then((customerEnvelope) {
      var newCustomerEnvelope = customerEnvelope;
      if (_customer.value != null) {
        newCustomerEnvelope.customers = _customer.value.customers
          ..addAll(customerEnvelope.customers);
      }
      _customer.add(newCustomerEnvelope);
      setState(() {
        list = _customer.value.customers;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFileWidget(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, size: 32),
              tooltip: '搜索客户名称',
              onPressed: () async {
                _search = customerController.text;
                _contentFocusNode.unfocus();
                // if (_search == null || _search.isEmpty) {
                //   _showToast("请输入客户名称码");
                //   return;
                // }
                setState(() {
                  // _loading = true;
                  list = list.where((value) {
                    return value.name.toString().contains(_search);
                  }).toList();
                });
                // _filterCustmer();
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: list.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    //设置字体样式
    TextStyle textStyle =
        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
    if (index < list.length) {
      //设置Padding
      return Container(
        child: ListTile(
          title: Text(
            list[index].code,
          ),
          subtitle: Text(list[index].name),
          trailing: new Icon(
            Icons.keyboard_arrow_right,
            size: 18,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/customerDetail',
                arguments: list[index].name);
          },
        ),
        decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(233, 233, 233, 1), width: 1)),
      );
    }
    return _getMoreWidget();
  }

  /*
   * 下拉刷新方法,为list重新赋值
   */
  Future<Null> _onRefresh() async {
    _page = 0;
    CustomerAPI.getCustomerList(_page).then((customerEnvelope) {
      var newCustomerEnvelope = customerEnvelope;

      if (_customer.value != null) {
        newCustomerEnvelope.customers = _customer.value.customers
          ..addAll(customerEnvelope.customers);
      }
      _customer.add(newCustomerEnvelope);
      setState(() {
        list = _customer.value.customers;
        isLoading = false;
      });
    });
  }

  /*
   * 上拉加载更多
   */
  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      CustomerAPI.getCustomerList(_page).then((customerEnvelope) {
        var newCustomerEnvelope = customerEnvelope;
        print('加载更多');
        if (_customer.value != null) {
          newCustomerEnvelope.customers = _customer.value.customers
            ..addAll(customerEnvelope.customers);
        }
        _customer.add(newCustomerEnvelope);
        setState(() {
          list = _customer.value.customers;
          isLoading = false;
        });
      });
    }
  }

  /*
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    if (isLoading) {
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
    super.dispose();
    _scrollController.dispose();
  }
}

class TextFileWidget extends StatelessWidget {
  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      controller: customerController,
      focusNode: _contentFocusNode,
      cursorColor: Colors.black, //设置光标
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(left: 0.0),
          border: InputBorder.none,
          hintText: "请输入客户名称",
          hintStyle: new TextStyle(fontSize: 18, color: Colors.black26)),
      style: new TextStyle(fontSize: 18, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editView() {
      return Container(
        //修饰黑色背景与圆角
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.white10, width: 1.0), //灰色的一层边框
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        ),
        alignment: Alignment.center,
        height: 40,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: buildTextField(),
      );
    }

    var cancleView = new Text("");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: editView(),
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
          ),
          child: cancleView,
        )
      ],
    );
  }
}
