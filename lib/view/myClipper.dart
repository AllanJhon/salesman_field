import 'package:flutter/material.dart';

TextEditingController userController = TextEditingController();
TextEditingController pwdController = TextEditingController();

class ArcBannerImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child: ClipPath(
            clipper: ArcClipper(),
            child: Container(
              padding: new EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
              child: new Center(
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
                  ),
                ),
              ),
              width: screenWidth,
              height: 200.0,
              decoration: new BoxDecoration(
                color: Colors.blue[300],
                gradient: new LinearGradient(
                  begin: const FractionalOffset(0.5, 0.0),
                  end: const FractionalOffset(0.5, 1.0),
                  colors: <Color>[Color(0xFF00838F), Color(0xFF4DD0E1)],
                // ),
              ),
            ),
          ),
        ),
        ),
        new Container(
           decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child: Text("asdsfsdfds")
          // new inputEdtextNameWiget(),
        )
      ],
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var firstControlPoint = Offset(size.width / 4, size.height - 50);
    var firstPoint = Offset(size.width / 2, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 50);
    var secondPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



