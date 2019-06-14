/// @author 迎乐

import 'package:flutter/material.dart';
// import 'package:flutter_go/resources/widget_name_to_icon.dart';
import '../untils/style.dart';

String _widgetName;

class WidgetItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final int index; //用于计算border
  final int totalCount;
  final int rowLength;
  final Icon widgetIcon;
  final String textSize;

  WidgetItem(
      {this.title,
      this.widgetIcon,
      this.onTap,
      this.index,
      this.totalCount,
      this.rowLength,
      this.textSize});

  Border _buildBorder(context) {
    Border _border;
    bool isRight = (index % rowLength) == (rowLength - 1); //是不是最右边的,决定是否有右侧边框
    var currentRow = (index + 1) % rowLength > 0
        ? (index + 1) ~/ rowLength + 1
        : (index + 1) ~/ rowLength;
    int totalRow = totalCount % rowLength > 0
        ? totalCount ~/ rowLength + 1
        : totalCount ~/ rowLength;
    if (currentRow < totalRow && isRight) {
      //不是最后一行,是最右边
      _border = Border(
        bottom: const BorderSide(
            width: 1.0, color: Color(WidgetDemoColor.borderColor)),
      );
    }
    if (currentRow < totalRow && !isRight) {
      _border = Border(
        right: const BorderSide(
            width: 1.0, color: Color(WidgetDemoColor.borderColor)),
        bottom: const BorderSide(
            width: 1.0, color: Color(WidgetDemoColor.borderColor)),
      );
    }
    if (currentRow == totalRow && !isRight) {
      _border = Border(
        right: const BorderSide(
            width: 1.0, color: Color(WidgetDemoColor.borderColor)),
      );
    }
    return _border;
  }

  @override
  Widget build(BuildContext context) {
    _widgetName = title.replaceFirst(
        //首字母转为大写
        title.substring(0, 1),
        title.substring(0, 1).toUpperCase());
    final textStyle = (textSize == 'middle')
        ? TextStyle(fontSize: 13.8, fontFamily: 'MediumItalic')
        : TextStyle(fontSize: 16.0);
        Icon _widgetIcon;
        if(widgetIcon==null){
            _widgetIcon=Icon(
              Icons.crop,
            );
        }else{
          _widgetIcon=widgetIcon;
        }
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: new BoxDecoration(
          border: _buildBorder(context),
        ),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
           _widgetIcon,
            SizedBox(
              height: 8.0,
            ),
            Text(_widgetName, style: textStyle),
          ],
        ),
      ),
    );
  }
}
