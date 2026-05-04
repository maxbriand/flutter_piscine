import "package:flutter/material.dart";

class WeatherAppPage extends StatefulWidget {
  const WeatherAppPage({super.key, required this.title});

  final String title;

  @override
  State<WeatherAppPage> createState() => _WeatherAppPageState();
}

class _WeatherAppPageState extends State<WeatherAppPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _location = "";

  static const List<String> _tabNames = ["Currently", "Today", "Weekly"];
  static const List<IconData> _tabIcons = [
    Icons.wb_sunny_outlined,
    Icons.today_outlined,
    Icons.calendar_month_outlined,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(String name, String location) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          if (location.isNotEmpty)
            Text(
              location,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5D72),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search location...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                onSubmitted: (value) {
                  setState(() {
                    _location = value;
                  });
                },
              ),
            ),
            Container(
              width: 1,
              height: 24,
              color: Colors.white24,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _location = "Geolocation";
                });
              },
              icon: const Icon(Icons.near_me, color: Colors.white),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final name in _tabNames) _buildTabContent(name, _location),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        items: [
          for (var i = 0; i < _tabNames.length; i++)
            BottomNavigationBarItem(
              icon: Icon(_tabIcons[i]),
              label: _tabNames[i],
            ),
        ],
        onTap: (index) {
          _tabController.animateTo(index);
        },
      ),
    );
  }
}
