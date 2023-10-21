import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'dart:html';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Flexible(
                child:
                    Text("SCC RiskComm", style: TextStyle(color: Colors.white)),
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
                          child: Text("HOME",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("PEOPLE",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("CORD2",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("PUBLICATIONS",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("PROJECTS",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ]))
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: HomePage(),
          ),
          Center(
            child: Text("People Page Goes Here"),
          ),
          Center(
            child: Text("CORD2 Page Goes Here"),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String imgSrc = 'assets/images/';
    TextStyle linkStyle =
        const TextStyle(color: Color.fromRGBO(2, 98, 182, 1), fontSize: 16);
    TextStyle bodyStyle =
        const TextStyle(fontSize: 16, height: 1.5, letterSpacing: 1);
    TextStyle detailStyle =
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w900);

    bool desktopLayout = MediaQuery.of(context).size.width >= 1080;
    bool mobileLayout = MediaQuery.of(context).size.width < 600;
    bool tabletLayout = !desktopLayout && !mobileLayout;

    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.fromLTRB(50, 150, 50, 100),
            width: 900,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  '${imgSrc}partnerList.webp',
                  height: 137,
                ),
                if (mobileLayout)
                  Column(
                    children: [
                      _displayNFSLogo(imgSrc),
                      _displayArticleTitle(linkStyle),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10))
                    ],
                  ),
                if (!mobileLayout)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _displayNFSLogo(imgSrc),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              _displayArticleTitle(linkStyle),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 60)),
                              if (desktopLayout)
                                _displayArticleAbstract(
                                    linkStyle, bodyStyle, context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (tabletLayout || mobileLayout)
                  _displayArticleAbstract(linkStyle, bodyStyle, context),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Time Period: 09/01/2020 – 08/31/2023',
                    style: detailStyle,
                  ),
                ),
                Text(
                  'Award #: 1952792',
                  style: detailStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Returns the article title as an AutoSizeText widget
  AutoSizeText _displayArticleTitle(TextStyle linkStyle) {
    return AutoSizeText.rich(
      TextSpan(
        text: 'Leveraging Smart Technologies and ' +
            'Managing Community Resilience through ' +
            'Networked Communities and Cross-Sector Partnerships',
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            _launchURL(
              'https://www.nsf.gov/awardsearch/showAward?AWD_ID=1952792&HistoricalAwards=false',
              'Full Abstract',
            );
          },
      ),
      style: linkStyle.copyWith(
        fontSize: 20,
        letterSpacing: 1,
      ),
      maxLines: 6,
      maxFontSize: 23,
    );
  }

  // Returns an image of the NFS logo as a Padding widget
  Padding _displayNFSLogo(String imgSrc) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        '${imgSrc}nsfLogo.webp',
        height: 110,
      ),
    );
  }

  // Returns the article abstract as a Column widget
  Column _displayArticleAbstract(
      TextStyle linkStyle, TextStyle bodyStyle, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Abstract',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FullAbstractRoute()),
                    );
                  },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 8),
          child: Text(
            'June 30, 2021',
            style: TextStyle(fontSize: 13),
          ),
        ),
        SizedBox(
          //width: 600,
          child: RichText(
            text: TextSpan(
              style: bodyStyle,
              children: <TextSpan>[
                const TextSpan(
                  text: "This Smart & Connected Communities grant will " +
                      "leverage existing community partnerships and " +
                      "resources and evaluate the information technology " +
                      "applications aided by artificial intelligence in " +
                      "enhancing community resilience management. The " +
                      "east central Florida region (including 8 counties " +
                      "and 78 member towns/cities) is selected … ",
                ),
                TextSpan(
                  text: 'Read more',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FullAbstractRoute()),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String url, name) {
    window.open(url, name);
  }
}

// Create a new route to display full
class FullAbstractRoute extends StatelessWidget {
  const FullAbstractRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Abstract'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
