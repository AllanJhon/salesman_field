import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CustomerPageWidgetState();
  }
}

class CustomerPageWidgetState extends State<CustomerPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('客户'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child:IconContainer(Icons.save, size: 50.0, color: Colors.red), 
                ),
                 Expanded(
                  flex: 2,
                  child:IconContainer(Icons.search, size: 50.0, color: Colors.orange), 
                ),
                 Expanded(
                  flex: 1,
                  child:IconContainer(Icons.home, size: 50.0, color: Colors.blue), 
                ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:Image.network("https://www.itying.com/images/flutter/1.png") ,
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        child: Image.network("https://www.itying.com/images/flutter/2.png"),
                      ),
                      
                      SizedBox(height: 10),
                      Image.network("https://www.itying.com/images/flutter/3.png"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        
        );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  final double size ;
  final Color color ;
  IconContainer(this.icon, {this.size=20, this.color=Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: this.color,
      child: Center(
        child: Icon(this.icon, size: this.size, color: Colors.white),
      ),
    );
  }
}
