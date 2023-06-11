import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' hide TextDirection;
import 'dart:convert';
import '../screens/nice_screen.dart';
import '../model/forecast_model.dart';

String apikey = 'c623484b44d3372717ddafde6d0e88bf';

class Forecast extends StatefulWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  ForecastState createState() => ForecastState();
}

class ForecastState extends State<Forecast> {
  late Future<ForecastData> forecastData;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    forecastData = _getCurrentLocation();
  }

  Future<ForecastData> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return fetchForecastData(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get current location';
      });
      rethrow;
    }
  }

  Future<ForecastData> fetchForecastData(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 解析 API 响应的 JSON 数据并创建 ForecastData 对象
      return ForecastData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch forecast data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/Background/$background.png'
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 30
                ), // 设置左右和上下的间距
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(20), // 设置圆角半径为10
                    color: const Color.fromRGBO(0x0, 0x0, 0x0, 0.8)
                ),
                child: FutureBuilder<ForecastData>(
                  future: forecastData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    } else {
                      final forecastData = snapshot.data!;
                      final forecastList = forecastData.forecastList;

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: forecastList.length,
                        itemBuilder: (context, index) {
                          final weatherInfo = forecastList[index];
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:BorderRadius.circular(50),
                              color: const Color.fromRGBO(
                                  0x48, 0x31, 0x9D, 0.2),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        weatherInfo.time,
                                        style: const TextStyle(
                                            fontSize: 24, fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '${weatherInfo.temperature}°C',
                                        style: const TextStyle(
                                            fontSize: 48, fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        weatherInfo.weather,
                                        style: const TextStyle(
                                            fontSize: 24, fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Icons/${weatherInfo.iconUrl}.png'
                                        ),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}