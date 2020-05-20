import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterapp/model/world.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'global_news.dart';

final GlobalKey<AnimatedCircularChartState> _chartKey =
    new GlobalKey<AnimatedCircularChartState>();

class PieChartScreen extends StatefulWidget {
  @override
  _PieChartScreenState createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen>
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
      body: Consumer<WorldWide>(
        builder: (BuildContext context, WorldWide world, _) {
          return world == null
              ? SpinKitPouringHourglass(
                  color: Colors.black,
                )
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('images/globe_bg.png'),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Lottie.asset(
                              'lottie/live.json',
                              height: 50,
                              width: 100,
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller
                                  ..duration = composition.duration
                                  ..forward();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              left: 40,
                            ),
                            child: Text(
                              'World Report',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: kVioletColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'COVID - 19 GLobal Cases',
                        style: TextStyle(
                            fontSize: 20,
                            color: kVioletColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Chart(),
                      SizedBox(
                        height: 50,
                      ),
                      MyCard(
                        world: world,
                      ),
                    ],
                  ),
                );
        },
      ),
    ));
  }
}

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorldWide>(
      builder: (BuildContext context, WorldWide world, _) {
        return Row(
          children: <Widget>[
            AnimatedCircularChart(
                key: _chartKey,
                size: const Size(300.0, 300.0),
                duration: Duration(seconds: 2),
                chartType: CircularChartType.Pie,
                initialChartData: <CircularStackEntry>[
                  new CircularStackEntry(
                    <CircularSegmentEntry>[
                      new CircularSegmentEntry(
                          world.totalDeaths.toDouble(), Colors.red[200],
                          rankKey: 'Q1'),
                      new CircularSegmentEntry(
                          world.totalRecovered.toDouble(), Colors.green[200],
                          rankKey: 'Q2'),
                      new CircularSegmentEntry(
                          world.totalConfirmed.toDouble(), Colors.yellow[200],
                          rankKey: 'Q4'),
                    ],
                    rankKey: 'Quarterly Profits',
                  ),
                ]),
            LegendWidget(world),
          ],
        );
      },
    );
  }
}

class LegendWidget extends StatelessWidget {
  final WorldWide world;

  LegendWidget(this.world);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Legend1(
          color: Colors.yellow[200],
          title: 'Confirmed',
          percentage: (world.totalConfirmed *
                  100 /
                  (world.totalConfirmed +
                      world.totalRecovered +
                      world.totalDeaths))
              .round(),
        ),
        SizedBox(
          height: 10,
        ),
        Legend1(
          color: Colors.green[200],
          title: 'Recovered',
          percentage: (world.totalRecovered *
                  100 /
                  (world.totalConfirmed +
                      world.totalRecovered +
                      world.totalDeaths))
              .round(),
        ),
        SizedBox(
          height: 10,
        ),
        Legend1(
          color: Colors.red[200],
          title: 'Deaths',
          percentage: (world.totalDeaths *
                  100 /
                  (world.totalConfirmed +
                      world.totalRecovered +
                      world.totalDeaths))
              .round(),
        ),
      ],
    );
  }
}

class Legend1 extends StatelessWidget {
  final Color color;
  final String title;
  final int percentage;

  Legend1({this.color, this.title, this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.mapMarker,
              size: 20,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              percentage.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 5,
            ),
            FaIcon(
              FontAwesomeIcons.percentage,
              size: 10,
            )
          ],
        )
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final WorldWide world;
  MyCard({this.world});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: MyCardValues(
                title: 'Confirmed',
                color: Colors.yellow[200],
                value: world.totalConfirmed,
              ),
            ),
            MyCardValues(
              title: 'Recovered',
              color: Colors.green[200],
              value: world.totalRecovered,
            ),
          ],
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: MyCardValues(
                title: 'Deaths',
                color: Colors.red[200],
                value: world.totalDeaths,
              ),
            ),
            MyCardValues(
              title: 'Active',
              color: Colors.white,
              value: world.totalActive,
            ),
          ],
        )
      ],
    );
  }
}

class MyCardValues extends StatelessWidget {
  final Color color;
  final String title;
  final int value;

  MyCardValues({this.color, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.mapMarker,
                    size: 20,
                    color: color,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    value.toString(),
                    style: TextStyle(fontSize: 20),
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
