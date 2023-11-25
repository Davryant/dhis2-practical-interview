import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final apiKey = 'd3c0540e57fdef4eb6a7485e3daa6dcb';
  String city = 'Tanzania';
  String temperature = '';
  String humidity = '';
  String wind = '';
  @override
  void initState() {
    super.initState();
    _fetchWeatherData(city);
  }
  Future<void> _fetchWeatherData(String city) async {
    final url =
    Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    final response = await http.get(url);
    print(response.toString());

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final mainData = weatherData['main'];
      setState(() {
        temperature = '${mainData['temp']}°C';
        humidity = '${mainData['humidity']}%';
        wind = '${mainData['wind speed']}km/h';
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter City',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _fetchWeatherData(city);
              },
              child: Text('Seach Weather'),
            ),
            SizedBox(height: 16),
            Text(
              'Temperature:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              temperature,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),
            Text(
              'Humidity:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              humidity,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),

            
            SizedBox(height: 16),
            Text(
              'Wind:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              wind,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );
  }
}
