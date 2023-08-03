import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';

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
    getData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.longitude);
  }

  void getData() async {
    var url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': 'Hanoi',
        'units': 'metric',
        'appid': '476039ddfa732c52a0cd4abae0f5ad20',
      },
    );

    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      String data = response.body;
    }else{
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
