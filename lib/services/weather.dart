import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '476039ddfa732c52a0cd4abae0f5ad20';

class WeatherModel {

  Future<dynamic> getCityWeather(String city) async {

    var url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': city,
        'units': 'metric',
        'appid': apiKey,
      },
    );

    NetWorkHelper netWorkHelper = NetWorkHelper(url: url);

    var weatherData = await netWorkHelper.getData();

    return weatherData;

  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
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

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
