import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class City {
  String city;
  String region;
  String country;
  double temperature;
  String weatherDescription;
  double windSpeed;

  City({
    this.city = "Unknown city",
    this.region = "Unknown region",
    this.country = "Unknown country",
    this.temperature = 0.0,
    this.weatherDescription = "Unknown weather",
    this.windSpeed = 0.0,
  });
}

class WeatherAppPage extends StatefulWidget {
  final String title;

  const WeatherAppPage({super.key, required this.title});

  @override
  State<WeatherAppPage> createState() => _WeatherAppPageState();
}

class _WeatherAppPageState extends State<WeatherAppPage> {
  var _currentIndex = 0;
  String pos = "";
  String _location = "";
  final controller = TextEditingController();
  City paris = City(
    city: "paris",
    region: "ile de france",
    country: "france",
    temperature: 45.1,
    weatherDescription: "Cloudy",
    windSpeed: 2.0,
  );

  Future<void> _getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
  }

  Future<Position> _getPosition() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
    return position;
  }

  void _onTapItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget? _getBody(int index, String location) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          switch (index) {
            0 => Text(
              "Currently",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            1 => Text(
              "Today",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            2 => Text(
              "Weekly",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            _ => Text(
              "Unknown",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          },
          Text(
            location,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future<String> fetchWeatherDatas(String input) async {
    var response = http.get(
      Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$input'),
    );
    var rps = await response;
    return rps.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5B5D72),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TypeAheadField<City>(
                      controller: ScrollController(),
                      itemBuilder: (context, s) => ListTile(
                        title: Text(s.city),
                        subtitle: Text(s.region),
                      ),
                      suggestionsCallback: (query) async => [paris],
                      onSelected: (s) => controller.text = s.city,
                      builder: (context, textCtrl, focusNode) => TextField(
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Search location...',
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                        ),
                        onChanged: (value) async {
                          debugPrint(value);
                          String result = await fetchWeatherDatas(value);
                          debugPrint("jcdsj $result");
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _location = value;
                          });
                        },
                      ),
                      debounceDuration: const Duration(milliseconds: 300),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () async {
                      try {
                        debugPrint("Getting permission...");
                        await _getPermission();
                        debugPrint("Permission granted, getting position...");
                        Position position = await _getPosition();
                        debugPrint(
                          "Position result: ${position.latitude}, ${position.longitude}",
                        );
                        pos = '(${position.latitude}, ${position.longitude})';
                      } catch (e) {
                        pos =
                            "Geolocation is not available, please enable it in your App settings $e";
                      }
                      setState(() {
                        _location = pos;
                      });
                    },
                    icon: Icon(Icons.egg_alt, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pentagon_outlined),
            label: "Currently",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today_sharp),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Weekly",
          ),
        ],
        onTap: _onTapItem,
      ),
      body: _getBody(_currentIndex, _location),
    );
  }
}
