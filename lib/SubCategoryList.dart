// ignore_for_file: deprecated_member_use

import 'dart:io';

//import 'package:admob_flutter/admob_flutter.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_story_app/ConstantDatas.dart';
import 'package:flutter_story_app/main.dart';
import 'package:flutter_story_app/model/ModelMainCat.dart';
import 'package:flutter_story_app/themes/ThemeNotifier.dart';

import 'PrefData.dart';
import 'SizeConfig.dart';
import 'StoryDetail.dart';
import 'db/database_helper.dart';
import 'model/ModelSubCategory.dart';

class SubCategoryList extends StatefulWidget {
  // int mainCatid;
  final ModelMainCat mainCat;

  SubCategoryList(this.mainCat);

  @override
  _SubCategoryList createState() => _SubCategoryList(this.mainCat);
}

//AdmobInterstitial? interstitialAd;

DatabaseHelper _databaseHelper = DatabaseHelper.instance;
List<ModelSubCategory> subCatList = [];

class _SubCategoryList extends State<SubCategoryList>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  Color appBarBackground = Colors.white;
  double topPosition = 0;

  AnimationController? animationController;

  // final AnimationController animationController;
  Animation<dynamic>? animation;

  ModelMainCat? cats;

  _SubCategoryList(this.cats);

  void getSubDataList() {
    subCatList = [];

    _databaseHelper.getAllSubCatByMainCat(cats!.id!).then((value) {
      setState(() {
        value.forEach((element) {
          subCatList.add(ModelSubCategory.fromMap(element));
        });
      });
    });
  }

  double _getOpacity() {
    double op = (topPosition + 80) / 80;
    return op > 1 || op < 0 ? 1 : op;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("activity==resume");
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      print("activity==inactive");
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      print("activity==pause");
      // user is about quit our app temporally
    }
    // else if(state == AppLifecycleState.suspending){
    //   app suspended (not used in iOS)
    // }
  }

  @override
  void didUpdateWidget(covariant SubCategoryList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("updatewidget===true");
  }

  @override
  void initState() {
    topPosition = -80;
    appBarBackground = Colors.transparent;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    getSubDataList();
    ConstantDatas.setThemePosition();

    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scrollController.addListener(_onScroll);

    setThemePosition();

    // interstitialAd = AdmobInterstitial(
    //
    //   adUnitId: getInterstitialAdUnitId(),
    //     listener: (AdmobAdEvent? event, Map<String?, dynamic>? args) {
    //       if (event == AdmobAdEvent.closed) interstitialAd!.load();
    //
    //     }
    // );

    // interstitialAd = AdmobInterstitial(
    //     adUnitId: getInterstitialAdUnitId(),
    //
    //     listener: (AdmobAdEvent? event, Map<String?, dynamic>? args) {
    //       if (event == AdmobAdEvent.closed) interstitialAd!.load();
    //     }
    //     // listener: (AdmobAdEvent? event, Map<String?, dynamic> args) {
    //     //   if (event == AdmobAdEvent.closed) interstitialAd!.load();
    //     //   // handleEvent(event, args, 'Interstitial');
    //     // },
    //
    //
    //     );

    //interstitialAd!.load();
  }

  ThemeData? themeData;
  int posGet = 0;

  setThemePosition() async {
    posGet = await PrefData().getIsDarkMode();
    themeData = ThemeNotifier.themesList[posGet];
    ConstantDatas.backgroundColors = themeData!.colorScheme.background;
    ConstantDatas.cardBackground = themeData!.cardColor;
    ConstantDatas.textColors = themeData!.textSelectionTheme.selectionColor!;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return '';
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Widget widgets;
    File file = File(cats!.catImg);
    print("istrue===${file.existsSync()}");

    Future<bool> _requestPop() {
      Navigator.of(context).pop();
      return new Future.value(false);
      // }
      // else {
      //   return new Future.value(true);
      // }
    }

    // return new Scaffold(
    return WillPopScope(
      child: Scaffold(
          backgroundColor: ConstantDatas.backgroundColors,
          body: ColorfulSafeArea(
            color: ConstantDatas.backgroundColors,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 0, top: 25.0, right: 0),
                  // width: double.infinity,
                  child: new IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ConstantDatas.textColors,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 25),
                    primary: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //             height:
                      //                 SizeConfig.safeBlockVertical! * 8),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 50),
                        child: Text(
                          cats!.catName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: ConstantDatas.textColors),
                        ),
                      ),
                      new Container(
                        width: double.infinity,
                        // height: SizeConfig.safeBlockVertical * 60,
                        decoration: BoxDecoration(

                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black12,
                            //     blurRadius: 16.0,
                            //   ),
                            // ],
                            color: ConstantDatas.backgroundColors),

                        padding: EdgeInsets.all(10),
                        // child: new GridView.count(
                        //   crossAxisCount: 2,
                        //   // childAspectRatio: 0.7,
                        //   childAspectRatio: 1.4,
                        //   padding: EdgeInsets.all(7),
                        //   primary: false,
                        //   shrinkWrap: true,
                        //   children:
                        //       List.generate(subCatList.length, (index) {
                        //     final int count = subCatList.length;
                        //
                        //     ModelSubCategory subcat = subCatList[index];
                        //     final Animation<double> animation =
                        //         Tween<double>(begin: 0.0, end: 1.0)
                        //             .animate(
                        //       // Tween<double>(begin: 0.0, end: 1.0).animate(
                        //       CurvedAnimation(
                        //         parent: animationController!,
                        //         curve: Interval((1 / count) * index, 1.0,
                        //             curve: Curves.fastOutSlowIn),
                        //       ),
                        //     );
                        //     animationController!.forward();
                        //
                        //     return SubStoryItem(
                        //         subcat, animationController!, animation);
                        //   }),
                        // ),
                        // ),
                        child: ListView.separated(
                          padding: EdgeInsets.only(top: 8),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 16,
                          ),
                          itemBuilder: (context, index) {
                            final int count = subCatList.length;
                            ModelSubCategory subcat = subCatList[index];
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              // Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController!.forward();
                            return SubStoryItem(subcat, animationController!,
                                animation, posGet);
                          },
                          itemCount: subCatList.length,
                        ),
                      ),
                      // AdmobBanner(
                      //     adUnitId: getBannerAdUnitId(),
                      //     adSize: AdmobBannerSize.BANNER)
                    ],
                  ),
                ),
              ],
            ),
          )
          // )
          // ),
          ),
      onWillPop: _requestPop,
    );

    // }
  }
}

