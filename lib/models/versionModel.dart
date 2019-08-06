import 'package:xml/xml.dart' as xml;

class Version {
  String versionCode;
  String updateFile;
  String content;
  Version(this.versionCode, this.updateFile,this.content);
  
  static xml2Model(outputxmlstr) {
        xml.XmlElement node = xml
        .parse(outputxmlstr).findAllElements("data").first;
        Version version=new Version(node.findElements('version').single.text,node.findElements('url').single.text,node.findElements('content').single.text);
        return version;
  }
}
