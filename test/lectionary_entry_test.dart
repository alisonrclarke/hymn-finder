// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:hymn_finder/lectionary_entry.dart';
import 'package:xml/xml.dart';

void main() {
  test('Creating entry from valid XML elements is successful', () {
    var date = 'Sunday 30 June, 2019';
    var htmlInfo = 'Blah blah blah.';

    var element = new XmlElement(XmlName('entry'), [], [
      new XmlElement(
          XmlName('title'), [], [new XmlText(date)]),
      new XmlElement(
          XmlName('summary'), [], [new XmlText(htmlInfo)]),
    ]);

    var entry = LectionaryEntry(element);

    expect(entry.date, date);
    expect(entry.htmlInfo, htmlInfo);
  });

  test('Creating entry from invalid Xml element throws', () {
    var element = new XmlElement(XmlName('entry'), [], [
      new XmlElement(
          XmlName('bananas'), [], [new XmlText('')]),
    ]);

    expect(() => LectionaryEntry(element), throwsException);
  });
}
