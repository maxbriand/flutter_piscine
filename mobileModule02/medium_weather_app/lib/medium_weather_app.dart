import "package:flutter/material.dart";

class WeatherAppPage extends StatefulWidget {
  const WeatherAppPage({super.key, required this.title});

  final String title;

  @override
  State<WeatherAppPage> createState() => _WeatherAppPageState();
}

class _WeatherAppPageState extends State<WeatherAppPage> {
  var _currentIndex = 0;
  String _location = "";

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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
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
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search location...',
                        labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          _location = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _location = "Geolocation";
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
