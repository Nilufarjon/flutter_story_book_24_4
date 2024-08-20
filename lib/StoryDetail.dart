// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_story_app/CustomWidgets.dart';
import 'package:flutter_story_app/EditYourStoryWidget.dart';
import 'package:flutter_story_app/MoreWidget.dart';
import 'package:flutter_story_app/PrefData.dart';
import 'package:flutter_story_app/db/database_helper.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/model/ModelSubCategory.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/parser.dart';
import 'package:numberpicker/numberpicker.dart';

import 'ConstantDatas.dart';
import 'SizeConfig.dart';

class StoryDetail extends StatefulWidget {
  final ModelSubCategory subCategory;

  StoryDetail(this.subCategory);

  @override
  _StoryDetail createState() => _StoryDetail(this.subCategory);
}

DatabaseHelper _databaseHelper = DatabaseHelper.instance;

class _StoryDetail extends State<StoryDetail> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  Color appBarBackground = Colors.white;
  double topPosition = 0;

  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  int _fontSize = 16;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  double defaultPaddingIcon = 7;
  ModelSubCategory? subCat;
  IconData iconData = Icons.favorite_border;

  _StoryDetail(this.subCat);

  bool isEdit = true;
  Widget? widgets;
  Widget? widgetsBookmark;

  void setUpdateData() {
    if (subCat!.fav == 1) {
      iconData = Icons.favorite;
      widgets = backIcon(
          white, Icons.favorite, Colors.black38, 2, defaultPaddingIcon);
      // widgets = Icon(
      //   Icons.favorite,
      //   color: Colors.white,
      // );
    } else {
      iconData = Icons.favorite_border;
      widgets = backIcon(
          white, Icons.favorite_border, Colors.black38, 2, defaultPaddingIcon);

      // widgets = Icon(
      //     Icons.favorite_border,
      //     color: Colors.white,
      //   );
    }
  }

  // void setbookmarkData() {
  //   // if (subCat.markRead == 1) {
  //   // widgetsBookmark = Icon(
  //   //   Icons.bookmark,
  //   //   color: Colors.white,
  //   // );
  //
  //
  //   void setbookmarkData() {
  //     if (subCat!.markRead == 1) {
  //       widgetsBookmark = Icon(
  //         Icons.bookmark,
  //         color: Colors.white,
  //       );
  //     } else {
  //       widgetsBookmark = Icon(
  //         Icons.bookmark_border,
  //         color: Colors.white,
  //       );
  //     }
  //   }
  // }
  void setbookmarkData() {
    if (subCat!.markRead == 1) {
      widgetsBookmark = Icon(
        Icons.bookmark,
        color:  Colors.black38,
      );
    } else {
      widgetsBookmark = Icon(
        Icons.bookmark_border,
        color:  Colors.black38,
      );
    }
  }
  double _scale = 1.0;

  void _onDoubleTap() {
    setState(() {
      _scale = _scale == 1.0 ? 2.0 : 1.0;
    });
  }

  @override
  void initState() {
    topPosition = -80;
    appBarBackground = Colors.transparent;
    if (subCat!.mainCatId == ConstantDatas.yourStoryId) {
      isEdit = false;
    } else {
      isEdit = true;
    }
    setImageData();
    print("iconsget===${subCat!.fav}");
    setUpdateData();
    setbookmarkData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _setFontSizes();
    ConstantDatas.setThemePosition();
    super.initState();
    _scrollController.addListener(_onScroll);

    // Toast.show("Please check documentation for verify product", context,
    //     backgroundColor: Colors.black38,
    //     textColor: Colors.white,
    //     duration: Toast.LENGTH_LONG,
    //     gravity: Toast.BOTTOM);

    //
    // Fluttertoast.showToast(
    //     msg: "Please check documentation for verify product",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.black38,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  _setFontSizes() async {
    _fontSize = await PrefData().getFontSize();
    print("fontsizes==$_fontSize");
  }

  setImageData() {
    _databaseHelper.getSubCatByid(subCat!.id!).then((value) {
      subCat = value;
      setState(() {
        print("getimg==${subCat!.img}");
        if (File(subCat!.img).existsSync()) {
          imagewidget = DecorationImage(
              image: new FileImage(new File(subCat!.img)), fit: BoxFit.cover);
        } else {
          imagewidget = DecorationImage(
            image: ExactAssetImage("assets/${subCat!.img}"),
            fit: BoxFit.cover,
          );
        }
      });
    });
  }

  double _getOpacity() {
    double op = (topPosition + 80) / 80;
    return op > 1 || op < 0 ? 1 : op;
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

  DecorationImage? imagewidget;

  Future<void> share() async {
    // Share.share(S.of(context).appname, subject:"${subCat!.title}\n${subCat!.story}");

    await FlutterShare.share(
        title: S.of(context).appname,
        text: "${subCat!.title}\n${decodeHtml(subCat!.story)}",
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
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
    setState(() {
      opacity3 = 1.0;
    });
  }

  // void _showDialog(BuildContext contexta) {
  //   showDialog<int>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return new NumberPickerDialog.integer(
  //           minValue: 14,
  //           maxValue: 35,
  //           title: new Text(S.of(contexta).pickAFontSize),
  //           initialIntegerValue: _fontSize,
  //         );
  //       }).then((value) => {
  //         if (value != null)
  //           {
  //             setState(() {
  //               PrefData().addFontSize(value);
  //               _setFontSizes();
  //             })
  //           }
  //       });
  //
  // }

  Future<bool> _requestPop() {
    sendToBack();
    return new Future.value(false);
  }

  void sendToBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext contexta) {
    SizeConfig().init(context);

    print("inbuild==true");
    print("hbdfsghrhg----${subCat!.story} ");
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
          backgroundColor: ConstantDatas.backgroundColors,
          body: Column(
            children: [


              Container(
                margin: EdgeInsets.only(top: 50),
                padding:
                    const EdgeInsets.only(left: 0,  right: 0),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      child: backIcon(white, Icons.keyboard_arrow_left,
                          Colors.black38, 7, 7),
                      onTap: () {
                        _requestPop();
                      },
                    ),

                    Expanded(child: SizedBox()),
                    new Offstage(
                      offstage: isEdit,
                      child: new InkWell(
                        child: backIcon(white, Icons.edit, Colors.black38,
                            0, defaultPaddingIcon),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditYourStoryWidget(subCat!),
                              )).then((value) {
                            setImageData();
                          });
                        },
                      ),
                    ),

                    new InkWell(
                      child: backIcon(white, Icons.format_size,
                          Colors.black38, 2, defaultPaddingIcon),
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
                    Container(
                      margin: EdgeInsets.only(right: 7),
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
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
                      // child: IconButton(
                      //   icon: Icon(
                      //     iconData,
                      //     color: Colors.white,
                      //   ),
                      //   // icon: widgetsBookmark!,
                      //   onPressed: () {
                      //     // if (subCat!.markRead == 0) {
                      //     //   subCat!.markRead = 1;
                      //     // } else {
                      //     //   subCat!.markRead = 0;
                      //     // }
                      //     // // var stringMap = subCat.cast<String, dynamic>
                      //     // _databaseHelper.updateSubCatFav(subCat!);
                      //     // _databaseHelper
                      //     //     .getSubCatByid(subCat!.id!)
                      //     //     .then((value) {
                      //     //   setState(() {
                      //     //     print("getupdate=${value!.fav!}");
                      //     //     subCat = value;
                      //     //     setbookmarkData();
                      //     //   });
                      //     // });
                      //
                      //     if (subCat!.fav == 0) {
                      //       subCat!.fav = 1;
                      //     } else {
                      //       subCat!.fav = 0;
                      //     }
                      //     _databaseHelper.updateSubCatFav(subCat!);
                      //     _databaseHelper
                      //         .getSubCatByid(subCat!.id!)
                      //         .then((value) {
                      //       setState(() {
                      //         print("getupdate=${value!.fav!}");
                      //         subCat = value;
                      //         setUpdateData();
                      //       });
                      //     });
                      //   },
                      // ),
                      child: IconButton(
                        icon: widgetsBookmark!,
                        padding: EdgeInsets.zero,
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

                    new InkWell(
                      child: backIcon(white, Icons.share, Colors.black38, 0,
                          defaultPaddingIcon),
                      onTap: () {
                        share();
                      },
                    ),

                    // new InkWell(
                    //   child: backImageIcon(
                    //       white,
                    //       Image.asset('assets/whatsapp.png'),
                    //       0,
                    //       defaultPaddingIcon),
                    //   // backIcon(white, Icons.share, Colors.black38,0,defaultPaddingIcon),
                    //   // // backIcon(white, Image.asset('assets/whatsapp.png'), Colors.black38),
                    //   onTap: () {
                    //     String s = S.of(context).appname +
                    //         "\n${subCat!.title}\n${decodeHtml(subCat!.story)}";
                    //     // String s = "$appname\n${subCat.title}\n${subCat.story}";
                    //     SocialShare.shareWhatsapp(s);
                    //   },
                    // ),
                    // new IconButton(
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,


                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        subCat!.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // color: Colors.black,
                            color: ConstantDatas.textColors,
                            fontSize: _fontSize.toDouble(),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Product_Sans_Regular"),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    // SingleChildScrollView(
                    //   child:
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity2,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16,right: 16,
                            bottom: 16),
                          child: InteractiveViewer(
                            child: HtmlWidget(
                              onTapImage: (p0) {
                                print('sizeeeeeeeeeee->$imgSize');
                              },
                              subCat!.story,
                              textStyle: TextStyle(
                                  color: ConstantDatas.textColors,
                                  fontSize: _fontSize.toDouble()),
                            ),
                          ),
                        // child:  InAppWebView(
                        //   initialUrlRequest: URLRequest(
                        //     body: bytesFromDataUri(subCat!.story,),
                        //   ) ,
                        //   initialOptions: InAppWebViewGroupOptions(
                        //     crossPlatform: InAppWebViewOptions(
                        //       allowUniversalAccessFromFileURLs: true,
                        //       // Enable zoom controls
                        //       useShouldOverrideUrlLoading: true,
                        //       javaScriptEnabled: true,
                        //       allowFileAccessFromFileURLs: true,
                        //       disableVerticalScroll: true,
                        //       supportZoom: true,
                        //       minimumFontSize: 15,
                        //     ),
                        //   ),
                        //   initialData: InAppWebViewInitialData(data: subCat!.story,),
                        // ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _showDialog(BuildContext contexta) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          // return new NumberPickerDialog(
          //   minValue: 14,
          //   maxValue: 35,
          //   title: new Text(S.of(context).pickAFontSize),
          //   initialIntegerValue: _fontSize,
          // );

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
            // content: NumberPicker(
            //   onChanged: (value) {
            //     setState(() {
            //       PrefData().addFontSize(value);
            //       _setFontSizes();
            //     });
            //   },
            //   minValue: 14,
            //   maxValue: 35,
            //   value: _fontSize,
            // ),
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
    // .then((int value)) {
    //   if (value != null) {
    //     setState(() => _currentPrice = value);
    //   }
    // });
  }
}

String decodeHtml(String codeUnits) {

  final document = parse(codeUnits);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  // String singleConvert = unescape.convert(codeUnits);
  return parsedString;
  // return unescape.convert(unescape.convert(singleConvert));
}
