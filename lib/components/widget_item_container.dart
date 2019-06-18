import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './widget_item.dart';
import '../routers/application.dart';

class WidgetItemContainer extends StatelessWidget {
  final int columnCount; //一行几个
  final List<dynamic> categories;
  final bool isWidgetPoint;

  // 所有的可用demos;
  WidgetItemContainer(
      {Key key,
      @required this.categories,
      @required this.columnCount,
      @required this.isWidgetPoint})
      : super(key: key);

  List<Widget> _buildColumns(context) {
    List<Widget> _listWidget = [];
    List<Widget> _listRows = [];
    int addI;
    for (int i = 0, length = categories.length; i < length; i += columnCount) {
      _listRows = [];
      for (int innerI = 0; innerI < columnCount; innerI++) {
        addI = innerI + i;
        if (addI < length) {
          dynamic item = categories[addI];
          _listRows.add(
            Expanded(
              flex: 1,
              child: WidgetItem(
                widgetIcon: item.catIcon,
                title: item.name,
                onTap: () {
                  String targetRouter = (item.path == null || item.path.isEmpty)
                      ? '/pages/404'
                      : item.path;
                  if (isWidgetPoint) {
                    // String targetName = item.name;

                    // widgetDemosList.forEach((item) {
                    //   if (item.name == targetName) {
                    //     targetRouter = item.routerName;
                    //   }
                    // });
                    // Application.router.navigateTo(context, "$targetRouter", transition: TransitionType.inFromRight);
                    Navigator.pushNamed(context, targetRouter);
                  } else {
                    Application.router
                    .navigateTo(context, "${item.path}", transition: TransitionType.inFromRight);
                  }
                },
                index: addI,
                totalCount: length,
                rowLength: columnCount,
                textSize: isWidgetPoint ? 'middle' : 'small',
              ),
            ),
          );
        } else {
          _listRows.add(
            Expanded(
              flex: 1,
              child: Container(),
            ),
          );
        }
      }
      _listWidget.add(
        Row(
          children: _listRows,
        ),
      );
    }
    return _listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildColumns(context),
    );
  }
}
