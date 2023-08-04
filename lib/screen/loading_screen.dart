import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab_08_weather_app_clima/screen/location_screen.dart';
import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '476039ddfa732c52a0cd4abae0f5ad20';
const country = 'Hanoi';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    // longitude = location.longitude!;
    // latitude = location.latitude!;

    var url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': '${location.latitude}',
        'lon': '${location.longitude}',
        'units': 'metric',
        'appid': apiKey,
      },
    );

    NetWorkHelper netWorkHelper = NetWorkHelper(url: url);

    var weatherData = await netWorkHelper.getData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  static const spinkit1 = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Please Clicked!'),
            ),
            spinkit,
          ],
        ),
      ),
    );
  }
}
