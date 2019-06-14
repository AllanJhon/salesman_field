import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:saller_demo01/components/contract_edit_container.dart';
import 'package:saller_demo01/models/dictionary.dart';
import 'package:saller_demo01/pages/bill/billPage.dart';
import 'package:saller_demo01/routers/application.dart';

import 'contractAdd_detailList.dart';

class ContractAddPage1 extends StatefulWidget {
  @override
  _ContractAddPageState1 createState() => _ContractAddPageState1();
}

class _ContractAddPageState1 extends State<ContractAddPage1> {
  int groupValue = 1;
  Color _color=Colors.white;
  String _contract_type='合同类型';
  String contract_type;
  String take_type;
  DictionaryControlModel dictionaryControl = new DictionaryControlModel();

  List<Dictionary> _contract_types=new List<Dictionary>();//合同类型
  List<Dictionary> _agreement_types=new List<Dictionary>();//补充协议类型
  List<Dictionary> _fact_contract_types=new List<Dictionary>();//补充协议类型
  List<Dictionary> _take_types=new List<Dictionary>();//提货方式

  @override
  void initState() {
    super.initState();
    getDictionarys();
  }

  getDictionarys() async{
    List<Dictionary> d_contract_types = await dictionaryControl.getDictionaryByType('contract_type');
    print(d_contract_types);
    if (d_contract_types.isNotEmpty&&d_contract_types.length>=1 && this.mounted) {
      setState(() {
        _contract_types = d_contract_types;
        _fact_contract_types=_contract_types;
      });
    }
    List<Dictionary> d_agreement_types = await dictionaryControl.getDictionaryByType('agreement_type');
    if (d_agreement_types.isNotEmpty&&d_agreement_types.length>=1 && this.mounted) {
      setState(() {
        _agreement_types = d_agreement_types;
      });
    }
    List<Dictionary> d_take_types = await dictionaryControl.getDictionaryByType('take_type');
    if (d_take_types.isNotEmpty&&d_take_types.length>=1 && this.mounted) {
      setState(() {
        _take_types = d_take_types;
      });
    }
  }


  onChange(val) {
    this.setState(() {
      if(groupValue != val){
        print(val);
        contract_type=null;
        groupValue = val;
        if(val==1){
          _fact_contract_types=_contract_types;
        }else{
          _fact_contract_types=_agreement_types;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('合同新增'),
        actions:<Widget>[
            new IconButton(
              tooltip: '增加子项',
              onPressed: () {
                // // Navigator.popUntil(context, ModalRoute.withName('/'));
                // Application.router
                //         .navigateTo(context, "contract/detailAdd", transition: TransitionType.inFromRight);
                showDialog<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return  SimpleDialog(
                      title:  Text("正在上传..."),
                      children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child:LinearProgressIndicator(),
                      ),
                      ],
                    );
                  },
                );
                
              },
              icon: Icon(Icons.save_alt),
            ),]
      ),
      body: new SingleChildScrollView(
        controller: new ScrollController(initialScrollOffset: 0.0,keepScrollOffset: true),
            child:WillPopScope(
        onWillPop: () {
          return back();
        },
        child:Column(children: <Widget>[
        Container( 
          child: Column(
            children: <Widget>[
              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('客户名称'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('唐山乐山教育局'),
                  ),
                  Expanded(
                    flex: 1,
                    child:Align(alignment: FractionalOffset.topRight,child:  Icon(Icons.chevron_right,),),
                  ),
                ],
              ),
              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                  flex: 3,
                  child: new Container(
                  child:
                    Container())),
                Expanded(
                  flex: 1,
                  child: new Container(
                  alignment: Alignment.center,
                  child:
                    Radio(
                      value: 1,
                      groupValue: groupValue,//当value和groupValue一致的时候则选中
                      onChanged: (T){
                        setState(() {
                          onChange(T);
                          _contract_type="合同类型";
                        });
                        
                      }
                    ))),
                Expanded(
                  flex: 2,
                  child: 
                    Text('合同')),
                Expanded(
                  flex: 1,
                  child: new Container(
                  alignment: Alignment.center,
                  child:
                    Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (T){
                        onChange(T);
                        setState(() {
                          _contract_type="补充协议类型";
                        });
                      }
                    ),
                )),
                Expanded(
                  flex: 2,
                  child: Text('补充协议'),
                ),
                Expanded(
                  flex: 3,
                  child: new Container(
                  child:
                    Container())),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child:Text(_contract_type),
                  ),
                  Expanded(
                    flex: 15,
                    child:
                  DropdownButton<String>(
                    value: contract_type,
                    icon: Icon(null),
                    underline: new Text(''),
                    hint: const Text('请选择正确的类型               '),
                    onChanged: (String newValue) {
                    setState(() {
                      contract_type = newValue;
                    });
                    },
                    items: _fact_contract_types.map<DropdownMenuItem<String>>((Dictionary dictionary) {
                      return DropdownMenuItem<String>(
                      value: dictionary.value,
                      child: Text(dictionary.value),
                    );
                    }).toList(),
                  ),),
                   Expanded(
                    flex: 5,
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
                    child:Text('主合同号'),
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
                    flex: 10,
                    child:Text('提货方式'),
                  ),
                  Expanded(
                    flex: 15,
                    child:
                  DropdownButton<String>(
                    value: take_type,
                    icon: Icon(null),
                    underline: new Text(''),
                    hint: Container(child:Row(
                      children: <Widget>[
                       const Text('请选择正确的提货方式',),
               
                    ],) ,),
                    
                    onChanged: (String newValue) {
                    setState(() {
                      take_type = newValue;
                    });
                    },
                    items: _take_types.map<DropdownMenuItem<String>>((Dictionary dictionary) {
                      return DropdownMenuItem<String>(
                      value: dictionary.value,
                      child: Text(dictionary.value),
                    );
                    }).toList(),
                  ),),
                  Expanded(
                    flex: 5,
                    child:Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.arrow_drop_down,),),
                  ),
                ],
              ),

              ContractEditContainer(
                // color: Colors.grey,
                onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('结算方式'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(child: Text('预付款',style: TextStyle(color: Colors.black),),color: Colors.grey,) 
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Container(),
                  // ),
                ],
              ),

              ContractEditContainer(onTap: () {
                  setState(() { });
                },
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Text('合同总量'),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(keyboardType: TextInputType.number),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              // Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),),
              Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),child: Row(
              children: <Widget>[Expanded(
                    flex: 1,
                    child:Text('合同详细'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){ Application.router
                        .navigateTo(context, "contract/detailAdd", transition: TransitionType.inFromRight);},
                      child: Row(children: <Widget>[Icon(Icons.add_circle),Text('新增详细')],),),
                  ),],),),
            
                
            ],
          ),
        ),
        Container(
          color: Colors.white,
                  height: MediaQuery.of(context).size.height-80,
                  child: ContractAddDetailListWidget(),
                ),
        ],)
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