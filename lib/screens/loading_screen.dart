// ignore_for_file: library_private_types_in_public_api, avoid_print
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '4cad1f6858687dd6a48dbaebe24d2761';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    gettingLocation();
  }

  void gettingLocation() async {
    GetLocation location = GetLocation();
    await location.getLocation();
    // print(location.latitude);
    // print(location.longitude);
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);
      var temperature = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['main'];
      var cityName = decodeData['name'];

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // getData();
            gettingLocation();
            //Get the current location
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
