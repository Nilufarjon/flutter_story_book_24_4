import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_story_app/generated/l10n.dart';

class LangDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LangDemoState();
}

class _LangDemoState extends State<LangDemo> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var matApp = new MaterialApp(localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      S.delegate
    ], supportedLocales: S.delegate.supportedLocales, home: MyHomePage());
    return matApp;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListTile(
              leading: TextButton(
                onPressed: () {
                  setState(() {
                    S.load(Locale('en'));
                    // S.load(Locale('en', 'US'));
                  });
                },
                child: Text('ENGLISH'),
              ),
              trailing: TextButton(
                onPressed: () {
                  setState(() {
                    // S.load(Locale('de', 'DE'));
                    S.load(Locale('es'));
                  });
                },
                child: Text('GERMAN'),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(S.of(context).pagehomelisttitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Text("titleNames"),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ))
        ],
      ),
    );
  }
}
