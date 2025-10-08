import "package:flutter/material.dart";

class WeatherAppPage extends StatefulWidget {
  const WeatherAppPage({super.key, required this.title});

  final String title;

  @override
  State<WeatherAppPage> createState() => _WeatherAppPageState();
}

class _WeatherAppPageState extends State<WeatherAppPage> {
  var _currentIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5B5D72),
        title: Row(
          children: [
            TextField(),
            IconButton(onPressed: () {}, icon: Icon(Icons.today_sharp),),
          ],
        ),
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
      body: Center(child: Text("Hello, world!", style: TextStyle(fontSize: 20),)),
    );
  }
}
