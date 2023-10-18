import 'package:cord2_website/pages/cord2.dart';
import 'package:flutter/material.dart';

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

class _NavBarState extends State<NavBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, animationDuration: Duration.zero);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        children: const <Widget>[
          Center(
            child: Text("Home Page Goes Here"),
          ),
          Center(
            child: Text("People Page Goes Here"),
          ),
          Center(
            child: Cord2(),
          ),
          Center(
            child: Text("Publications Page Goes Here"),
          ),
          Center(
            child: Text("Projects Page Goes Here"),
          ),
        ],
      ),
    );
  }
}
