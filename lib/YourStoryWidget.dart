import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quillView;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_story_app/ConstantDatas.dart';
import 'package:flutter_story_app/SizeConfig.dart';
import 'package:flutter_story_app/db/database_helper.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'dart:io' as io;

import 'package:flutter_story_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class YourStoryWidget extends StatefulWidget {
  @override
  _YourStoryWidget createState() => _YourStoryWidget();
}

class _YourStoryWidget extends State<YourStoryWidget> {
  TextEditingController myController = TextEditingController();
  String title='', imageName = "kindness1.jpg", description='';
  Widget? imagewidget;
  File? _image;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  _imgFromCamera() async {
    final _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera

        );

    setState(() {
      _image = File(image!.path);
      imageName = _image!.path;
      refreshImageWidget();
      print("imagecamera==${_image!.path}");
    });
  }

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

  FocusNode _focusNode= new FocusNode();

  @override
  void initState() {
    super.initState();

    print('init===true');
    ConstantDatas.setThemePosition();
    refreshImageWidget();
    // setState(() {
    //
    // });
  }
  quillView.QuillController _controller = quillView.QuillController.basic();
  QuillController controller = QuillController.basic();



  /// Safely access inherited widgets here.
  // @override
  // void didInitState() {
  //
  //   myController = new TextEditingController(text: S.of(context).appname);
  //   title = myController.value.text.toString();
  //   ConstantDatas.setThemePosition();
  //   setState(() {});
  // }

  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: ConstantDatas.primaryColor,
        title: Text(
          S.of(context).yourStory,
          style: TextStyle(color: Colors.white),
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
                  description =  _controller.plainTextEditingValue.text.toString();
                  // description = await keyEditor.currentState!.getText();
                  title = myController.value.text;
                  if (description.isNotEmpty &&
                      title.isNotEmpty &&
                      imageName.isNotEmpty) {
                    _databaseHelper.insertSubCat(title, description, imageName);
                  }else{
                    return;
                  }
                  // Navigator.push(
                  // Toast.show(S.of(context).storyAddedSuccessfully, context,
                  //     backgroundColor: Colors.black38,
                  //     textColor: Colors.white,
                  //     duration: Toast.LENGTH_LONG,
                  //     gravity: Toast.BOTTOM);

                  Fluttertoast.showToast(
                      msg:S.of(context).storyAddedSuccessfully,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black38,
                      textColor: Colors.white,
                      fontSize: 16.0);


                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LangDemoRun(),
                    ),
                  );
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
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Offstage(
                offstage: _visible,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: myController,
                    autofocus: true,
                    style: TextStyle(color: ConstantDatas.textColors),
                    // decoration: new InputDecoration(
                    //   focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     borderSide: BorderSide(color: Colors.deepOrange),
                    //   ),
                    //   enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     borderSide: BorderSide(width: 1, color: Colors.blue),
                    //   ),
                    // ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color:Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ConstantDatas.primaryColor)),
                        hintText: S.of(context).enterStoryTitle,
                        labelText: S.of(context).enterStoryTitle,
                        hintStyle: TextStyle(color:Colors.grey),
                        labelStyle: TextStyle(color:Colors.grey),
                    ),
                  ),
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(color: Colors.deepOrange),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(width: 1, color:  Colors.deepOrange),
              //     ),
              //     hintText: "New Phone Number",
              //     hintStyle: TextStyle(color: Colors.blue),
              //     labelStyle: TextStyle(color:  Colors.blue),
              //     labelText: "New Phone Number",
              //     alignLabelWithHint: false,
              //     filled: true,
              //   ),
              //   keyboardType: TextInputType.phone,
              //   textInputAction: TextInputAction.done,
              // ),
              Offstage(
                offstage: _visible,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 8),
                  child: Row(
                    children: [
                      imagewidget!,


                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ElevatedButton.icon(
                          // padding: EdgeInsets.all(10),
                          // EdgeInsets.only(left: 10, right:10, top: 7, bottom: 7),
                          onPressed: () {
                            _showPicker(context);
                            // print('Button Clicked.');
                          },style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          // textColor: Colors.white,
                          // splashColor: Colors.grey,
                          // primary: ConstantDatas.primaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),

                          // shape: RoundedRectangleBorder(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10.0))),
                          label: Text(
                            S.of(context).selectImage,
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),

                        ),
                      )
                      // ),
                    ],
                  ),
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.all(8),
              //   child: QuillProvider(
              //     configurations: QuillConfigurations(
              //       controller: _controller,
              //       sharedConfigurations: const QuillSharedConfigurations(
              //         locale: Locale('de'),
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         const QuillToolbar(),
              //         Expanded(
              //           child: QuillEditor.basic(
              //             configurations: const QuillEditorConfigurations(
              //               readOnly: false,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
///
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
                  child:QuillProvider(
                    configurations: QuillConfigurations(
                      controller: _controller,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),

                    ),
                    child: Column(
                      children: [
                        const QuillToolbar(
                          configurations: quillView.QuillToolbarConfigurations(
                            showUndo: true,
                            showBoldButton: true,
                            showFontFamily: false,
                            showAlignmentButtons: true,
                            showSearchButton: true,
                            showRedo: true,
                            showBackgroundColorButton: false,
                            showFontSize: false,
                            showInlineCode: false,
                            showDividers: false,
                            showJustifyAlignment: false,
                            showSmallButton: false,
                            showListNumbers: false,
                            showClearFormat: false,
                            showCenterAlignment: true,
                            showColorButton: false,
                            showCodeBlock: false,
                            showHeaderStyle: false,
                            showIndent: false,
                            showItalicButton: true,
                            showLink: false,
                            showQuote: false,
                            showStrikeThrough: false,
                              showUnderLineButton: false,
                            showListBullets: false,
                            showDirection: false,
                            showSubscript: false,
                            showSuperscript: false,
                            showLeftAlignment: true,
                            showRightAlignment: true,
                            showListCheck: false,









                          ),
                        ),
                        QuillEditor.basic(
                          focusNode: _focusNode,
                          configurations: const QuillEditorConfigurations(

                            readOnly: false,
                          ),
                          scrollController: ScrollController(),
                        )
                      ],
                    ),
                  ),
                ),



                flex: 1,
              )


            ],
          ),
        )),
      ),


    );
  }
}
