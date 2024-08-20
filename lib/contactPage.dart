import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ConstantDatas.dart';
import 'generated/l10n.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

void _launchDialer(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else {
    throw 'Could not launch $launchUri';
  }
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantDatas.backgroundColors,
      appBar: AppBar(
        backgroundColor: Color(0xFF53C9ED),
        foregroundColor: Color(0xFF53C9ED),
        title: Text(
          S.of(context).contactPage,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipPath(
                  clipper: Customshape(),
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFF53C9ED),
                  ),
                ),
                Positioned(
                  right: 50,
                  child: Image.asset(
                    "assets/c5.png",
                    height: 70,
                    width: 70,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _launchDialer("+992931800220");
                          },
                          child: Text(
                            "+992931800220",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                // color: ConstantDatas.textColors,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.cyan,
                                decorationColor: Colors.cyan),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 91, right: 20),
                    child: Text(
                      S
                          .of(context)
                          .poLegalInitiativeTheseAreTheNumbersThatParentsCan,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _launchDialer("2-27-31-34 ");
                          },
                          child: Text(
                            "2-27-31-34",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                // color: ConstantDatas.textColors,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.cyan,
                                decorationColor: Colors.cyan),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 91, right: 20),
                    child: Text(
                      "Раёсати ҳуқуқи кӯдак",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _launchDialer("225 85 35");
                          },
                          child: Text(
                            "225 85 35",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                // color: ConstantDatas.textColors,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.cyan,
                                decorationColor: Colors.cyan),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 91, right: 20),
                    child: Text(
                      "Агентии назорат дар соҳаи маориф ва илми назди Президенти Ҷумҳурии Тоҷикистон ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _launchDialer("(992 939 222 111)");
                          },
                          child: Text(
                            "(992) 939 222 111",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                // color: ConstantDatas.textColors,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.cyan,
                                decorationColor: Colors.cyan),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 91, right: 20),
                    child: Text(
                      "Раёсати огоҳонӣ ва пешгирии ҳуқуқвайронкунии ноболиғону ҷавонони ВКД Ҷумҳурии Тоҷикистон",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Customshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 110);
    path.quadraticBezierTo(width / 2, height, width, height - 110);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
