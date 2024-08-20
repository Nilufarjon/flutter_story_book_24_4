// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_story_app/ConstantDatas.dart';
import 'package:flutter_story_app/db/database_helper.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'dart:io' as io;import 'package:flutter_quill/flutter_quill.dart' as quillView;


import 'package:flutter_story_app/model/EditModel.dart';
import 'package:flutter_story_app/model/ModelSubCategory.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';




class EditYourStoryWidget extends StatefulWidget {
  final ModelSubCategory subCategory;

  EditYourStoryWidget(this.subCategory);

  @override
  _EditYourStoryWidget createState() => _EditYourStoryWidget(subCategory);
}

class _EditYourStoryWidget extends State<EditYourStoryWidget> {
  ModelSubCategory? _subCategory;

  TextEditingController myController = new TextEditingController();
  String title='', imageName='', description='';
  Widget? imagewidget;
  File? _image;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  quillView.QuillController _controller = quillView.QuillController.basic();

  _imgFromCamera() async {
    final _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
      imageName = _image!.path;

      refreshImageWidget();
      print("imagecamera==${_image!.path}");
    });
  }

  _EditYourStoryWidget(this._subCategory);

  _imgFromGallery() async {
    XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image!.path);
    setState(() {
      _image = File(image.path);
      imageName = _image!.path;
      refreshImageWidget();
      print("imagegallery==${_image!.path}");
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: ConstantDatas.backgroundColors,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: ConstantDatas.textColors,
                      ),
                      title: new Text(
                        S.of(context).photoLibrary,
                        style: TextStyle(color: ConstantDatas.textColors),
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: ConstantDatas.textColors,
                    ),
                    title: new Text(S.of(context).camera,
                        style: TextStyle(color: ConstantDatas.textColors)),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void refreshImageWidget() {
    if (io.File(imageName).existsSync()) {
      imagewidget = Image.file(
        File(imageName),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    } else {
      imagewidget = Image.asset(
        'assets/$imageName',
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    print('init===true');
    title = _subCategory!.title;
    imageName = _subCategory!.img;
    description = _subCategory!.story;
    myController = TextEditingController()..text = _subCategory!.title;




    EditModel editModel = new EditModel();
    editModel.key = _subCategory!.story;





    quillView.Delta _delta =new  quillView.Delta()..insert(_subCategory!.story);


    final doc = quillView.Document.fromDelta(_delta);
    _controller = quillView.QuillController(
        document: doc, selection:  TextSelection.collapsed(offset: _subCategory!.story.length-1));




    ConstantDatas.setThemePosition();
    refreshImageWidget();
  }

  @override
  void didChangeDependencies() {
    ConstantDatas.setThemePosition();
    setState(() {});
    super.didChangeDependencies();
  }



  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<bool> _onBackPressed() {

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new AlertDialog(
        // title: new Text('Are you sure?'),
        content: new Text(S.of(context).doYouWantToSaveEditedStory),
        buttonPadding: EdgeInsets.all(10),
        actions: <Widget>[
          new GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: Text(
              "NO",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 16),
          new GestureDetector(
            onTap: () async {
              description =  _controller.plainTextEditingValue.text.toString();

              title = myController.value.text;
              if (description.isNotEmpty) {
                _subCategory!.story = description;
              }
              if (title.isNotEmpty) {
                _subCategory!.title = title;
              }
              print("imgsave==$imageName");
              if (imageName.isNotEmpty) {
                _subCategory!.img = imageName;
              }

              // if (description.isNotEmpty &&
              //     title.isNotEmpty &&
              //     imageName.isNotEmpty) {
              _databaseHelper.updateStory(_subCategory!);

              // Toast.show(S.of(context).storyUpdatedSuccessfully, context,
              //     backgroundColor: Colors.black38,
              //     textColor: Colors.white,
              //     duration: Toast.LENGTH_LONG,
              //     gravity: Toast.BOTTOM);


              Fluttertoast.showToast(
                  msg: S.of(context).storyUpdatedSuccessfully,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black38,
                  textColor: Colors.white,
                  fontSize: 16.0);


              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: Text(
              S.of(context).yes,
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _onBackPressed();
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: ConstantDatas.primaryColor,
            title: Text(
              S.of(context).yourStory,
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
              onPressed: () => _onBackPressed(),
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggle();
                      });
                    },
                    child: Icon(
                      Icons.zoom_out_map,
                      size: 26.0,
                      color: Colors.white,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      // description = await keyEditor.currentState!.getText();

                      description =  _controller.plainTextEditingValue.text.toString();

                      title = myController.value.text;
                      if (description.isNotEmpty) {
                        _subCategory!.story = description;
                      }
                      if (title.isNotEmpty) {
                        _subCategory!.title = title;
                      }
                      print("imgsave==$imageName");
                      if (imageName.isNotEmpty) {
                        _subCategory!.img = imageName;
                      }
                      _databaseHelper.updateStory(_subCategory!);
                      // Toast.show(
                      //     S.of(context).storyUpdatedSuccessfully, context,
                      //     backgroundColor: Colors.black38,
                      //     textColor: Colors.white,
                      //     duration: Toast.LENGTH_LONG,
                      //     gravity: Toast.BOTTOM);

                      Fluttertoast.showToast(
                          msg: S.of(context).storyUpdatedSuccessfully,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black38,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.check_box,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: ConstantDatas.backgroundColors,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  children: [
                    Offstage(
                      offstage: _visible,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                            controller: myController,
                            autofocus: true,
                            style: TextStyle(color: ConstantDatas.textColors),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: ConstantDatas.primaryColor)),
                                hintText: S.of(context).enterStoryTitle,
                                labelText: S.of(context).enterStoryTitle,
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.grey))
                            ),
                      ),
                    ),
                    Offstage(
                      offstage: _visible,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 5, bottom: 8),
                        child: Row(
                          children: [
                            imagewidget!,
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: ElevatedButton.icon(

                                onPressed: () {
                                  _showPicker(context);
                                  // print('Button Clicked.');
                                },

                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  // primary: ConstantDatas.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))
                                ),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.all(
                                //         Radius.circular(10.0))),
                                label: Text(
                                  S.of(context).selectImage,
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                                // textColor: Colors.white,
                                // splashColor: Colors.grey,
                                // color: ConstantDatas.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.all(8),
                      child: quillView.QuillProvider(
                        configurations: quillView.QuillConfigurations(controller: _controller),
                        child: quillView.QuillToolbar(
                          configurations: quillView.QuillToolbarConfigurations(
                            color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ConstantDatas.cardBackground,
                            ),
                            showBoldButton: true,
                            showUnderLineButton: true,
                            showItalicButton: true,
                            multiRowsDisplay: false,
                            showLink: false,
                            showHeaderStyle: false,
                            showColorButton: false,
                            showStrikeThrough: false,
                            showFontFamily:false,
                            showFontSize: false,
                            showClearFormat: true

                          ),

                            // controller: _controller,
                            // multiRowsDisplay: false,
                            // showLink: false,
                            // showHeaderStyle: false,
                            // showItalicButton: false,
                            // // showVideoButton: false,
                            // showColorButton: false,
                            // showStrikeThrough: false
                        ),
                      ),
                    ),

                    Expanded(
                      // child: HtmlEditor(
                      //   hint: S.of(context).yourStory,
                      //
                      //   key: keyEditor,
                      //   showBottomToolbar: false,
                      // ),
                      child:Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: ConstantDatas.cardBackground,
                        ),
                        child: quillView.QuillProvider(
                          configurations: quillView.QuillConfigurations(controller: _controller,

                          ),
                          child: quillView.QuillEditor(
                            


                            configurations: quillView.QuillEditorConfigurations(
                              scrollable: true,
                              autoFocus: true,
                              readOnly: false,
                              enableInteractiveSelection: true,
                              expands: false,
                              padding: EdgeInsets.zero,
                              enableSelectionToolbar: true,

                              customStyles: quillView.DefaultStyles(
                                color: Colors.red,
                                // paragraph: quillView.DefaultTextBlockStyle(
                                //     TextStyle(
                                //       color: ConstantDatas.textColors,
                                //     ),
                                //     const Tuple2(16, 0),
                                //     const Tuple2(0, 0),
                                //     null

                            ),
                            ),




                            scrollController: ScrollController(),
                            focusNode: FocusNode(

                            ),



                            ),
                        ),


                      //       scrollable: true,
                      //       focusNode: new FocusNode(),
                      //       autoFocus: true,
                      //       readOnly: false,
                      //
                      //       enableInteractiveSelection: true,
                      //       // placeholder: 'Add content',
                      //       expands: false,
                      //       padding: EdgeInsets.zero,
                      //       customStyles: quillView.DefaultStyles(
                      //         // color: Colors.white,
                      //
                      //         // paragraph: quillView.DefaultTextBlockStyle(
                      //         //     TextStyle(
                      //         //       color: ConstantDatas.textColors,
                      //         //     ),
                      //         //     const Tuple2(16, 0),
                      //         //     const Tuple2(0, 0),
                      //         //     null
                      //         // ),
                      //       )
                      // ),
                      ),



                      flex: 1,
                    ),
                    // Expanded(
                    //   child: HtmlEditor(
                    //     hint: S.of(context).yourStory,
                    //     value: _subCategory!.story,
                    //     //value: "text content initial, if any",
                    //     key: keyEditor,
                    //     showBottomToolbar: false,
                    //   ),
                    //   flex: 1,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ) // Your Scaffold goes here.
        );
  }





}


// Expanded(
// child: QuillProvider(
// configurations: QuillConfigurations(
// controller: _controller,
// sharedConfigurations: const QuillSharedConfigurations(
// locale: Locale('de'),
// ),
// ),
// child: Column(
// children: [
// const QuillToolbar(),
// Expanded(
// child: QuillEditor.basic(
// configurations: const QuillEditorConfigurations(
// readOnly: false,
// ),
// ),
// )
// ],
// ),
// ),
// )