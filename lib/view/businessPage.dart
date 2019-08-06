import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:amap_location/amap_location.dart';

class BusinessPageWidget extends StatefulWidget {
  @override
  _BusinessPageWidgetState createState() => _BusinessPageWidgetState();
}

class _BusinessPageWidgetState extends State<BusinessPageWidget> {
  List imgList = new List<File>();
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgList.add(image);
    });
  }

 

  dynamic getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  bool showLoadingDialog() {
    if (imgList.length == 0) {
      return true;
    }

    return false;
  }

  Center getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  ListView getListView() => new ListView.builder(
      itemCount: imgList.length,
      itemBuilder: (BuildContext context, int position) {
        return Image.file(imgList[position], height: 300);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body:Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
