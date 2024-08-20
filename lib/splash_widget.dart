
import 'package:flutter/material.dart';
import 'package:flutter_story_app/main.dart';

class SplashWidget extends StatefulWidget {
  final ThemeData? data;

  final String? locals;

  SplashWidget({Key? key,this.data, this.locals}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                data: widget.data,
                locals: widget.locals,
              )));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/" + "title.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

