import 'package:flutter/material.dart';

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
