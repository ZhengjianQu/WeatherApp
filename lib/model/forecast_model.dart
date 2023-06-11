import 'package:intl/intl.dart' hide TextDirection;

class WeatherData {
  final String temperature;
  final String weather;
  final String time;
  final String week;
  final String date;
  final String iconUrl;

  WeatherData({
    required this.temperature,
    required this.weather,
    required this.date,
    required this.week,
    required this.time,
    required this.iconUrl,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0]['main'].toString();
    final iconUrl = json['weather'][0]['icon'];
    final temperature = main['temp'].round().toString();
    final timestamp = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final date = DateFormat('MM/dd').format(timestamp);
    final week = DateFormat('EEEE').format(timestamp);// Format the timestamp
    final time = DateFormat('HH:mm').format(timestamp);

    return WeatherData(
      temperature: temperature,
      weather: weather,
      date: date,
      week: week,
      time: time,
      iconUrl: iconUrl,
    );
  }
}

class ForecastData {
  final List<WeatherData> forecastList;

  ForecastData({required this.forecastList});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final forecastList = List<WeatherData>.from(json['list'].map((data) {
      return WeatherData.fromJson(data);
    }));

    return ForecastData(forecastList: forecastList);
  }
}