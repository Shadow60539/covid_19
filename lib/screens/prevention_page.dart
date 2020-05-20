import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/global_news.dart';
import 'package:flutterapp/screens/piechart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

class PreventionPage extends StatefulWidget {
  @override
  _PreventionPageState createState() => _PreventionPageState();
}

class _PreventionPageState extends State<PreventionPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/blue.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topRight)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    'Prevention',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kVioletColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30),
                  child: Image.asset(
                    'images/doctor.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyCard(
                  lottie: 'wear_mask',
                  title: 'Wear mask',
                  content:
                      'Wearing a facial mask is compulsory for anyone stepping out of their house.',
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                    lottie: 'wash_hands',
                    title: 'Wash your hands',
                    content:
                        'Clean your hands often. Use soap and water, or an alcohol-based hand rub.'),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  lottie: 'distance',
                  title: 'Maintain social distance',
                  content:
                      'Maintain a distance of at least 2 metre from others. ',
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  lottie: 'home',
                  title: 'Stay home stay safe',
                  content:
                      'It is the only vaccine that has been invented till now.',
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  lottie: 'sick',
                  title: 'Emergency',
                  content:
                      'If you have a fever, cough and difficulty breathing, seek medical attention. Call in advance',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  @override
  _MyCardState createState() => _MyCardState();

  final String lottie, title, content;

  MyCard({this.lottie, this.title, this.content});
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 150,
      margin: EdgeInsets.only(left: 30),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            child: Row(
          children: <Widget>[
            Expanded(
              child: Lottie.asset(
                'lottie/${widget.lottie}.json',
                height: 120,
                width: 120,
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward();
                  setState(() {
                    _controller.addStatusListener((status) {
                      if (status == AnimationStatus.completed) {
                        _controller.reverse();
                      } else if (status == AnimationStatus.dismissed) {
                        _controller.forward();
                      }
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  '${widget.title}',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '${widget.content}',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Read More',
                            style: TextStyle(color: Colors.green, fontSize: 8),
                          ),
                          Text(
                            '( 103 discussions )',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
