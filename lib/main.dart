import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
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
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10))
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
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
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
      ),
    );
  }

  // Returns a widget for the article title
  Tooltip _displayArticleTitle(TextStyle linkStyle) {
    String titleLink =
        'https://www.nsf.gov/awardsearch/showAward?AWD_ID=1952792&HistoricalAwards=false';
    return Tooltip(
      message: titleLink,
      verticalOffset: 50,
      child: AutoSizeText.rich(
        TextSpan(
          text:
              'Leveraging Smart Technologies and Managing Community Resilience through Networked Communities and Cross-Sector Partnerships',
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse(titleLink)),
        ),
        style: linkStyle.copyWith(
          fontSize: 20,
          letterSpacing: 1,
        ),
        maxLines: 6,
        maxFontSize: 23,
      ),
    );
  }

  // Returns an image of the NFS logo as a Widget
  Padding _displayNFSLogo(String imgSrc) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        '${imgSrc}nsfLogo.webp',
        height: 110,
      ),
    );
  }

  // Returns the article abstract as a widget
  Column _displayArticleAbstract(
      TextStyle linkStyle, TextStyle bodyStyle, BuildContext context) {
    // Sends user to abstract page
    void goToAbstractRoute() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FullAbstractRoute()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tooltip(
          message: 'Full Abstract',
          child: RichText(
            text: TextSpan(
              text: 'Abstract',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => goToAbstractRoute(),
            ),
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
          child: RichText(
            text: TextSpan(
              style: bodyStyle,
              children: <TextSpan>[
                const TextSpan(
                  text:
                      "This Smart & Connected Communities grant will leverage existing community partnerships and resources and evaluate the information technology applications aided by artificial intelligence in enhancing community resilience management. The east central Florida region (including 8 counties and 78 member towns/cities) is selected … ",
                ),
                TextSpan(
                  text: 'Read more',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => goToAbstractRoute(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Create a new route to display full abstract on a new page
class FullAbstractRoute extends StatelessWidget {
  const FullAbstractRoute({super.key});

  @override
  Widget build(BuildContext context) {
    bool desktopLayout = MediaQuery.of(context).size.width >= 1130;
    bool laptopLayout =
        MediaQuery.of(context).size.width >= 930 && !desktopLayout;
    bool mobileLayout = MediaQuery.of(context).size.width < 600;
    bool tabletLayout = !desktopLayout && !laptopLayout && !mobileLayout;
    TextStyle bodyStyle = const TextStyle(
      fontSize: 16,
      height: 2,
    );
    double? bodyWidth = 1100; // Desktop size

    // set layout sizes for other layouts
    if (laptopLayout) {
      bodyWidth = 900;
    } else if (tabletLayout) {
      bodyWidth = 550;
    } else if (mobileLayout) {
      bodyWidth = 400;
      bodyStyle = bodyStyle.copyWith(fontSize: 14);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Full Abstract',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Container(
              alignment: Alignment.topLeft,
              width: bodyWidth,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 60),
                    child: Text(
                      'Abstract',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Text(
                    'This Smart & Connected Communities grant will leverage existing community partnerships and resources and evaluate the information technology applications aided by artificial intelligence in enhancing community resilience management. The east central Florida region (including 8 counties and 78 member towns/cities) is selected as a testbed for this project to improve community resilience practices through a regional data platform – Community Resilience Data Depot (CoRD2). Built on an interdisciplinary team with synergistic contributions from Emergency Management, Public Administration, Geography, Computer Science, Civil Engineering, and Operation Management, the project aims to augment the information and communication capacity of the east central Florida region and the Orlando metropolitan area to the next level via a sustainable partnership. The metrics to assess the extent and speed of achieving appropriate post-event functionality will help address a nationwide community capacity building need to quantitatively evaluate resilience increases by public-private partnerships. The research design assessing resilience changes will help decision makers in governments, businesses, and nonprofits to obtain a deeper understanding of how artificial intelligence-aided information technologies can advance collective decision making to reduce community vulnerability and enhance resilience.',
                    style: bodyStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Text(
                    'The research involves developing an integrative framework to evaluate smart technology advances that foster community partnerships and enhance community connectedness in resilience management; filling research gaps in modeling community partnership characteristics and examining design and implementation networks among cross-sector partners for community resilience efforts; creating a holistic approach to comparing community resilience functionality changes by research intervention and an actual hazard event; and building CoRD2 for resilience data sharing and integration among public, private, and nonprofit sectors to support real-time collective decision making. The novel methodologies include collecting and calibrating multi-dimensional data from behavioral surveys, policy and plan documents, social media posts, and an in-house drill with pre-/post-surveys; creating converged metrics for evaluating community resilience from an organizational perspective; providing next-generation computational solutions for processing disaster response data flowing in the regional data platform as peak influxes; developing real-time machine learning algorithms and software capacities for social media big data analytics (texts and images); and modeling organizational resilience capacity and multidimensional community resilience functionality.',
                    style: bodyStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white),
                      child: const Text('Return to home page'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
