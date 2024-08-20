import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String fontSizes = "storytextSize";
  static String themePos = "themePos";
  static String darkModes = "storyDarkMode";
  static String lastReadStory = "lastReadStory";
  static String appLanguage = "appLanguage";

  addFontSize(int sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(fontSizes, sizes);
  }

  getAppLanguage(BuildContext context) async {
    return "en";
  }

  setAppLanguage(String sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(appLanguage, sizes);
  }

  setLastReadStory(int sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(lastReadStory, sizes);
  }

  setDarkModes(int sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(darkModes, sizes);
  }

  setThemePos(int sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(themePos, sizes);
  }

// setDarkMode(bool darkSet) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(DARK_MODES, darkSet);
//   }

  getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(fontSizes) ?? 16;
    return intValue;
  }

  getLastReadStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(lastReadStory) ?? 0;
    return intValue;
  }

  getIsDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(darkModes) ?? 0;
    return intValue;
  }

  getThemePos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(themePos) ?? 0;
    return intValue;
  }
}
