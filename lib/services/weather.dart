import '../services/networking.dart';
import '../services/location.dart';

const apiKey = '4cad1f6858687dd6a48dbaebe24d2761';
const weatherCity = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$weatherCity?q=$cityName&appid=$apiKey&units=metric';
    Networking networkHelper = Networking(url);

    var weatherData = await networkHelper.getNetworkData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    GetLocation location = GetLocation();
    await location.getLocation();
    // print(location.latitude);
    // print(location.longitude);
    // latitude = location.latitude;
    // longitude = location.longitude;

    Networking getNetwork = Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await getNetwork.getNetworkData();
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
      return 'It\'s 🍦 time in San Fransisco';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
