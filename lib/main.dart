import 'package:cord2_website/pages/people.dart';
import 'package:cord2_website/pages/projects.dart';
import 'package:cord2_website/pages/publications_page.dart';
import 'package:flutter/material.dart';
import './pages/home_page.dart';

void main() => runApp(const CordWebsite());

class CordWebsite extends StatelessWidget {
  const CordWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 5, vsync: this, animationDuration: Duration.zero);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Scaffold buildDrawer() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
        title: const SelectableText("SCC RiskComm",
            style: TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text("HOME"),
              onTap: () {
                // Navigate to the home page.
                Navigator.of(context).pop();
                _tabController.animateTo(0);
              },
            ),
            ListTile(
              title: const Text("PEOPLE"),
              onTap: () {
                // Navigate to the people page.
                Navigator.of(context).pop();
                _tabController.animateTo(1);
              },
            ),
            ListTile(
              title: const Text("CORD2"),
              onTap: () {
                Navigator.of(context).pop();
                _tabController.animateTo(2);
              },
            ),
            ListTile(
              title: const Text("PUBLICATIONS"),
              onTap: () {
                Navigator.of(context).pop();
                _tabController.animateTo(3);
              },
            ),
            ListTile(
              title: const Text("PROJECTS"),
              onTap: () {
                Navigator.of(context).pop();
                _tabController.animateTo(4);
              },
            ),
            // Add more drawer items as needed.
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const Center(
            child: HomePage(),
          ),
          Center(
            child: PeoplePage(),
          ),
          const Center(
            child: Text("CORD2 Page Goes Here"),
          ),
          const Center(
            child: PublicationsPage(),
          ),
          const Center(
            child: ProjectsPage(),
          ),
        ],
      ),
    );
  }

  Scaffold buildNav() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Flexible(
                child: Text("SCC RiskComm", style: TextStyle(color: Colors.white)),
              ),
              Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: TabBar(
                      indicator: const ShapeDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        shape: Border(),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: const Color.fromRGBO(255, 255, 255, 0.3),
                      dividerColor: Colors.transparent,
                      controller: _tabController,
                      tabs: const <Widget>[
                        Tab(
                          child: Text("HOME", style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("PEOPLE", style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("CORD2", style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("PUBLICATIONS", style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("PROJECTS", style: TextStyle(color: Colors.white)),
                        ),
                      ]
                  )
              )
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const Center(
            child: HomePage(),
          ),
          Center(
            child: PeoplePage(),
          ),
          const Center(
            child: Text("CORD2 Page Goes Here"),
          ),
          const Center(
            child: PublicationsPage(),
          ),
          const Center(
            child: ProjectsPage(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1000;
    if (isSmallScreen) {
      return buildDrawer();
    } else {
      return buildNav();
    }
  }
}
