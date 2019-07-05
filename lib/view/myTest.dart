import 'package:flutter/material.dart';
import "dart:math";

double percentRage = 41;
bool isContract = true;

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  _queryContract() {
    String a = "abc";
  
    // a.substring(startIndex)
    setState(() {
      isContract = true;
    });
  }

  _queryBill() {
    setState(() {
      isContract = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("图表"),
          centerTitle: true,
        ),
        body: Container(
            child: Column(children: <Widget>[
          new Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Container(
                    width: 120,
                    height: 120,
                    child: new CustomPaint(
                      foregroundPainter: new MoneyCanvas(Colors.grey[300],
                          Colors.red[400], 83, 40.0),
                      child: new Center(
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("83%"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                    width: 120,
                    height: 120,
                    child: new CustomPaint(
                      foregroundPainter: new MoneyCanvas(Colors.grey[300],
                          Colors.orange[300], 55, 40.0),
                      child: new Center(
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("55%"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                    width: 120,
                    height: 120,
                    child: new CustomPaint(
                      foregroundPainter: new MoneyCanvas(Colors.grey[300],
                          Colors.green[300], percentRage, 40.0),
                      child: new Center(
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("$percentRage%"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // new Container(
          //   width: 120,
          //   height: 120,
          //   child: new CustomPaint(
          //     foregroundPainter: new MoneyCanvas(
          //         Colors.grey[300], Colors.orange[300], percentRage, 40.0),
          //     child: new Center(
          //       // padding: const EdgeInsets.all(8.0),
          //       child: Text("$percentRage%"),
          //     ),
          //   ),
          // ),
          Divider(
            height: 20.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    child: new FlatButton(
                      onPressed: () {
                        _queryContract();
                      },
                      color: isContract ? Colors.grey[350] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.elliptical(15, 15)),
                        side: BorderSide(
                          color: Colors.grey[350],
                          width: 1,
                        ),
                      ),
                      child: new Text(
                        "合同执行情况",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(0, 0.0, 15.0, 0.0),
                    child: new FlatButton(
                      onPressed: () {
                        _queryBill();
                      },
                      color: !isContract ? Colors.grey[350] : Colors.white,
                      child: new Text(
                        "订单执行情况",
                        style: TextStyle(fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.elliptical(15, 15)),
                        side: BorderSide(
                          color: Colors.grey[350],
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  // ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new Container(
            child: Text(isContract ? "执行合同查询" : "执行订单查询"),
          )
        ])));
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
