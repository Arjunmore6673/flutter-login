import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/WeatherModel.dart';

class WeatherRepo {


  Future<WeatherModel> getWeather(String city) async {
    final result = await http.Client().get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2');
    print(parsedJson(result.body));
    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonWeather = json.decode(response);
    final main = jsonWeather["main"];
    return WeatherModel.fromJson(main);
  }
}
