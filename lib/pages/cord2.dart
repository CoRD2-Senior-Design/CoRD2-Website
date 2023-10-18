import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cord2 extends StatelessWidget{
  const Cord2({super.key});
  static const CameraPosition _ucf = CameraPosition(
    target: LatLng(28.6024, -81.2001),
    zoom: 14.4746
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double lrPadding = width > 750 ? 150.0 : 50;
    double tbPadding = width > 750 ? 50.0 : 15;
    const double defaultFont = 16.0;
    double fontScaling = width > 750 ? 1.0 : 0.8;
    return Scaffold (
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: tbPadding,
                left: lrPadding,
                right: lrPadding,
                bottom: tbPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SelectableText(
                    "CoRD\u00B2",
                    style: TextStyle(fontSize: 35.0 * fontScaling, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child:  SelectableText(
                    "Community Resilience Data Depot system (CoRD2) will target"
                    " important concerns relating to resilient and AI-driven "
                    "data services through networked communities and "
                    "cross-sector partnerships.",
                    style: TextStyle(fontSize: defaultFont * fontScaling),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("\u2022  "),
                      Flexible(
                        child: SelectableText(
                          "Data of interest for this project are from "
                          "different origins and have different analytical "
                          "desires. Such origin diversity arises due to the "
                          "different partners involved in this project as well "
                          "as different data generation sources. An integrated "
                          "distributed data storage and retrieval system to "
                          "coordinate and accommodate all desires is needed.",
                          style: TextStyle(
                            fontSize: defaultFont * fontScaling,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("\u2022  "),
                          Flexible(
                              child: SelectableText(
                                "As natural disasters may cause "
                                "failures in computer systems (e.g., "
                                "data loss, equipment failure, and power "
                                "disruption), cutting-edge resilience "
                                "techniques will be designed and deployed to "
                                "improve the reliability of data and "
                                "computer systems.",
                                style: TextStyle(
                                  fontSize: defaultFont * fontScaling,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ),
                        ],
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("\u2022  "),
                          Flexible(
                              child: SelectableText(
                                "State-of-the-art machine learning "
                                "techniques will be designed to analyze "
                                "multi-modal data sources (e.g., texts "
                                "and images).",
                                style: TextStyle(
                                  fontSize: defaultFont * fontScaling,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                          ),
                        ],
                    ),
                ),
                const Flexible(
                  child: GoogleMap(initialCameraPosition: _ucf,),
                ),
              ],
            ),
          )
        ),
    );
  }
}