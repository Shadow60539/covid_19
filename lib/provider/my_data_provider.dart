import 'dart:convert';
import 'package:flutterapp/model/district.dart';
import 'package:flutterapp/model/statewise.dart';
import 'package:flutterapp/model/world.dart';
import 'package:flutterapp/model/worldnews.dart';
import 'package:http/http.dart';

class MyData {
  Future<List<StateObject>> getStateResults() async {
    List<StateObject> stateResult = [];
    Response response = await get(
        'https://covid19-server.chrismichael.now.sh/api/v1/IndiaCasesByStates');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data != null) {
        data['data'][0]['table'].forEach((element) {
          StateObject stateObject = StateObject(
            active: element['active'],
            confirmed: element['confirmed'],
            state: element['state'],
            deaths: element['deaths'],
            recovered: element['recovered'],
          );
          stateResult.add(stateObject);
        });
      }
    }
    return stateResult;
  }

  Future<List<DistrictObject>> getDistrictsList() async {
    List<DistrictObject> districtResult = [];
    Response response =
        await get('https://api.covid19india.org/state_district_wise.json');
    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        result.forEach((element, index) {
          index['districtData'].forEach((district, index) {
            DistrictObject districtObject = DistrictObject(
                active: index['active'],
                recovered: index['recovered'],
                deceased: index['deceased'],
                districtName: district,
                stateName: element,
                confirmed: index['confirmed']);
            districtResult.add(districtObject);
          });
        });
      }
    } catch (e) {
      print('Error is $e');
    }
    return districtResult;
  }

  Future<WorldWide> getWorldWideData() async {
    WorldWide worldWide;
    Response response = await get('https://corona.lmao.ninja/v2/all');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      worldWide = WorldWide(
        totalConfirmed: data['cases'],
        totalActive: data['active'],
        totalRecovered: data['recovered'],
        totalDeaths: data['deaths'],
      );
    }
    return worldWide;
  }

  Future<List<WorldNews>> getWorldNews() async {
    List<WorldNews> newsList = [];
    Response response = await get(
        'https://wrapapi.com/use/Shadow/covid19/news/1.0.0?wrapAPIKey=aIOK7RrdSib453QkcbWkBDW02i4Fq8TM');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data']['worldnews'].forEach((element) {
        WorldNews news = WorldNews(
            location: element['location'],
            newCases: element['newcases'],
            newDeaths: element['newdeaths']);
        newsList.add(news);
      });
    }
    return newsList;
  }
}
