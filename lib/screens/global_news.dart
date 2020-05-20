import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterapp/model/worldnews.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class GlobalNews extends StatefulWidget {
  @override
  _GlobalNewsState createState() => _GlobalNewsState();
}

class _GlobalNewsState extends State<GlobalNews>
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
    return SafeArea(child: Scaffold(
      body: Consumer<List<WorldNews>>(
        builder: (BuildContext context, List<WorldNews> news, _) {
          return news == null
              ? SpinKitPouringHourglass(
                  color: Colors.black,
                )
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/coffee1.png'),
                          fit: BoxFit.fitHeight)),
                  child: Container(
                    margin: EdgeInsets.only(top: 170, bottom: 20),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Card(
                            margin: EdgeInsets.only(top: 20, left: 100),
                            color: kGreenColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title:
                                  news[index].newDeaths != news[index].location
                                      ? Text(
                                          '${news[index].newCases} and  ${news[index].newDeaths} in ${news[index].location}',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text(
                                          '${news[index].newCases} and 0 deaths in ${news[index].location}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    ));
  }
}
