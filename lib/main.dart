import 'package:flutter/material.dart';

import 'api.dart';
import 'lectionary_entry.dart';
import 'lectionary_entry_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Singing the Faith Hymn Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Singing the Faith Hymn Finder'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LectionaryEntry> _lectionaryData;

  @override
  void initState() {
    super.initState();
    _loadDates();
  }

  Future<void> _loadDates() async {
    final api = Api();
    final dates = await api.getLectionaryEntries();
    if (dates != null) {
      setState(() {
        _lectionaryData = dates;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_lectionaryData == null) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    var listView = ListView(
      children: _lectionaryData.map((LectionaryEntry lectionaryEntry) {
        return InkWell(
          highlightColor: Theme.of(context).highlightColor,
          splashColor: Theme.of(context).highlightColor,
          onTap: () {
            _onTap(lectionaryEntry);
          },
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              lectionaryEntry.date,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        );
      }).toList(),
    );

    return listView;
  }

  void _onTap(LectionaryEntry lectionaryEntry) {
    print("Tapped " + lectionaryEntry.date);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LectionaryEntryRoute(entry: lectionaryEntry)),
    );
  }
}
