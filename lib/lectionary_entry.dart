
import 'package:xml/xml.dart';


class LectionaryEntry {
  String date;
  String htmlInfo;

  /// Builds info about a lectionary entry from an ATOM XmlElement
  LectionaryEntry(XmlElement element)
  {
    try {
      this.date = element.findElements('title').first.text;
      this.htmlInfo = element.findElements('summary').first.text;
      print(htmlInfo);
    } on Exception catch (e) {
      print('$e');
    }
  }
}