import 'package:flutter/material.dart';

class ContractEditContainer extends StatefulWidget {
  final List<Widget> children;
  final Color color;
  final VoidCallback onTap;

   // 所有的可用demos;
  ContractEditContainer(
      {Key key,
      this.children = const <Widget>[],
      this.color=Colors.white,
      @required this.onTap,})
      : super(key: key);

  @override
  _ContractEditContainerState createState() => _ContractEditContainerState();

}
class _ContractEditContainerState extends State<ContractEditContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
  color: widget.color,
  child:InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: new BoxDecoration(
          // color: Colors.white,
          border: Border(
                    bottom: const BorderSide(
                    width: 1.0,color:Color(0xFFEFEFEF))),
        ),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        height: 50.0,
        child: Row(
                children: widget.children,
        ),
      ),
    ));
  }
}