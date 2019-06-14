import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:saller_demo01/routers/application.dart';

class ContractAddPage extends StatefulWidget {
  @override
  _ContractAddPageState createState() => _ContractAddPageState();
}

class _ContractAddPageState extends State<ContractAddPage> {
  int groupValue = 1;
  Color _color=Colors.white;
  onChange(val) {
    this.setState(() {
      groupValue = val;
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
                // Navigator.popUntil(context, ModalRoute.withName('/'));
                Application.router
                        .navigateTo(context, "contract/detailAdd", transition: TransitionType.inFromRight);
              },
              icon: Icon(Icons.add_circle),
            ),]
      ),
      body: WillPopScope(
        onWillPop: () {
          return back();
        },
        child:
        Container(
          
          child: Column(
            children: <Widget>[
              Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),
              Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black; });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  Text('客户名称'),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('唐山乐山教育局'),
                  ),
                  Expanded(
                    flex: 1,
                    child:Align(alignment: FractionalOffset.centerRight,child:  Icon(Icons.chevron_right,),),
                  ),
                ],
              ))),
            
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),
              
              Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black;  });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
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
                        onChange(T);
                      }
                    ))),
                Expanded(
                  flex: 2,
                  child: new Container(
                  child:
                    Text('合同'),)),
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
                      }
                    ),
                )),
                Expanded(
                  flex: 2,
                  child: new Container(
                  child:Text('补充协议'),
                )),
                Expanded(
                  flex: 3,
                  child: new Container(
                  child:
                    Container())),
            ],
              ))),

Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),

              Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black;  });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  Text('补充协议类型'),),
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
              ))),

Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),

            Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black;  });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  Text('主合同号'),),
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
              ))),

Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),

            Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black;  });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  Text('提货方式'),),
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
              ))),

Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),

              Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black;  });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  Text('结算方式'),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('预付款'),
                  ),
                 
                ],
              ))),

Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              ),

            Container(
                decoration: new BoxDecoration(
                    color: _color,
                    border:  Border(
                    bottom: const BorderSide(
                    width: 1.0, color: Color(0xFFEFEFEF)),
                  ),),
                  child: new GestureDetector(
                onTap: () {
                  setState(() { });
                },
                onTapDown:(TapDownDetails details){
                  setState(() {_color=Colors.black;  });
                } ,
                 onTapUp:(TapUpDetails details){
                  setState(() {_color=Colors.white;  });
                } ,
                child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  Text('合同总量'),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('13'),
                  ),
                 
                ],
              ))),


            ],
          ),
        )
        )
        
    );
    // Container(
    //       alignment: Alignment.center,
    //       child: Column(
    //       children:<Widget>[
    //         Padding(
    //           padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
    //         ),
    //         Align(
    //           child:  RaisedButton(
    //             padding:  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    //             //padding
    //             child:  Text(
    //               '请选择客户',
    //               style:  TextStyle(
    //                 fontSize: 18.0, //textsize
    //                 color: Colors.white, // textcolor
    //               ),
    //             ),
    //             color: Theme.of(context).accentColor,
    //             elevation: 4.0,
    //             //shadow
    //             splashColor: Colors.blueGrey,
    //             onPressed: () {
    //               showAlertDialog(context);
    //           }), 
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Expanded(
    //               flex: 3,
    //               child: new Container(
    //               child:
    //                 Container())),
    //             Expanded(
    //               flex: 1,
    //               child: new Container(
    //               alignment: Alignment.center,
    //               child:
    //                 Radio(
    //                   value: 1,
    //                   groupValue: groupValue,//当value和groupValue一致的时候则选中
    //                   onChanged: (T){
    //                     onChange(T);
    //                   }
    //                 ))),
    //             Expanded(
    //               flex: 2,
    //               child: new Container(
    //               child:
    //                 Text('合同'),)),
    //             Expanded(
    //               flex: 1,
    //               child: new Container(
    //               alignment: Alignment.center,
    //               child:
    //                 Radio(
    //                   value: 2,
    //                   groupValue: groupValue,
    //                   onChanged: (T){
    //                     onChange(T);
    //                   }
    //                 ),
    //             )),
    //             Expanded(
    //               flex: 2,
    //               child: new Container(
    //               child:Text('补充协议'),
    //             )),
    //             Expanded(
    //               flex: 3,
    //               child: new Container(
    //               child:
    //                 Container())),
    //         ],
    //       ),
    //       TextField(
    //         textAlign: TextAlign.center,
    //         onChanged: null,
    //         autofocus: false,
    //     )
    //   ]),
    // )
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