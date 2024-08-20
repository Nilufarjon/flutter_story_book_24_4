import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_story_app/SubCategoryList.dart';
import 'package:flutter_story_app/contactPage.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:flutter_story_app/main.dart';
import 'package:flutter_story_app/model/ModelSubCategory.dart';

import 'ConstantDatas.dart';
import 'PrefData.dart';
import 'SizeConfig.dart';
import 'db/database_helper.dart';
import 'model/ModelMainCat.dart';
import 'themes/ThemeNotifier.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  _HomeWidget createState() => _HomeWidget();
}

final List<int> sliderlistId = [
  1,
  2,
  3,
  4,
  5,
  21
]; /*value(1,2,..) is a id of story define in database story_db,tablename(tbl_story) and value of field(id)*/

List<ModelMainCat> mainCatList = [];
List<ModelSubCategory> sliderList = [];
DatabaseHelper _databaseHelper = DatabaseHelper.instance;

class _HomeWidget extends State<HomeWidget> {
  //int _current = 0;
  ModelMainCat cat = new ModelMainCat();

  ThemeData? themeData;
  int posGet = 0;

  void setMaincatData() {
    mainCatList = [];
    _databaseHelper.getAllMainCatList().then((value) {
      setState(() {
        value.forEach((element) {
          ModelMainCat mainCat = ModelMainCat.fromMap(element);
          if (mainCat.id == ConstantDatas.yourStoryId) {
            cat = mainCat;
          } else {
            mainCatList.add(mainCat);
          }
          int count = mainCatList.length;
          print("listlength==$count==${mainCat.catImg}");
        });
        // if (cat != null) {
        //   mainCatList.add(cat);
        // }
      });
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ConstantDatas.setThemePosition(setState: setState);
    });
    sliderList = [];
    print("inhome===true");
    for (int i = 0; i < sliderlistId.length; i++) {
      _databaseHelper.getSubCatByid(sliderlistId[i]).then((value) {
        setState(() {
          sliderList.add(value!);
          // _mainCat = value;
          print("submodel==" + sliderList.length.toString() + "--" + value.img);
        });
      });
    }

    setMaincatData();
    setThemePosition();
    super.initState();
  }

  setThemePosition() async {
    posGet = await PrefData().getIsDarkMode();
    themeData = ThemeNotifier.themesList[posGet];
    // ignore: deprecated_member_use
    ConstantDatas.backgroundColors = themeData!.colorScheme.background;
    ConstantDatas.cardBackground = themeData!.cardColor;
    ConstantDatas.textColors = themeData!.textSelectionTheme.selectionColor!;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //double sliderHeight = SizeConfig.safeBlockVertical! * 30;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).appname,
            style: TextStyle(color: ConstantDatas.textColors),
          ),
          backgroundColor: ConstantDatas.backgroundColors,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                // _launchDialer("+992927741594");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new ContactPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.phone,
                color: Colors.blue.shade900,
                size: 30,
              ),
            )
          ],
        ),
        body: Container(
            color: ConstantDatas.backgroundColors,
            // color: "#ECE8E8".toColor(),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20,
                    // childAspectRatio: 1.5,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    shrinkWrap: true,
                    // childAspectRatio: 8.0 / 9.0,
                    children: List.generate(mainCatList.length, (index) {
                      ModelMainCat maincat = mainCatList[index];
                      print("size==$index---${mainCatList.length}");
                      // if (index == (mainCatList.length - 1)) {
                      //   return AddStoryItem(this, maincat);
                      // } else {
                      return MainStoryItem(
                        maincat: maincat,
                        posGet: posGet,
                      );
                      // }
                    }),
                  ),
                )
              ],
              // ),
            )));
  }

  void getDataList() {
    mainCatList = [];
    _databaseHelper.getAllMainCatList().then((value) {
      setState(() {
        value.forEach((element) {
          mainCatList.add(ModelMainCat.fromMap(element));
          int count = mainCatList.length;
          print("listsizes==$count");
        });
      });
    });
  }
}

class AddStoryItem extends StatefulWidget {
  final _HomeWidget homes;
  final ModelMainCat mainCats;

  AddStoryItem(this.homes, this.mainCats);

  @override
  _AddStoryItem createState() => _AddStoryItem(this.homes, this.mainCats);
}

class _AddStoryItem extends State<AddStoryItem> {
  _HomeWidget widgetHome;
  ModelMainCat _mainCat;

  _AddStoryItem(this.widgetHome, this._mainCat);

  final myTitleController = TextEditingController();
  final myStoryController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myTitleController.dispose();
    myStoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new SubCategoryList(_mainCat),
            // builder: (context) => GridItemDetails(this.item),
          ),
        );
      },
      child: new Card(
        elevation: 1.0,
        color: ConstantDatas.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            Icons.add_circle,
            color: ConstantDatas.primaryColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}

class MainStoryItem extends StatelessWidget {
  final ModelMainCat? maincat;
  final int posGet;

  MainStoryItem({this.maincat, required this.posGet});

  @override
  Widget build(BuildContext context) {
    print("getimage===${maincat!.catImg}");

    Widget widgets;
    File file = File(maincat!.catImg);
    print("istrue===${file.existsSync()}");
    // io.File(maincat.cat_img).exists();
    if (file.existsSync() == true) {
      print("istrue===");
      widgets = Image.file(
        File(maincat!.catImg),
        // fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      widgets = Image.asset(
        "assets/" + maincat!.catImg,
        //fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new SubCategoryList(maincat!),
          ),
        );
      },
      child: Container(
        // elevation: 0.7,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),

        decoration: BoxDecoration(
          color:
              (posGet == 0) ? "F4F4F4".toColor() : ConstantDatas.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(7), child: widgets),
              ),
              flex: 1,
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(27, 0, 27, 22),
              child: Center(
                child: Text(
                  maincat!.catName,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: ConstantDatas.textColors,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: ConstantDatas.textColors,
                  ),
                ),
              ),
            ),
          ],
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
    print("image---${item!.catImg}");
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
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.normal,
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
