import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/main.dart';
import 'package:flutter_story_app/model/ModelSubCategory.dart';
import 'ConstantDatas.dart';
import 'PrefData.dart';
import 'SizeConfig.dart';
import 'StoryDetail.dart';
import 'db/database_helper.dart';
import 'model/ModelMainCat.dart';
import 'themes/ThemeNotifier.dart';

class FavouriteWidget extends StatefulWidget {
  @override
  _FavouriteWidget createState() => _FavouriteWidget();
}

final List<int> sliderlistId = [1, 2, 3, 4, 5];

List<ModelSubCategory> mainCatList = [];
DatabaseHelper _databaseHelper = DatabaseHelper.instance;

class _FavouriteWidget extends State<FavouriteWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  ThemeData? themeData;
  int posGet = 0;

  void setMaincatData() {
    mainCatList = [];
    _databaseHelper.getAllFavItem().then((value) {
      setState(() {
        value.forEach((element) {
          ModelSubCategory mainCat = ModelSubCategory.fromMap(element);
          mainCatList.add(mainCat);
        });
      });
    });
  }

  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    setMaincatData();
    setThemePosition();
  }

  setThemePosition() async {
    posGet = await PrefData().getIsDarkMode();
    themeData = ThemeNotifier.themesList[posGet];
    // ignore: deprecated_member_use
    ConstantDatas.backgroundColors = themeData!.colorScheme.background;
    ConstantDatas.cardBackground = themeData!.cardColor;
    ConstantDatas.textColors = themeData!.textSelectionTheme.selectionColor!;
  }

  Widget? setWidgets;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (mainCatList.isNotEmpty) {
      // setWidgets = Container(
      //     color: ConstantDatas.backgroundColors,
      //     child: Column(
      //       children: [
      //         Expanded(
      //           flex: 1,
      //           child: Container(
      //             child: GridView.count(
      //               crossAxisCount: 2,
      //               childAspectRatio: 1.2,
      //               padding: EdgeInsets.all(7),
      //               shrinkWrap: true,
      //               // childAspectRatio: 8.0 / 9.0,
      //               children: List.generate(mainCatList.length, (index) {
      //                 ModelSubCategory maincat = mainCatList[index];
      //                 print("size==$index---${mainCatList.length}");
      //                 return FavStoryItem(maincat: maincat);
      //               }),
      //             ),
      //           ),
      //         )
      //
      //       ],
      //       // ),
      //     ));
      setWidgets = new Container(
        width: double.infinity,
        // height: SizeConfig.safeBlockVertical * 60,
        decoration: BoxDecoration(
          color: ConstantDatas.backgroundColors,
        ),
        padding: EdgeInsets.all(10),
        child: ListView.separated(
          padding: EdgeInsets.only(top: 8, bottom: 24),
          physics: BouncingScrollPhysics(),
          primary: true,
          separatorBuilder: (context, index) => SizedBox(
            height: 16,
          ),
          itemBuilder: (context, index) {
            ModelSubCategory maincat = mainCatList[index];
            //final int count = mainCatList.length;
            print("size==$index---${mainCatList.length}");
            final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(
              // Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve:
                    Interval((1 / 6) * index, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
            animationController!.forward();

            return FavStoryItem(
              maincat: maincat,
              animationController: animationController!,
              animation: animation,
              posGet: posGet,
            );
          },
          itemCount: mainCatList.length,
        ),
      );
    } else {
      setWidgets = Container(
          color: ConstantDatas.backgroundColors,
          child: Center(
            child: Text(
              S.of(context).dataNotFound,
              style: TextStyle(
                  color: ConstantDatas.textColors, fontWeight: FontWeight.bold),
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).favourite,
            style: TextStyle(color: ConstantDatas.textColors)),
        backgroundColor: ConstantDatas.backgroundColors,
        centerTitle: true,
      ),
      body: setWidgets,
    );
  }

  void getDataList() {
    mainCatList = [];
    _databaseHelper.getAllFavItem().then((value) {
      setState(() {
        value.forEach((element) {
          mainCatList.add(ModelSubCategory.fromMap(element));
          int count = mainCatList.length;
          print("listsizes==$count");
        });
      });
    });
  }
}

class AddStoryItem extends StatefulWidget {
  final _FavouriteWidget homes;

  AddStoryItem(this.homes);

  @override
  _AddStoryItem createState() => _AddStoryItem(this.homes);
}

class _AddStoryItem extends State<AddStoryItem> {
  _FavouriteWidget widgetHome;

  _AddStoryItem(this.widgetHome);

  final myTitleController = TextEditingController();
  final myStoryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    myTitleController.dispose();
    myStoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {},
      child: new Card(
        elevation: 1.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.black87,
            size: 50,
          ),
        ),
      ),
    );
  }
}

class FavStoryItem extends StatelessWidget {
  final ModelSubCategory? maincat;
  final AnimationController animationController;
  final Animation<double> animation;
  final int posGet;

  FavStoryItem(
      {this.maincat,
      required this.animationController,
      required this.animation,
      required this.posGet});

  @override
  Widget build(BuildContext context) {
    print("getimage===${maincat!.img}");
    //bool _visible = true;

    Widget widgets;
    File file = File(maincat!.img);
    // print("ismark===${maincat.markRead}");
    // if (maincat!.markRead == 1) {
    //   _visible = false;
    // } else {
    //   _visible = true;
    // }
    if (file.existsSync() == true) {
      // print("istrue===");
      widgets = Image.file(
        File(maincat!.img),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      widgets = Image.asset(
        "assets/" + maincat!.img,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: Matrix4.translationValues(0.0, 20 * (0.0 - 0), 0.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new StoryDetail(maincat!),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: (posGet == 0)
                  ? "F4F4F4".toColor()
                  : ConstantDatas.cardBackground,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    maincat!.title,
                    maxLines: 2,
                    style: TextStyle(
                      color: ConstantDatas.textColors,
                      fontSize: 18,
                      // color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                    height: 85,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: widgets),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final ModelMainCat? item;

  const ItemList({@required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 12.0,
              child: Image.asset(
                "assets/" + item!.catImg,
                fit: BoxFit.cover,
              ),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item!.catName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
