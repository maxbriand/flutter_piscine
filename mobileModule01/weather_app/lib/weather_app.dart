import "package:flutter/material.dart";

class WeatherAppPage extends StatefulWidget {
  const WeatherAppPage({super.key, required this.title});

  final String title;

  @override
  State<WeatherAppPage> createState() => _WeatherAppPageState();
}

class _WeatherAppPageState extends State<WeatherAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5B5D72),
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pentagon_outlined), label: "dd"),
          BottomNavigationBarItem(icon: Icon(Icons.today_sharp), label: "dsd"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "dssd"),
        ],
        onTap: (index) {},
      ),

      body: Text("jd"),
    );
  }
}
