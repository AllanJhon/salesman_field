
import 'package:flutter/material.dart';
import '../../models/contractDetail.dart';
import '../../components/contract_edit_container.dart';
import '../../models/dictionary.dart';

class ContractDetailAddPage extends StatefulWidget {
  final String customerName;
  final String takeType;
 
  ContractDetailAddPage({Key key, this.customerName,this.takeType}): super(key: key);
  @override
  _ContractDetailAddPageState createState() => _ContractDetailAddPageState();
}

class _ContractDetailAddPageState extends State<ContractDetailAddPage> {
  int groupValue = 1;
  List<Dictionary> _customerGroup=new List<Dictionary>();//客户组
  String _factCustomerGroup;
  Color _color=Colors.white;
  onChange(val) {
    this.setState(() {
      groupValue = val;
    });
  }

  @override
  void initState() {
    super.initState();
    getDictionarys();
  }

  void getDictionarys(){
    Dictionary dictionary=new Dictionary(key:'Z100',value:'一般客户');
    Dictionary dictionary1=new Dictionary(key:'Z200',value:'集团内客户');
    _customerGroup.add(dictionary);
    _customerGroup.add(dictionary1);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('新增合同子页'),
        actions:<Widget>[
            new IconButton(
              tooltip: '保存',
              onPressed: () {
                ContractDetail contractDetail=ContractDetail(cementType: '普通硅酸盐水泥^散装^盾石',count: '10',deliveryEnterprise:'唐山乐山水泥厂',
                groups:'一般客户',saleRegion:'唐山市路北区',loanRate:'10.0',freightPrice:'0');
                Navigator.pop(context, contractDetail);

                // Map  mapValue = {'cementType' : '普通硅酸盐水泥^散装^盾石','count': '10','deliveryEnterprise':'唐山乐山水泥厂',
                // 'groups':'一般客户','saleRegion':'唐山市路北区','loanRate':'10.0','freightPrice':'0'};
                // String jsonString = json.encode(mapValue);
                // var jsons = jsonEncode(Utf8Encoder().convert(jsonString));
                // Application.router
                // .navigateTo(context, "contract/detailAddR?informationString=${jsons}", transition: TransitionType.inFromRight);
              },
              icon: Icon(Icons.save),
            ),]
      ),
      body: new SingleChildScrollView(
        controller: new ScrollController(initialScrollOffset: 0.0,keepScrollOffset: true),
            child:WillPopScope(
        onWillPop: () {
          return back();
        },
        child:
        Container(
          
          child: Column(
            children: <Widget>[
              // Padding(
              // padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              // ),
              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('客户名称'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(widget.customerName),
                  ),

                 
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('水泥品种'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('请选择'),
                  ),
                  Expanded(
                    flex: 1,
                    child:Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.arrow_drop_down,),),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('数量'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('发货企业'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('请选择'),
                  ),
                  Expanded(
                    flex: 1,
                    child:Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.arrow_drop_down,),),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 100,
                    child:Text('客户组'),
                  ),
                  Expanded(
                    flex: 180,
                    child: DropdownButton<String>(
                    value: _factCustomerGroup,
                    icon: Icon(null),
                    underline: new Text(''),
                    hint:Text('请选择',maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,),
                    // Expanded(
                    //   child: Text('请选择正确的客户组121',maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,),
                    // ), 
                    onChanged: (String newValue) {
                    setState(() {
                      _factCustomerGroup = newValue;
                    });
                    },
                    items: _customerGroup.map<DropdownMenuItem<String>>((Dictionary dictionary) {
                      return DropdownMenuItem<String>(
                      value: dictionary.key,
                      child: Text(dictionary.value),
                    );
                    }).toList(),
                  ),
                  ),
                  Expanded(
                    flex: 20,
                    child:Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.arrow_drop_down,),),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('销往地区'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('请选择'),
                  ),
                  Expanded(
                    flex: 1,
                    child:Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.arrow_drop_down,),),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('贷款价格'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('运费价格'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(enabled: false,),
                  ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('删除子项目', style: TextStyle(color: Colors.red,fontSize: 18),),
                  ),
                  
                  Expanded(
                    flex: 1,
                    child: Container(height: 40.0,),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),

            ],
          ),
        )
        ))
        
    );
  }

  

  Future<bool> back() {
     Navigator.pop(context);
     return Future<bool>.value(false);
  }

   void showAlertDialog(BuildContext context) {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return  SimpleDialog(
          title:  Text('选择'),
          children: <Widget>[
             SimpleDialogOption(
              child:  Text('选项 1'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             SimpleDialogOption(
              child:  Text('选项 2'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}