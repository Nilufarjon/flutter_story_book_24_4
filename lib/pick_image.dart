import 'package:flutter/material.dart';
import 'package:flutter_story_app/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';


typedef void CallbackValue(dynamic value);
class PickImage extends StatelessWidget {
  final CallbackValue? callbackFile;
  final Color? color;

  PickImage({this.callbackFile, this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {
                        getImage(true);
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Icon(
                              Icons.linked_camera,
                              color: color ?? Colors.black45,
                              size: 44,
                            ),
                          ),
                          Text(
                           S.of(context).camera,
                            style: TextStyle(color: color ?? Colors.black45),
                          ),
                        ],
                      ),

                    ),
                  ),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: TextButton(

                      onPressed: () {
                        getImage(false);
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Icon(
                              Icons.image,
                              color: color ?? Colors.black45,
                              size: 44,
                            ),
                          ),
                          Text(
                            S.of(context).photoLibrary,
                            style: TextStyle(color: color ?? Colors.black45),
                          ),
                        ],
                      ),

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

  Future getImage(bool isKamera) async {
    ImagePicker _picker=ImagePicker();
    // var image = await ImagePicker.pickImage(
    var image = await _picker.pickImage(
      source: isKamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 800.0,
      maxHeight: 600.0,
    );

    if (image != null) {
      callbackFile!(image);
    }
  }
}
