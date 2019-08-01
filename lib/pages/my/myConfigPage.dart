import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../theme/color.dart';
import '../../theme/provideStore.dart' show Store;
import '../../theme/configModel.dart' show ConfigModel;

class MyConfigPage extends StatefulWidget {
  MyConfigPage({Key key}) : super(key: key);

  _MyConfigPageState createState() => _MyConfigPageState();
}

class _MyConfigPageState extends State<MyConfigPage> {
    Widget Edage(name, color, context) {
    return GestureDetector(
      onTap: () {
        Store.value<ConfigModel>(context).$setTheme(name);
      },
      child: Container(
        color: Color(color),
        height: 50,
        width: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _edageList = [];
    materialColor.forEach((k, v) {
      _edageList.add(this.Edage(k, v, context));
    });

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          '更换主题',
          style: TextStyle(),
        ),
      ),
      body: new Center(
        child: new Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 10,
            runSpacing: 5,
            children: _edageList,
          ),
        ),
      ),
    );
  }
}