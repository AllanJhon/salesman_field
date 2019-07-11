import 'package:xml/xml.dart' as xml;

class GoodsCode {
  String sendno;
  String zflag;
  List<GoodsCode> goodsCodesList;
  GoodsCode(this.sendno, this.zflag);

  GoodsCode.xml2List(outputxmlstr) {
    goodsCodesList = xml
        .parse(outputxmlstr)
        .findAllElements('DATA')
        .map((node) => new GoodsCode(node.findElements('SEND_NO').single.text,
            node.findElements('ZFLAG').single.text))
        .toList();
  }
}

class GoodsResult {
  String status;
  String message;
  List<GoodsResult> goodResultList;
  GoodsResult(this.status, this.message);

  GoodsResult.xml2List(outputxmlstr) {
    goodResultList = xml
        .parse(outputxmlstr)
        .findAllElements('RESULT')
        .map((node) => new GoodsResult(node.findElements('Status').single.text,
            node.findElements('Message').single.text))
        .toList();
  }
}
