import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_story_app/ConstantDatas.dart';
import 'package:flutter_story_app/PrefData.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/themes/ThemeNotifier.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'main.dart';

enum Availability { loading, available, unavailable }

class MoreWidget extends StatefulWidget {
  @override
  _MoreWidget createState() => _MoreWidget();
}

double imgSize = 45;
double marginSize = 10;

bool _isSwitched = false;

class _MoreWidget extends State<MoreWidget> {
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.nilufar.bulling',
    appStoreIdentifier: '1491556149',
  );

  void _initRateMyApp() async {
    await rateMyApp.init();
    setState(() {});
  }

  int posGet = 0;
  int? selectedValue;

  showPickerArray(BuildContext context) {
    List<int> lists = [];
    try {
      lists.add(ConstantDatas.languageList.indexOf(getLocalLanguage!));
    } catch (e) {
      print(e);
      lists.add(0);
    }
    // lists.add(1);
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerData: ConstantDatas.languageNameList, isArray: false),
        hideHeader: true,
        itemExtent: 40,
        selecteds: lists,
        title: new Text(S.of(context).selectLanguage),
        onConfirm: (Picker picker, List value) {
          PrefData().setAppLanguage(ConstantDatas.languageList[value[0]]);
          sendToHome();
          print("get==${value.toString()}==${value[0]}");
          print("get2=${picker.getSelectedValues()}");
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LangDemoRun()));
        }).showDialog(context);
  }

  showPicker() {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          // ignore: deprecated_member_use
          return WillPopScope(
            child: Container(
              width: double.infinity,
              height: 200,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                scrollController: FixedExtentScrollController(initialItem: 2),
                onSelectedItemChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                itemExtent: 60,
                children: const [
                  Text('Item01'),
                  Text('Item02'),
                  Text('Item03'),
                ],
              ),
            ),
            onWillPop: () async {
              print("back---click");
              Navigator.of(context).pop();

              return true;
            },
          );
        });
  }

  String? getLocalLanguage;

  _setAppLanguage() async {
    getLocalLanguage = await PrefData().getAppLanguage(context);

    setState(() {
      print("getLocal==$getLocalLanguage");
    });
  }

  @override
  void initState() {
    _initRateMyApp();
    _setSwitchData();
    _setAppLanguage();
    ConstantDatas.setThemePosition();
    currentColor = ConstantDatas.primaryColor;

    super.initState();
    // _rateMyApp.init().then((_) {
    //   _rateMyApp.conditions.forEach((condition) {
    //     if (condition is DebuggableCondition) {
    //       // print(condition.valuesAsString());
    //       // We iterate through our list of conditions and we print all debuggable ones.
    //     }
    //   });

    // print('Are all conditions met ? ' +
    //     (_rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));

    // if (_rateMyApp.shouldOpenDialog) _buildShowStarRateDialog(context);
    // });
  }

  // _buildShowStarRateDialog(BuildContext context) {
  //   _rateMyApp.showStarRateDialog(context, actionsBuilder: (_, count) {
  //     final Widget cancelButton = RateMyAppNoButton(
  //       // We create a custom "Cancel" button using the RateMyAppNoButton class.
  //       _rateMyApp,
  //       text: 'CANCEL',
  //       callback: () => setState(() {}),
  //     );
  //     if (count == null || count == 0) {
  //       // If there is no rating (or a 0 star rating), we only have to return our cancel button.
  //       return [cancelButton];
  //     }
  //
  //     // Otherwise we can do some little more things...
  //     String message = 'You\'ve put ' + count.round().toString() + ' star(s). ';
  //     switch (count.round()) {
  //       case 1:
  //         message += S.of(context).didThisAppHurtYouPhysically;
  //         break;
  //       case 2:
  //         message += S.of(context).thatsNotReallyCoolMan;
  //         break;
  //       case 3:
  //         message += S.of(context).wellItsAverage;
  //         break;
  //       case 4:
  //         message += S.of(context).thisIsCoolLikeThisApp;
  //         break;
  //       case 5:
  //         message += S.of(context).great3;
  //         break;
  //     }
  //
  //     return [
  //       TextButton(
  //         child: Text(S.of(context).ok),
  //         onPressed: () async {
  //           print(message);
  //           print("msgs&$message");
  //
  //           Fluttertoast.showToast(
  //               msg: message,
  //               toastLength: Toast.LENGTH_SHORT,
  //               gravity: ToastGravity.BOTTOM,
  //               timeInSecForIosWeb: 1,
  //               backgroundColor: Colors.black38,
  //               textColor: Colors.white,
  //               fontSize: 16.0);
  //
  //           await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
  //           Navigator.pop<RateMyAppDialogButton>(
  //               context, RateMyAppDialogButton.rate);
  //
  //           setState(() {});
  //         },
  //       ),
  //       cancelButton,
  //     ];
  //   });
  // }

  _setSwitchData() async {
    posGet = await PrefData().getIsDarkMode();
    setState(() {
      if (posGet == 0) {
        _isSwitched = false;
      } else {
        _isSwitched = true;
      }
      print("setswitchdata==1");
    });
  }

  // List<DebuggableCondition> debuggableConditions = [];
  // Widget widgetDevider = Padding(
  //   padding: EdgeInsets.only(left: imgSize + marginSize, right: marginSize),
  //   child: Divider(
  //     color: Colors.grey,
  //     height: 5,
  // ),
  // );

  /// Whether the dialog should be opened.
  bool shouldOpenDialog = false;

  void changeColor(Color color) => setState(() => currentColor = color);

  void refresh() {}

  Color currentColor = Colors.limeAccent;

  @override
  Widget build(BuildContext context) {
    // _setSwitchData();
    print("setswitchdata==2");
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).setting,
            style: TextStyle(
              color: ConstantDatas.textColors,
            )),
        backgroundColor: ConstantDatas.backgroundColors,
        centerTitle: true,
      ),
      body: Container(
        color: ConstantDatas.backgroundColors,
        child: ListView(
          padding: EdgeInsets.only(top: marginSize),
          // padding: const EdgeInsets.all(8),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(marginSize),
                  height: imgSize,
                  width: imgSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0,
                          // has the effect of softening the shadow
                          spreadRadius: 2.0,
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        ),
                      ],
                      color: ConstantDatas.primaryColor),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_view_day,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    S.of(context).dayNightMode,
                    style: TextStyle(
                        color: ConstantDatas.textColors, fontSize: 17),
                    // style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                Switch(
                  value: _isSwitched,
                  thumbColor:
                      MaterialStatePropertyAll(ConstantDatas.cardBackground),
                  onChanged: (value) {
                    setState(() {
                      int setval = 0;
                      if (value == true) {
                        // ThemeNotifier().setDarkMode();
                        setval = 1;
                      } else {
                        setval = 0;
                      }
                      PrefData().setDarkModes(setval);
                      // _isSwitched = value;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LangDemoRun()));
                    });
                  },
                  activeTrackColor: ConstantDatas.primaryColor,
                  activeColor: ConstantDatas.primaryColor,
                ),
              ],
            ),
            //widgetDevider,

            // ),
            InkWell(
              onTap: () {
                ConstantDatas.shareApp(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(marginSize),
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: ConstantDatas.primaryColor),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).share,
                      style: TextStyle(
                          color: ConstantDatas.textColors, fontSize: 17),
                      // style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            // widgetDevider,
            Visibility(
              visible: false,
              child: InkWell(
                onTap: () {
                  showPickerArray(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(marginSize),
                      height: imgSize,
                      width: imgSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20.0,
                              // has the effect of softening the shadow
                              spreadRadius: 2.0,
                              offset: Offset(
                                5.0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ),
                            ),
                          ],
                          color: ConstantDatas.primaryColor),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Language",
                        style: TextStyle(
                            color: ConstantDatas.textColors, fontSize: 17),
                        // style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ),
            //widgetDevider,
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(S.of(context).selectAColor),
                      content: Container(
                        height: 150,
                        child: BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeColor,
                          availableColors: ThemeNotifier.themeColorsList,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop();
                              PrefData().setThemePos(ThemeNotifier
                                  .themeColorsList
                                  .indexOf(currentColor));
                              // _isSwitched = value;
                              ConstantDatas.setThemePosition();

                              sendToHome();

                              // Navigator.of(context, rootNavigator: true).pop('dialog');
                            });
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(marginSize),
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: ConstantDatas.primaryColor),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.color_lens,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).theme,
                      style: TextStyle(
                          color: ConstantDatas.textColors, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            // ),
            //widgetDevider,

            InkWell(
              onTap: () {
                ConstantDatas.launchURL(
                    "https://doc-hosting.flycricket.io/ozor-nadekh/3a71cfd7-546d-4250-ae87-e9a59f5384a4/privacy?fbclid=IwZXh0bgNhZW0CMTAAAR3uqYlRCXlegPb9gw__UeSitswwzbC9zaezXyxZBftga10kjNMWafb_dEw_aem_AZ3XIWwcsv5zyUgzgZ-V86EJLvny5ttj8AVcmeaatndlLiMMDGYhnz6r31XrrTyHGf5a9AgTso9rZTZ1qKQImUgW");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(marginSize),
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: ConstantDatas.primaryColor),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.security,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).privacyPolicy,
                      style: TextStyle(
                          color: ConstantDatas.textColors, fontSize: 17),
                      // style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            // ),
            //  widgetDevider,

            InkWell(
              onTap: () {
                ConstantDatas.sendMail(context);
                ConstantDatas.launchEmail('nilufaritocf@gmail.com',
                    'Алоқа бо мо', 'Фиристонидан ба почта');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(marginSize),
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: ConstantDatas.primaryColor),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mail,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).feedback,
                      style: TextStyle(
                          color: ConstantDatas.textColors, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            // ),
            //widgetDevider,
            InkWell(
              onTap: () {
                // _buildShowStarRateDialog(context);

                print("clickldm");
                rateMyApp.showStarRateDialog(
                  context,
                  title: 'Оцените приложение', // The dialog title.
                  message:
                      'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
                  // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
                  actionsBuilder: (context, stars) {
                    // Triggered when the user updates the star rating.
                    return [
                      // Return a list of actions (that will be shown at the bottom of the dialog).
                      GestureDetector(
                        child: Text('OK'),
                        onTap: () async {
                          // print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
                          // // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                          // // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                          // await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                          if (Platform.isAndroid) {
                            Navigator.pop<RateMyAppDialogButton>(
                                context, RateMyAppDialogButton.rate);
                          } else {
                            await rateMyApp.callEvent(
                                RateMyAppEventType.rateButtonPressed);
                            Navigator.pop(context);
                            rateMyApp.launchStore();
                          }

                          // Navigator.pop(context);
                        },
                      ),
                    ];
                  },
                  ignoreNativeDialog: Platform
                      .isIOS, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
                  dialogStyle: const DialogStyle(
                    // Custom dialog styles.
                    titleAlign: TextAlign.center,
                    messageAlign: TextAlign.center,
                    messagePadding: EdgeInsets.only(bottom: 20),
                  ),
                  starRatingOptions:
                      const StarRatingOptions(), // Custom star bar rating options.
                  onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
                      .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(marginSize),
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: ConstantDatas.primaryColor),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.thumb_up,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).rateUs,
                      style: TextStyle(
                          color: ConstantDatas.textColors, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  void sendToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LangDemoRun()));
  }
}
