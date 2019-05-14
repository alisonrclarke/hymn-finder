
import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';
import 'package:xml/xml.dart';
import 'lectionary_entry.dart';


class Api {
  /// We use the `dart:io` HttpClient. More details: https://flutter.io/networking/
  // We specify the type here for readability. Since we're defining a final
  // field, the type is determined at initialization.
  final HttpClient _httpClient = HttpClient();

  /// The API endpoint we want to hit.
  ///
  /// This API doesn't have a key but often, APIs do require authentication
  final String _url = 'www.singingthefaithplus.org.uk';

  /// Gets all the lectionary entries from the StF website
  ///
  /// Returns a list of AtomFeed items. Returns null on error.
  Future<List<LectionaryEntry>> getLectionaryEntries() async {
    final uri = Uri.http(_url, '/', { 'cat' : '264', 'feed' : 'atom'});
    final entries = await _getAtomFeed(uri);
    if (entries == null || entries.isEmpty) {
      print('Error retrieving data from StF.');
      return null;
    }
    return entries;
  }

  /// Fetches and decodes an Atom feed represented as a Dart [Map].
  ///
  /// Returns null if the API server is down, or the response is not JSON.
  Future<List<LectionaryEntry>> _getAtomFeed(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }
      // The response is sent as a Stream of bytes that we need to convert to a
      // `String`.
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      //
      final document = parse(responseBody);
      return document.findAllElements('entry').map((element) {
        return LectionaryEntry(element);
      }).toList();
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
