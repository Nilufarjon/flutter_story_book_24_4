import 'package:flutter/material.dart';
import 'package:flutter_story_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StorageManager.dart';

class ThemeNotifier with ChangeNotifier {

  static Color colorPrimary="#ffffff".toColor();
  static Color navcolorPrimary="#9DE6E0".toColor();
  static Color deepPurpleColorPrimary="#9de0e6".toColor();
  static Color navdeepPurpleColorPrimary="#9B7ECD".toColor();
  static Color pinkColorPrimary="#E82E6D".toColor();
  static Color navpinkColorPrimary="#E3779C".toColor();
  static Color orangeColorPrimary="#FE5722".toColor();
  static Color navorangeColorPrimary="#F4A890".toColor();
  static Color greenColorPrimary="#4CAF50".toColor();
  static Color navgreenColorPrimary="#A8E1AA".toColor();
  static Color grayColorPrimary="#bcbcbc".toColor();
  static Color navgrayColorPrimary="#A9C6D3".toColor();

  // static List<Color> themeColorsList
  static final themeColorsList = <Color>[colorPrimary,deepPurpleColorPrimary,pinkColorPrimary,orangeColorPrimary,greenColorPrimary,grayColorPrimary];
  static final themeBgColorsList = <Color>[navcolorPrimary,navdeepPurpleColorPrimary,navpinkColorPrimary,navorangeColorPrimary,navgreenColorPrimary,navgrayColorPrimary];

  static ThemeData darkTheme = ThemeData(
    primaryColor: "#00B3A2".toColor(),

    brightness: Brightness.dark,
    // backgroundColor: "#0A0A0A".toColor(),
    scaffoldBackgroundColor: "#0A0A0A".toColor(),
    cardColor: "#1E2834".toColor(),
    // textSelectionColor: Colors.white,
    textTheme: TextTheme().apply(bodyColor: Colors.white),
    // accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: "#00B3A2".toColor(),
        selectionColor: Colors.white,
      ), colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.white,brightness:Brightness.dark,).copyWith(primary: Colors.grey, background: "#0A0A0A".toColor())
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor:  "#00B3A2".toColor(),
    // primaryColor: Colors.white,
    brightness: Brightness.light ,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textTheme: TextTheme().apply(bodyColor: Colors.black87),

      // accentIconTheme: IconThemeData(color: Colors.white),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),


      dividerColor: Colors.white54,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: "#00B3A2".toColor(),
        selectionColor: Colors.black,
      ), colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.black,brightness:Brightness.light, ).copyWith(primary: Colors.grey, background: Colors.white)

  );

  static final themesList = <ThemeData>[lightTheme,darkTheme];

  ThemeData? _themeData;

  ThemeData getTheme() {
    print("themedata===$_themeData");
    return _themeData!;
  }

  getThemeDatas() async {
    // ThemeData data;

    if (await isDarkTheme()) {
      print("darktheme==true");
      return darkTheme;
    } else {
      print("darktheme==false");
      return lightTheme;
    }
  }

  isDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.get('themeMode');
    String getval = prefs.getString('themeMode') ?? 'light';
    print("getval===$getval");
    if (getval == 'light') {
      return false;
    }
    return true;
  }


  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      // var themeMode = value ?? 'dark';
      var themeMode = value ?? 'light';
      print("theme mode===$themeMode");
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
