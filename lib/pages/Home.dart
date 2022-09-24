import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yukmasak/pages/list.dart';
import 'package:yukmasak/pages/profil.dart';

import '../colors.dart';
import 'dashboard.dart';
import 'like.dart';

int Number = 0;

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final tabs = [
    Dashboard(),
    ListMasakan(),
    Like(),
    Profil(),
  ];

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: tabs[Number],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        height: screenWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                Number = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .2125,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == Number ? screenWidth * .12 : 0,
                      width: index == Number ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                        color: index == Number
                            ? kPrimary.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == Number ? kPrimary : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.format_list_bulleted,
    Icons.favorite_rounded,
    Icons.person_rounded,
  ];
}
