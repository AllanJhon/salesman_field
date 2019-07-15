import 'package:flutter/material.dart';

class OutWork extends StatefulWidget {
  OutWork({Key key}) : super(key: key);

  _OutWorkState createState() => _OutWorkState();
}

class _OutWorkState extends State<OutWork> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            '移动外勤',
            style: TextStyle(
                // color: Colors.red,
                ),
          ),
        ),
        body: GridView.count(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          crossAxisSpacing: 2.5,
          mainAxisSpacing: 2.5,
          // padding: EdgeInsets.all(10),
          crossAxisCount: 4,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  CircleAvatar(
                    child: new IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/billN");
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("设置"),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              height: 40,
            ),
            Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    CircleAvatar(
                      child: new IconButton(
                        icon: Icon(Icons.location_on, color: Colors.white),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/test");
                        },
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    SizedBox(height: 10),
                    Text("定位打卡"),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                )),
            Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    CircleAvatar(
                      child: new IconButton(
                        icon: Icon(Icons.spellcheck, color: Colors.white),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                            context,
                            "/arc",
                          );
                        },
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    SizedBox(height: 10),
                    Text("工作日报"),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                )),
            Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    CircleAvatar(
                      child: Icon(
                        Icons.attach_file,
                      ),
                      // backgroundColor: Colors.amber[100],
                    ),
                    SizedBox(height: 10),
                    Text("质量投诉"),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                )),
            Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.vpn_key,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("修改口令"),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                )),
            Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.linear_scale,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("敬请等待"),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                )),
          ],
        ),
        backgroundColor: Color.fromARGB(90, 237, 235, 236));
  }
}
