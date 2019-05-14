import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'lectionary_entry.dart';

class LectionaryEntryRoute extends StatelessWidget {
  final LectionaryEntry entry;

  const LectionaryEntryRoute({
    Key key,
    @required this.entry,
  }) : assert(entry != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.date),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: HtmlView(data: entry.htmlInfo),
        ),
      ),
    );
  }
}
