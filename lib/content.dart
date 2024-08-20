import 'package:flutter/material.dart';
// import 'package:launch_review/launch_review.dart';
// import 'package:rate_my_app/rate_my_app.dart';

import 'ConstantDatas.dart';
import 'PrefData.dart';

/// The app's main content widget.
class ContentWidget extends StatefulWidget {
  /// The Rate my app instance.
  // final RateMyApp? rateMyApp;

  /// Creates a new content widget instance.
  // const ContentWidget({
  //   // @required this.rateMyApp,
  // });

  @override
  State<StatefulWidget> createState() => _ContentWidgetState();
}

bool _isSwitched = false;

/// The content widget state.
class _ContentWidgetState extends State<ContentWidget> {
  int posGet = 0;

  /// Contains all debuggable conditions.
  // List<DebuggableCondition> debuggableConditions = [];

  /// Whether the dialog should be opened.
  bool shouldOpenDialog = false;

  _setSwitchData() async {
    posGet = await PrefData().getIsDarkMode();
    if (posGet == 0) {
      _isSwitched = false;
    } else {
      _isSwitched = true;
    }
    // print("setswitchdata==1");
  }

  @override
  void initState() {
    _setSwitchData();
    ConstantDatas.setThemePosition();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  @override
  Widget build(BuildContext context) => Container(
        color: ConstantDatas.backgroundColors,
        child: ListView(
          // padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
              color: ConstantDatas.cardBackground,
              margin: EdgeInsets.all(7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    height: 48,
                    width: 48,
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
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_view_day,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Day Night Mode",
                      style: TextStyle(
                          color: ConstantDatas.textColors, fontSize: 17),
                      // style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  Switch(
                    value: _isSwitched,
                    onChanged: (value) {
                      // Provider.of(context).toggleTheme();

                      // PrefData().setDarkMode(value);
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
                        ConstantDatas.setThemePosition();
                        _setSwitchData();
                      });
                    },
                    activeTrackColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                ConstantDatas.shareApp(context);
              },
              child: Card(
                color: ConstantDatas.cardBackground,
                margin: EdgeInsets.all(7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
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
                          color: Theme.of(context).primaryColor),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Share",
                        style: TextStyle(
                            color: ConstantDatas.textColors, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ConstantDatas.launchURL("https://google.com");
              },
              child: Card(
                color: ConstantDatas.cardBackground,
                margin: EdgeInsets.all(7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
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
                          color: Theme.of(context).primaryColor),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.security,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: ConstantDatas.textColors, fontSize: 17),
                        // style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // ConstantDatas.launchEmail(
                //     'demo@gmail.com', 'Flutter Email Test', 'Hello Flutter');
                ConstantDatas.sendMail(context);
              },
              child: Card(
                color: ConstantDatas.cardBackground,
                margin: EdgeInsets.all(7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
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
                          color: Theme.of(context).primaryColor),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Feedback",
                        style: TextStyle(
                            color: ConstantDatas.textColors, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                // await widget.rateMyApp!.showStarRateDialog(context,
                //     actionsBuilder: (_, stars) => starRateDialogActionsBuilder(
                //         context,
                //         stars!)); // We launch the Rate my app dialog with stars.
                // LaunchReview.launch();
                // refresh();
              },
              child: Card(
                color: ConstantDatas.cardBackground,
                margin: EdgeInsets.all(7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
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
                          color: Theme.of(context).primaryColor),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.thumb_up,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Rate Us",
                        style: TextStyle(
                            color: ConstantDatas.textColors, fontSize: 17),
                        // style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ),
      );

  /// Returns a centered text.
  Text textCenter(String content) => Text(
        content,
        textAlign: TextAlign.center,
      );

  /// Allows to refresh the widget state.
  void refresh() {
    setState(() {
      // debuggableConditions = widget.rateMyApp!.conditions
      //     .whereType<DebuggableCondition>()
      //     .toList();
      // shouldOpenDialog = widget.rateMyApp!.shouldOpenDialog;
    });
  }

  // List<Widget> starRateDialogActionsBuilder(
  //     BuildContext context, double stars) {
  //   final Widget cancelButton = RateMyAppNoButton(
  //     // We create a custom "Cancel" button using the RateMyAppNoButton class.
  //     widget.rateMyApp!,
  //     text: MaterialLocalizations.of(context).cancelButtonLabel.toUpperCase(),
  //     callback: refresh,
  //   );
  //   if (stars == 0) {
  //     // If there is no rating (or a 0 star rating), we only have to return our cancel button.
  //     return [cancelButton];
  //   }
  //
  //   // Otherwise we can do some little more things...
  //   String message = 'You put ' + stars.round().toString() + ' star(s). ';
  //   Color color = Colors.transparent;
  //   switch (stars.round()) {
  //     case 1:
  //       message += 'Did this app hurt you physically ?';
  //       color = Colors.red;
  //       break;
  //     case 2:
  //       message += 'That\'s not really cool man.';
  //       color = Colors.orange;
  //       break;
  //     case 3:
  //       message += 'Well, it\'s average.';
  //       color = Colors.yellow;
  //       break;
  //     case 4:
  //       message += 'This is cool, like this app.';
  //       color = Colors.lime;
  //       break;
  //     case 5:
  //       message += 'Great ! <3';
  //       color = Colors.green;
  //       break;
  //   }
  //
  //   return [
  //     TextButton(
  //       child:
  //           Text(MaterialLocalizations.of(context).okButtonLabel.toUpperCase()),
  //       onPressed: () async {
  //         print(message);
  //
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(message),
  //             backgroundColor: color,
  //           ),
  //         );
  //
  //         //
  //         // Scaffold.of(context).showSnackBar(
  //         //   SnackBar(
  //         //     content: Text(message),
  //         //     backgroundColor: color,
  //         //   ),
  //         // );
  //
  //         // This allow to mimic a click on the default "Rate" button and thus update the conditions based on it ("Do not open again" condition for example) :
  //         await widget.rateMyApp!
  //             .callEvent(RateMyAppEventType.rateButtonPressed);
  //         Navigator.pop<RateMyAppDialogButton>(
  //             context, RateMyAppDialogButton.rate);
  //         refresh();
  //       },
  //     ),
  //     cancelButton,
  //   ];
  // }
}
