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
    return  const Scaffold (
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: 50.0,
                left: 150.0,
                right: 150.0,
                bottom: 50.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "CoRD\u00B2",
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Community Resilience Data Depot system (CoRD2) will target"
                  " important concerns relating to resilient and AI-driven "
                  "data services through networked communities and "
                  "cross-sector partnerships.",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("\u2022  "),
                      Flexible(
                        child: Text(
                          "Data of interest for this project are from "
                          "different origins and have different analytical "
                          "desires. Such origin diversity arises due to the "
                          "different partners involved in this project as well "
                          "as different data generation sources. An integrated "
                          "distributed data storage and retrieval system to "
                          "coordinate and accommodate all desires is needed.",
                          style: TextStyle(
                            fontSize: 18.0,
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
                          Text("\u2022  "),
                          Flexible(
                              child: Text(
                                "As natural disasters may cause "
                                "failures in computer systems (e.g., "
                                "data loss, equipment failure, and power "
                                "disruption), cutting-edge resilience "
                                "techniques will be designed and deployed to "
                                "improve the reliability of data and "
                                "computer systems.",
                                style: TextStyle(
                                  fontSize: 18.0,
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
                          Text("\u2022  "),
                          Flexible(
                              child: Text(
                                "State-of-the-art machine learning "
                                "techniques will be designed to analyze "
                                "multi-modal data sources (e.g., texts "
                                "and images).",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                          ),
                        ],
                    ),
                ),
                Flexible(
                  child: GoogleMap(initialCameraPosition: _ucf,),
                ),
              ],
            ),
          )
        ),
    );
  }
}