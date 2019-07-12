import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "dart:math";
import "../../models/loginUser.dart";

double percentRage = 41;
bool isContract = true;

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            '我的',
            style: TextStyle(
                // color: Colors.red,
                ),
          ),
        ),
        body: Container(
          child: Column(children: <Widget>[
            new Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: 
                    new Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 120,
                      width: 120,
                      child: new Image.asset(
                        'assets/images/normal_user_icon.png',
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new Container(
                      child: new Center(
                        child: ListTile(
                          title: Text(currentUser.displayName,style: TextStyle(fontSize: 22),),
                          subtitle: Text(currentUser.userName),
                          // trailing: new Icon(
                          //   Icons.keyboard_arrow_right,
                          //   size: 24,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: new Container(
                color: Colors.grey[300],
              ),
            ),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("修改密码"),
                leading: new Icon(
                  Icons.lock_outline,
                  size: 26,
                  color: Colors.green,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/password");
                },
              ),
            ),
            SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("设置"),
                leading: new Icon(
                  Icons.settings,
                  color: Colors.orange[300],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
              ),
            ),
          SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("切换用户"),
                leading: new Icon(
                  Icons.rotate_left,
                  color: Colors.pink[300],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: (){
                  Navigator.popAndPushNamed(context, "/");
                },
              ),
            ),
            SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("退出登录"),
                leading: new Icon(
                  Icons.exit_to_app,
                  color: Colors.red[400],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: (){
                  Navigator.popAndPushNamed(context, "/");
                },
              ),
            ),
          ]),
          color: Colors.grey[100],
        ));
  }
}

//画圆及画弧，显示客户金额消耗情况
class MoneyCanvas extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double argRadius;

  MoneyCanvas(
      this.lineColor, this.completeColor, this.completePercent, this.argRadius);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    //定义画外圆的画布
    Paint _paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = lineColor
      ..strokeWidth = 5;
    //画圆
    canvas.drawCircle(center, argRadius, _paint);

    double arcAngle = 2 * pi * (completePercent / 100);
    // 定义画内弧的画布
    Paint _money = Paint()
      ..color = completeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // //画弧
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: argRadius - 8),
        -pi / 2, //  从正上方开始
        arcAngle,
        false,
        _money);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
