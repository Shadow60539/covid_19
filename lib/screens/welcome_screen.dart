import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/piechart.dart';
import 'package:flutterapp/screens/prevention_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import 'global_news.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentIndex = 0;
  Widget changePage(int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
        return Scaffold();
      case 1:
        return PreventionPage();
      case 2:
        return PieChartScreen();
      case 3:
        return GlobalNews();
        break;
      default:
        return WelcomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Covid',
              style: TextStyle(
                  fontFamily: 'Baloon',
                  fontSize: 20,
                  color: Color(0xFF61688B),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '19',
              style: TextStyle(
                  fontFamily: 'Baloon',
                  fontSize: 20,
                  color: kGreenColor,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Color(0xFF61688B),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              color: Color(0xFF61688B),
            ),
          )
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: kGreenColor,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.home,
                color: kGreenColor,
              ),
              title: Text(
                "Home",
              )),
          BubbleBottomBarItem(
              backgroundColor: kGreenColor,
              icon: Icon(
                Icons.accessibility,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.accessibility_new,
                color: kGreenColor,
              ),
              title: Text("Health")),
          BubbleBottomBarItem(
              backgroundColor: kGreenColor,
              icon: FaIcon(
                FontAwesomeIcons.globeAmericas,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.globeAmericas,
                color: kGreenColor,
              ),
              title: Text(
                "World",
              )),
          BubbleBottomBarItem(
              backgroundColor: kGreenColor,
              icon: FaIcon(
                FontAwesomeIcons.newspaper,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.newspaper,
                color: kGreenColor,
              ),
              title: Text(
                "News",
              )),
        ],
      ),
      body: currentIndex == 0
          ? Center(
              child: Text(
              'Under Construction',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  letterSpacing: 2),
            ))
          : changePage(currentIndex),
    );
  }
}
