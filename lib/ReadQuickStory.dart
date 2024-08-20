import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_story_app/CustomWidgets.dart';
import 'package:flutter_story_app/db/database_helper.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/model/ModelSubCategory.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:numberpicker/numberpicker.dart';
// import 'package:share_plus/share_plus.dart';

import 'package:social_share/social_share.dart';

import 'ConstantDatas.dart';
import 'PrefData.dart';
import 'SizeConfig.dart';
import 'StoryDetail.dart';

class ReadQuickStory extends StatefulWidget {
  @override
  _ReadQuickStory createState() => _ReadQuickStory();
}

class _ReadQuickStory extends State<ReadQuickStory>
    with TickerProviderStateMixin {
  ModelSubCategory? subCat;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  AnimationController? animationController;
  Animation<double>? animation;
  int _fontSize = 18;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  double defaultPaddingIcon = 7;

  void setImageData() {
    if (File(subCat!.img).existsSync()) {
      imagewidget = DecorationImage(
          image: new FileImage(new File(subCat!.img)), fit: BoxFit.cover);
    } else {
      imagewidget = DecorationImage(
        image: ExactAssetImage("assets/${subCat?.img}"),
        fit: BoxFit.cover,
      );
    }
  }

  _setStory() async {
    // int ide = 5;
    int ide = await PrefData().getLastReadStory();
    print("gertid$ide");
    if (ide == 0) {
      _databaseHelper.getAllSubCatList().then((value) {
        Random random = new Random();
        int randomNumber = random.nextInt(value.length);
        setState(() {
          subCat = ModelSubCategory.fromMap(value[randomNumber]);
          setImageData();
          setUpdateData();
          setbookmarkData();
        });
      });
    } else {
      _databaseHelper.getSubCatByid(ide).then((value) {
        setState(() {
          subCat = value;
          setImageData();
          setUpdateData();
          setbookmarkData();
        });
      });
    }
  }

  Widget? widgets;
  Widget? widgetsBookmark;

  void setUpdateData() {
    if (subCat!.fav == 1) {
      widgets = backIcon(
          white, Icons.favorite, Colors.black38, 0, defaultPaddingIcon);

      // widgets = Icon(
      //   Icons.favorite,
      //   color: Colors.white,
      // );
    } else {
      widgets = backIcon(
          white, Icons.favorite_border, Colors.black38, 0, defaultPaddingIcon);

      // widgets = Icon(
      //   Icons.favorite_border,
      //   color: Colors.white,
      // );
    }
  }

  void setbookmarkData() {
    if (subCat!.markRead == 1) {
      widgetsBookmark = Icon(
        Icons.bookmark,
        color: Colors.white,
      );
    } else {
      widgetsBookmark = Icon(
        Icons.bookmark_border,
        color: Colors.white,
      );
    }
  }

  DecorationImage? imagewidget;
  ScrollController _scrollController = ScrollController();
  double topPosition = 0;

  @override
  void initState() {
    topPosition = -80;

    ConstantDatas.setThemePosition();
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    _setStory();
    _setFontSizes();
    print("fontsizes==$_fontSize");
    setData();
    _scrollController.addListener(_onScroll);
  }

  _onScroll() {
    print("offset==${_scrollController.offset}");
    if (_scrollController.offset > 50) {
      // if (_scrollController.offset > 50) {
      if (topPosition < 0)
        setState(() {
          topPosition = -130 + _scrollController.offset;
          if (_scrollController.offset > 130) topPosition = 0;
        });
    } else {
      if (topPosition > -80)
        setState(() {
          topPosition--;
          if (_scrollController.offset <= 0) topPosition = -80;
        });
    }
  }

  Future<void> setData() async {
    animationController!.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      setState(() {
        opacity3 = 1.0;
      });
    }
  }

  _setFontSizes() async {
    _fontSize = await PrefData().getFontSize();
    print("fontsizes==$_fontSize");
  }

  // ProgressDialog progressDialog;

  Widget? widgetReadStory;

  Future<void> share() async {
    // Share.share(S.of(context).appname,
    //     subject: "${subCat!.title}\n${subCat!.story}");

    await FlutterShare.share(
        title: S.of(context).appname,
        text: "${subCat!.title}\n${decodeHtml(subCat!.story)}",
        linkUrl: '',
        chooserTitle: 'Example Chooser Title');
  }

  double _getOpacity() {
    double op = (topPosition + 80) / 80;
    return op > 1 || op < 0 ? 1 : op;
  }

  void _showDialog(BuildContext contexta) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(S.of(context).pickAFontSize),
            content: StatefulBuilder(builder: (context, snapshot) {
              return NumberPicker(
                onChanged: (value) {
                  setState(() {
                    PrefData().addFontSize(value);
                    _setFontSizes();
                  });
                  snapshot(() {});
                },
                minValue: 14,
                maxValue: 35,
                value: _fontSize,
              );
            }),
          );
        }).then((value) => {
          if (value != null)
            {
              setState(() {
                PrefData().addFontSize(value);
                _setFontSizes();
              })
            }
        });
  }

  void sendToBack() {
    // if (subCat.mark_read != 1) {
    //   PrefData().setLastReadStory(subCat.id);
    // } else {
    //   PrefData().setLastReadStory(0);
    // }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (subCat == null) {
      widgetReadStory = Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstantDatas.backgroundColors,
      );
    } else {
      widgetReadStory = Container(
          width: double.infinity,
          height: double.infinity,
          color: ConstantDatas.backgroundColors,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 50),
                      height: SizeConfig.safeBlockVertical! * 40,
                      decoration: BoxDecoration(image: imagewidget
                          // image: DecorationImage(
                          // image: ExactAssetImage("assets/${subCat.img}"),
                          // fit: BoxFit.cover,
                          // )
                          ),
                    ),
                    new Container(
                      width: double.infinity,
                      // height: SizeConfig.safeBlockVertical * 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black12,
                          //     blurRadius: 16.0,
                          //   ),
                          // ],
                          color: ConstantDatas.backgroundColors),
                      // color: Colors.white),
                      margin: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical! * 35),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Text(
                            subCat!.title,
                            style: TextStyle(
                                // color: Colors.black,
                                color: ConstantDatas.textColors,
                                fontSize: _fontSize.toDouble(),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Product_Sans_Regular"),
                          ),
                          const SizedBox(height: 15.0),
                          // SingleChildScrollView(
                          //   child:
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity2,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.safeBlockVertical! * 20),
                              // padding: const EdgeInsets.symmetric(
                              //     vertical: 0, horizontal: 0),
                              // vertical: 8.0, horizontal:5),
                              //   child: Html(
                              //       data:subCat.story,
                              //       defaultTextStyle: TextStyle(fontSize:_fontSize.toDouble(),color: ConstantDatas.textColors,height: 1.4),
                              // ),
                              child: HtmlWidget(
                                subCat!.story,
                                textStyle: TextStyle(
                                    color: ConstantDatas.textColors,
                                    fontSize: _fontSize.toDouble()),
                              ),
                            ),
                          ),
                          // ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: (SizeConfig.safeBlockVertical! * 35 - 24),
                            right: 32),
                        // padding: const EdgeInsets.only(top: 242, right: 32),

                        child: ScaleTransition(
                          alignment: Alignment.center,
                          scale: CurvedAnimation(
                              parent: animationController!,
                              curve: Curves.fastOutSlowIn),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
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
                              icon: widgetsBookmark!,
                              onPressed: () {
                                if (subCat!.markRead == 0) {
                                  subCat!.markRead = 1;
                                  PrefData().setLastReadStory(0);
                                } else {
                                  subCat!.markRead = 0;
                                  PrefData().setLastReadStory(subCat!.id!);
                                }
                                // var stringMap = subCat.cast<String, dynamic>
                                _databaseHelper.updateSubCatFav(subCat!);
                                _databaseHelper
                                    .getSubCatByid(subCat!.id!)
                                    .then((value) {
                                  setState(() {
                                    print("getupdate=${value!.fav!}");
                                    subCat = value;
                                    setbookmarkData();
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: topPosition,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    padding:
                        const EdgeInsets.only(left: 50, top: 25.0, right: 20.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      // borderRadius:
                      //     BorderRadius.only(bottomRight: Radius.circular(30.0)),
                      color:
                          ConstantDatas.primaryColor.withOpacity(_getOpacity()),
                    ),
                  )),
              SizedBox(
                height: 80,
                width: double.infinity,
                //   backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.only(left: 0, top: 25.0, right: 0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      InkWell(
                        child: backIcon(white, Icons.format_size,
                            Colors.black38, 0, defaultPaddingIcon),
                        onTap: () {
                          _showDialog(context);
                        },
                      ),
                      new InkWell(
                        child: widgets,
                        onTap: () {
                          if (subCat!.fav == 0) {
                            subCat!.fav = 1;
                          } else {
                            subCat!.fav = 0;
                          }
                          _databaseHelper.updateSubCatFav(subCat!);
                          _databaseHelper
                              .getSubCatByid(subCat!.id!)
                              .then((value) {
                            setState(() {
                              print("getupdate=${value!.fav!}");
                              subCat = value;
                              setUpdateData();
                            });
                          });
                        },
                      ),
                      new InkWell(
                        child: backIcon(white, Icons.share, Colors.black38, 0,
                            defaultPaddingIcon),
                        onTap: () {
                          share();
                        },
                      ),
                      new InkWell(
                        child: backImageIcon(
                            white,
                            Image.asset('assets/whatsapp.png'),
                            0,
                            defaultPaddingIcon),
                        // backIcon(white, Icons.share, Colors.black38,0,defaultPaddingIcon),
                        // // backIcon(white, Image.asset('assets/whatsapp.png'), Colors.black38),
                        onTap: () {
                          String s = S.of(context).appname +
                              "\n${subCat!.title}\n${decodeHtml(subCat!.story)}";
                          // String s = "$appname\n${subCat.title}\n${subCat.story}";
                          SocialShare.shareWhatsapp(s);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ));
    }

    return Scaffold(
      body: widgetReadStory,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    if (animationController != null) {
      animationController!.dispose();
    }
    super.dispose();
  }
}