class SubStoryItem extends StatefulWidget {
  final ModelSubCategory mainCat;
  final AnimationController animationController;
  final Animation<double> animation;
  final int posGet;

  SubStoryItem(
      this.mainCat, this.animationController, this.animation, this.posGet);

  @override
  _SubStoryItem createState() =>
      _SubStoryItem(mainCat, animationController, animation);
}

class _SubStoryItem extends State<SubStoryItem> with WidgetsBindingObserver {
  ModelSubCategory maincat;
  final AnimationController animationController;
  final Animation<double> animation;
  bool _visible = true;
  DatabaseHelper helper = DatabaseHelper.instance;

  _SubStoryItem(this.maincat, this.animationController, this.animation);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    helper.getSubCatByid(maincat.id!).then((value) {
      maincat = value!;
    });
    ConstantDatas.setThemePosition();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    Widget widgets;
    File file = File(maincat.img);
    print("ismark===${maincat.img}");
    if (maincat.markRead == 1) {
      _visible = false;
    } else {
      _visible = true;
    }
    if (file.existsSync() == true) {
      // print("istrue===");
      widgets = Image.file(
        File(maincat.img),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      widgets = Image.asset(
        "assets/" + maincat.img,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (0.0 - 0), 0.0),
            child: InkWell(
              onTap: () async {
                // bool? isLoaded = await interstitialAd!.isLoaded;
                // if (isLoaded != null && isLoaded) {
                //   interstitialAd!.show();
                //
                // }
                // else {
                Navigator.push(
                  context!,
                  MaterialPageRoute(
                    builder: (context) => StoryDetail(this.maincat),
                    // builder: (context) => GridItemDetails(this.item),
                  ),
                ).then((value) {
                  // Toast.show("get1mths", context);
                  _databaseHelper.getSubCatByid(this.maincat.id!).then((value) {
                    setState(() {
                      this.maincat = value!;
                    });
                  });
                });
                // }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (widget.posGet == 0)
                      ? "F4F4F4".toColor()
                      : ConstantDatas.cardBackground,
                  borderRadius: BorderRadius.circular(24),
                ),
                // color: themeDatas.cardColor,
                // color: Colors.white,
                // elevation: 1.0,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(7),
                // ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        maincat.title,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 18, color: ConstantDatas.textColors
                            // color: Colors.black87,
                            ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                            height: 85,
                            width: 85,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 16.0,
                                  ),
                                ]),
                            child: widgets),
                        Offstage(
                            offstage: _visible,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: ConstantDatas.primaryColor,
                                  ),
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
