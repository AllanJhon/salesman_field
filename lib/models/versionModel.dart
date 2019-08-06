import 'package:xml/xml.dart' as xml;

class Version {
  String versionCode;
  String updateFile;
  String content;
  Version(this.versionCode, this.updateFile,this.content);
<<<<<<< HEAD
  
  static xml2Model(outputxmlstr) {
=======
  static xml2Map(outputxmlstr) {
>>>>>>> cbb69362781b060f562f489c801a64def9892c64
        xml.XmlElement node = xml
        .parse(outputxmlstr).findAllElements("data").first;
        Version version=new Version(node.findElements('version').single.text,node.findElements('url').single.text,node.findElements('content').single.text);
        return version;
  }
}
