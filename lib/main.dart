import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bulleted_list/bulleted_list.dart';

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
            child: Text("Home Page Goes Here"),
          ),
          Center(
            child: Text("People Page Goes Here"),
          ),
          Center(
            child: Text("CORD2 Page Goes Here"),
          ),
          Center(
            child: PublicationsPage(),
          ),
          Center(
            child: Text("Projects Page Goes Here"),
          ),
        ],
      ),
    );
  }
}

class PublicationsPage extends StatelessWidget {
  const PublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = const TextStyle(fontSize: 16, height: 1.5);
    TextStyle linkStyle =
        bodyStyle.copyWith(color: const Color.fromRGBO(2, 98, 182, 1));

    double bodyWidth = 1070;
    double screenWidth = MediaQuery.of(context).size.width;
    // Makes body design look good on different screen widths
    if (screenWidth <= 750) {
      bodyWidth = 500;
    } else if (screenWidth <= 900) {
      bodyWidth = 700;
    } else if (screenWidth <= 1100) {
      bodyWidth = 850;
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              width: bodyWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      bottom: 15,
                    ),
                    child: Text(
                      'Publications',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  BulletedList(
                    listItems: getPublicationList(bodyStyle, linkStyle),
                    bulletColor: Colors.black,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<dynamic> getPublicationList(TextStyle bodyStyle, TextStyle linkStyle) {
    return [
      _displayPublication(
        'Huang, C. Derrick and Baghersad, Milad and Behara, Ravi S. and Zobel, Christopher W. “Optimal Investment in Prevention and Recovery for Mitigating Epidemic Risks” Risk Analysis , 2021 ',
        bodyStyle,
        linkStyle,
        'https://doi.org/10.1111/risa.13707',
      ),
      _displayPublication(
        'Martín, Yago and Li, Zhenlong and Ge, Yue and Huang, Xiao “Introducing Twitter Daily Estimates of Residents and Non-Residents at the County Level” Social Sciences , v.10 , 2021 ',
        bodyStyle,
        linkStyle,
        'https://doi.org/10.3390/socsci10060227',
      ),
      _displayPublication(
        'Pamukcu, D. and Zobel, C.W. and Ge, Y. “Analysis of Orange County 311 System service requests during the COVID-19 pandemic” Proceedings of the 18th International Conference on Information Systems for Crisis Response and Management , 2021',
        bodyStyle,
        linkStyle,
      )
    ];
  }
}

dynamic _displayPublication(
    String publicationText, TextStyle bodyStyle, TextStyle linkStyle,
    [String? publicationLink]) {
  return RichText(
    text: TextSpan(
      style: bodyStyle,
      children: <TextSpan>[
        TextSpan(
          text: publicationText,
          style: bodyStyle,
        ),
        if (publicationLink != null)
          TextSpan(
            text: publicationLink,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(Uri.parse(publicationLink)),
          ),
      ],
    ),
  );
}
