import 'package:xml/xml.dart' as xml;
import 'dart:convert';

class Version {
  String versionCode;
  String updateFile;
  Version(this.versionCode, this.updateFile);
  static xml2Map(outputxmlstr) {
    String data = xml
        .parse(outputxmlstr)
        .findAllElements('data')
        .map((node) =>
            '{"version":"' +
            node.findElements('version').single.text +
            '","url":"' +
            node.findElements('url').single.text +
            '","title":"' +
            node.findElements('title').single.text +
            // '","content":"' +
            // node.findElements('content').single.text +
            '"}')
        .toString();

    print("....................data");
    print(data);
    Map map =
        new JsonDecoder().convert(data.replaceAll("(", "").replaceAll(")", ""));
    
    print("....................content");
    print(map["content"]);

    return map;
  }
}
