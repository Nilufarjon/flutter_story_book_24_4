//import 'package:admob_flutter/admob_flutter.dart';
// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_story_app/ConstantDatas.dart';
import 'package:flutter_story_app/MoreWidget.dart';
import 'package:flutter_story_app/PrefData.dart';
import 'package:flutter_story_app/favourite_widget.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/home_widget.dart';
import 'package:flutter_story_app/splash_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'themes/ThemeNotifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Admob.initialize();
  // MobileAds.instance.initialize();

  runApp(LangDemoRun());
  // debugPrintEndFrameBanner
}

class MyApp extends StatefulWidget {
  final ThemeData? data;

  final String? locals;

  MyApp({this.data, this.locals});

  @override
  _MyApp createState() => _MyApp();
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class LangDemoRun extends StatefulWidget {
  @override
  _LangDemoRun createState() => _LangDemoRun();
}

class _LangDemoRun extends State<LangDemoRun> {
  String setLocals = "en";

  @override
  void initState() {
    ConstantDatas.setThemePosition();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _setAppLanguage();

    super.didChangeDependencies();
  }

  _setAppLanguage() async {
    try {
      setLocals = await PrefData().getAppLanguage(context);

      setState(() {
        print("getLocal==$setLocals");
      });
    } catch (e) {
      print(e);
    }
  }

  void displayAlertDialog(BuildContext contexts) {
    showCupertinoDialog(
      context: contexts,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          S.of(context).exit,
          style: TextStyle(
            fontSize: 18,
            color: ConstantDatas.textColors,
          ),
        ),
        content: Text(
          S.of(context).areYouSureWantToExitApp,
          style: TextStyle(
              color: ConstantDatas.textColors,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              S.of(context).yes,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            // onPressed: () => Navigator.pop(context,true),
            onPressed: () {
              // SystemNavigator.pop();
              Future.delayed(const Duration(milliseconds: 200), () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              });
            },
          ),
          CupertinoDialogAction(
            child: Text(
              S.of(context).no,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ConstantDatas.setThemePosition();

    ThemeData themeData = new ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryColor: ConstantDatas.primaryColor,
        primaryColorDark: ConstantDatas.primaryColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: new Locale(setLocals, ''),
      theme: themeData,
      home:
          // WillPopScope(
          //   child:
          SplashWidget(
        data: themeData,
        locals: setLocals,
      ),
    );
  }
}

void launchPDFUrl(Uri pdfUrl, Function function) async {
  if (await canLaunchUrl(pdfUrl)) {
    // await launchUrl(pdfUrl);
    // Stream<bool> isStream = await launchUrl(pdfUrl).asStream();

    // print("isStream------${isStream.toString()}");
    await launchUrl(pdfUrl).then((value) {
      function();
    });
    print("done");
  } else {
    throw 'Could not launch $pdfUrl';
  }
}

class _MyApp extends State<MyApp> {
  int _selectedIndex = 0;

  // String setLocals = "";
  Color selectedItemsColors = Colors.white60;
  static List<Widget> _widgetOptions = <Widget>[
    // ReadQuickStory(),
    HomeWidget(),
    // SelectCategoriesWidget(),
    FavouriteWidget(),
    MoreWidget(),

    Container(
      child: Center(
        child: CircularProgressIndicator(
          color: ConstantDatas.primaryColor,
        ),
      ),
    ),

    // YourStoryWidget(),
  ];

  // ThemeData data;
  Color primaryGet = Colors.blue;

  // _MyApp(ThemeData this.data);

  void _selectedTab(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;

        if (_selectedIndex == 3) {
          launchPDFUrl(
              Uri.parse('https://www.survio.com/survey/d/Q2R9G8B1W7N4R6Y1V'),
              () {
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _selectedIndex = 0;
              });
            });
          });
        }
      });
    }

    // else{
    //   _selectedIndex = index;
    // }
    // _selectedIndex = index;

    // selectedItemsColors = Colors.white;
  }


  @override
  void initState() {
    setColors();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    super.didChangeDependencies();
  }

  setColors() async {
    int pos = await PrefData().getThemePos();
    print("getcolor11=$pos");
    setState(() {
      primaryGet = ThemeNotifier.themeColorsList[pos];
      print("getcolor111=$primaryGet");
    });
  }

  void displayAlertDialog1(BuildContext contexts) {
    showDialog(
      context: context,
      builder: (contexts) {
        return CupertinoAlertDialog(
          title: new Text(
            S.of(context).exit,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          content: new Text(S.of(context).areYouSureWantToExitApp,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                "Yes",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 200), () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              },
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).no,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
              onPressed: () {
                Navigator.of(contexts).pop(false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ConstantDatas.setThemePosition();
    // final Locale appLocale = Localizations.localeOf(context);
    print("getcolor2${ConstantDatas().getPrimaryColor()}==");
    S.of(context);

    return WillPopScope(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: ConstantDatas.backgroundColors,

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black54,
          selectedItemColor: ConstantDatas.textColors,

          backgroundColor: ConstantDatas.cardBackground,
          // color: ConstantDatas.bottomNavColor,
          // color: Colors.white60,
          // color: '#9DE6E0'.toColor(),

          onTap: _selectedTab,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/home.png",
                color: _selectedIndex == 0
                    ? ConstantDatas.textColors
                    : Colors.black45,
                height: 25,
                width: 25,
              ),
              // Icon(
              //   Icons.home_outlined,
              //   color: _selectedIndex == 0 ? Colors.black87 : Colors.black45,
              // ),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: _selectedIndex == 1
                      ? ConstantDatas.textColors
                      : Colors.black45,
                  size: 25,
                ),
                label: S.of(context).favourite),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  color: _selectedIndex == 2
                      ? ConstantDatas.textColors
                      : Colors.black45,
                  size: 25,
                ),
                label: S.of(context).more),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/question.png",
                  color: _selectedIndex == 3
                      ? ConstantDatas.textColors
                      : Colors.black45,
                  height: 24,
                  width: 24,
                ),
                // icon: Icon(
                //   Icons.question_mark,
                //   color: _selectedIndex == 3 ? Colors.black87 : Colors.black45,
                // ),
                label: S.of(context).yourStory),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: _buildFab(context),
        // ),
      ),
      // ),
      // onWillPop: _onWillPop,
      onWillPop: () async {
        //_onBackPressed(context);

        return true;
      },
      // _onBackPressed(context),
    );
  }
}
