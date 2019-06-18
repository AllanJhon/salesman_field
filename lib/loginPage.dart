import 'package:flutter/material.dart';
/*
 *注册界面
 */
TextEditingController userController = TextEditingController();
TextEditingController pwdController = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
      padding: const EdgeInsets.all(55),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('金隅冀东移动外勤',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('用户登录',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.5,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),

          SizedBox(height: 120),
          new inputEdtextNameWiget(),
          SizedBox(height: 20,),
          new inputEdtextPassWordWiget(),
          SizedBox(height: 30,),
          new loginButtonWiget(),
        ],
      ),

    )
        ),
      )
    );
    
  }
}
//输入用户名
class inputEdtextNameWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Container(
        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: TextField(
          maxLines: 1,
          controller: userController,
          decoration: InputDecoration(
            hintText: '请输入用户名',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
//输入密码
class inputEdtextPassWordWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Container(
        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: pwdController,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: '请输入密码',
            border: InputBorder.none,
          ),
          obscureText:true,
        ),
      ),
    );
  }
}
//登录按钮
class loginButtonWiget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Container(
        padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(30),
        //   color: Colors.deepOrangeAccent,
        // ),
        // alignment: Alignment.center,
        // child: Text(
        //   '登录',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(letterSpacing: 20,
        //   fontWeight: FontWeight.bold,
        //   color: Colors.white70),
        // )
        child: FloatingActionButton.extended(
          onPressed: () {
            // print(userController.text);
            // Navigator.pushNamed(context, "/tabs");
            _log(context);
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrangeAccent,
          //如果不手动设置icon和text颜色,则默认使用foregroundColor颜色
          icon: new Icon(Icons.vpn_key,color: Colors.red,),
          label: new Text('        登   录            ',style: TextStyle(fontSize: 18), maxLines: 1),
        ),
      ),
    );
  }
}


_log(context){
  var user = userController.text;
  var pwd = pwdController.text;

  if (user == null || user.isEmpty){
     showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('用户名不能为空'),
              ));
  return;
  }
   if (pwd==null || pwd.isEmpty){
     showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('密码不能为空'),
              ));
  return;
  }
  //需要校验的逻辑
  if (user=="hh" && pwd=="123"){
     Navigator.pushNamed(context, "/tabs");
  }else{
    showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('用户名密码不正确'),
              ));
     userController.clear();
     pwdController.clear();
  }

}
