import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'af8d394c17865a68a0c194d855ed3f88';
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String typedCityName) async {
    var url = '$openWeatherMapURL?q=$typedCityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getWeatherData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');

    var weatherData = await networkHelper.getWeatherData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '\ud83c\udf29'; //lightning
    } else if (condition < 400) {
      return '\ud83c\udf28'; //snow
    } else if (condition < 600) {
      return '\u2614'; //umbrella with rain
    } else if (condition < 700) {
      return '\u2603️'; //snowman
    } else if (condition < 800) {
      return '\ud83c\udf2b'; //fog
    } else if (condition == 800) {
      return '\u2600'; //sunny
    } else if (condition <= 804) {
      return '\u2601️'; //clear
    } else {
      return '\ud83d\ude45'; //no clue
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s \uD83C\uDF66 time in'; //soft ice cream
    } else if (temp > 20) {
      return 'Time for shorts and \uD83D\uDC55 in'; //t-shirt
    } else if (temp < 10) {
      return 'You\'ll need \ud83e\udde3 and \ud83e\udde4 in'; //scarf and gloves
    } else {
      return 'Bring a \ud83e\udde5 just in case in'; //coat
    }
  }
}
