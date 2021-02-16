import 'package:flutter/material.dart';
import 'dart:convert';
import 'weather.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  Weather weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather app"),),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(decoration:
                InputDecoration(hintText: "Enter the city"),)),
                FlatButton(onPressed: (){
                fetchWeather().then((tempweather) {
                  setState(() {
                    weather = tempweather;
                  });
                });
                  
                }, child: Text("Search"), color: Colors.blue,
                textColor: Colors.white,)
              ],
            ),
            weather != null ?
            Column(children: [
              Text("${weather.dt}"),
              Text(weather.weather),
              Image.network(weather.iconUrl)
            ],)
                : SizedBox()
          ],
        ),
      )
    );
  }
}

Future<Weather> fetchWeather() async {
  final response = await http.get('https://api.openweathermap.org/data/2.5/weather?q=Kuala%20Lumpur&appid=9fd7a449d055dba26a982a3220f32aa2');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}