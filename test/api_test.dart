import 'package:test/test.dart';
import 'package:hymn_finder/api.dart';
import 'package:xml/xml.dart';
import 'dart:io';

void main() {
  group('parseXmlElements', () {
    test('Parsing empty list of XML elements returns null', () {
      final api = Api();

      var elements = List<XmlElement>();
      var entries = api.parseXmlElements(elements);

      expect(entries, null);
    });

    test('Parsing valid XML elements returns a list of lectionary entries', () {
      final api = Api();

      var elements = new List<XmlElement>.generate(3, (int index) {
        var element = new XmlElement(XmlName('entry'), [], [
          new XmlElement(XmlName('title'), [], [new XmlText('date $index')]),
          new XmlElement(
              XmlName('summary'), [], [new XmlText('summary $index')]),
        ]);
        return element;
      });

      var entries = api.parseXmlElements(elements);

      expect(entries.length, 3);
      for (var i = 0; i < 3; i++) {
        expect(entries[i].date, 'date $i');
        expect(entries[i].htmlInfo, 'summary $i');
      }
    });
  });
}
