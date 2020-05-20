import 'package:flutter/material.dart';
import 'package:flutterapp/provider/my_data_provider.dart';
import 'package:flutterapp/screens/global_news.dart';
import 'package:flutterapp/screens/prevention_page.dart';
import 'package:flutterapp/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'model/district.dart';
import 'model/statewise.dart';
import 'model/world.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyData myData = MyData();
    return MultiProvider(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Baloon',
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
      ),
      providers: [
        FutureProvider<List<StateObject>>(
          create: (BuildContext context) => myData.getStateResults(),
        ),
        FutureProvider<List<DistrictObject>>(
          create: (BuildContext context) => myData.getDistrictsList(),
        ),
        FutureProvider<WorldWide>(
          create: (BuildContext context) => myData.getWorldWideData(),
        ),
        FutureProvider(
          create: (BuildContext context) => myData.getWorldNews(),
        )
      ],
    );
  }
}
