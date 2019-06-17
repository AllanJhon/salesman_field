import 'package:flutter/material.dart';
import 'tabs.dart';

class User {
  final String account, email;

  const User({
    this.account,
    this.email,
  });
}
class LoginPageZ extends StatefulWidget {
  @override
  _LoginPageZState createState() => _LoginPageZState();
}

class _LoginPageZState extends State<LoginPageZ> {

  var _usernameController =  TextEditingController();
  var _emailController =  TextEditingController();

  void showAlertDialog(BuildContext context,String alertText) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(alertText),
                RaisedButton(
                  child: Text('确定'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new SingleChildScrollView(
            child:Container(
        child: Column(
      children: <Widget>[
        Padding(
          child:  FadeInImage.assetNetwork(
            fadeInDuration: const Duration(seconds: 1),
            fadeInCurve: Curves.bounceIn,
            placeholder: 'assets/images/normal_user_icon.png',
            image: 'http://5b0988e595225.cdn.sohucs.com/images/20171030/26ed195281334ba4b1752394b60eb29a.jpeg',
            height: 200,
            width: 200,
          ), 
          padding: EdgeInsets.only(top: 30.0),
        ),
        Padding(
        padding: const EdgeInsets.all(30.0),
        child: TextField(
          // keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.person),
            labelText: '账号',
            helperText: '请输入你的账号',
          ),
          controller: _usernameController,
          autofocus: false,
        )),
        Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 30.0,right: 30.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.lock),
            labelText: '密码',
            helperText: '请输入你的密码',
          ),
          controller: _emailController,
          obscureText: true,
        )),
         RaisedButton(
          child: Text("登录"),
          onPressed: () {
            //  Navigator.pushNamed(context, "/tabs");
            Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => Tabs()), (route) => route == null);
             /*
            if(_usernameController.text=='admin'&&_emailController.text=='123456'){
              Navigator.pushNamed(context, "/tabs");
                /* 迎乐的路由
               Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => AppPage(title: '唐山市盾石信息技术有限公司')
              ), (route) => route == null);
              */
            }else{
              showAlertDialog(context, '账号密码输入错误，请重试！');
            }
            */
          },
        )
      ],
      ),
            ))
    );
  }
}