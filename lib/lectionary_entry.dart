import 'package:xml/xml.dart';

class LectionaryEntry {
  String date;
  String htmlInfo;

  /// Builds info about a lectionary entry from an ATOM XmlElement
  /// Throws an exception if it can't get the relevant data from the XmlElement
  LectionaryEntry(XmlElement element) {
    this.date = _getChildText(element, 'title');
    this.htmlInfo = _getChildText(element, 'summary');
  }

  _getChildText(XmlElement element, String childName) {
    Iterable<XmlElement> childElements = element.findElements(childName);
    if (childElements.isNotEmpty) {
      return childElements.first.text;
    } else {
      throw Exception("No such element " + childName);
    }
  }
}
