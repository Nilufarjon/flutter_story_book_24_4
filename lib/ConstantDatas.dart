// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_share/flutter_share.dart';

// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/themes/ThemeNotifier.dart';

import 'package:url_launcher/url_launcher.dart';

import 'PrefData.dart';
import 'main.dart';

class ConstantDatas {
  static Color primaryColor = "#9fc5e8".toColor(),
      backgroundColors = Colors.white,
      cardBackground = Colors.red,
      bottomNavColor = Colors.grey;
  static Color textColors = Colors.black;
  static Color contactColor = Colors.indigo.shade900;
  static ThemeData? themeData;
  static int yourStoryId = 4;

  static final languageList = <String>["en", "es"];
  static final languageNameList = <String>["English", "Spanish"];

  static setThemePosition({var setState}) async {
    int posGet = await PrefData().getIsDarkMode();
    int getThemePos = await PrefData().getThemePos();

    print("posGet=====${ConstantDatas.primaryColor}---$posGet");

    themeData = ThemeNotifier.themesList[posGet];
    ConstantDatas.bottomNavColor = ThemeNotifier.themeBgColorsList[getThemePos];
    ConstantDatas.primaryColor = ThemeNotifier.themeColorsList[getThemePos];
    print("posGet=====${ConstantDatas.primaryColor}---$posGet");
    ConstantDatas.backgroundColors = themeData!.colorScheme.background;
    ConstantDatas.cardBackground = themeData!.cardColor;
    ConstantDatas.textColors = themeData!.textSelectionTheme.selectionColor!;
    ConstantDatas.contactColor = themeData!.textSelectionTheme.selectionColor!;
    if (setState != null) {
      setState(() {});
    }
  }

  getPrimaryColor() async {
    int getThemePos = await PrefData().getThemePos();
    return ThemeNotifier.themeColorsList[getThemePos];
  }

  static launchEmail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> sendMail(context) async {
    final MailOptions mailOptions = MailOptions(
      body: 'a long body for the email <br> with a subset of HTML',
      subject: 'the Email Subject',
      recipients: ['nilufaritocf@gmail.com'],
      isHTML: true,
    );

    await FlutterMailer.send(mailOptions);
  }

  static Future<void> shareApp(BuildContext contexts) async {
    // Share.share(S.of(contexts).appname, subject: 'https://flutter.dev/');

    await FlutterShare.share(
        title: S.of(contexts).appname,
        text: "Share",
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
