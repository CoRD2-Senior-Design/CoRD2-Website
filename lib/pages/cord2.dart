import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cord2 extends StatelessWidget{
  const Cord2({super.key});
  static const CameraPosition _ucf = CameraPosition(
    target: LatLng(28.6024, -81.2001),
    zoom: 14.4746
  );

  AutoSizeText _createText(String text, TextStyle style, double fontSize) {
    return AutoSizeText(text, style: style.copyWith(fontSize: fontSize)
    );
  }

  AutoSizeText _createSummary(TextStyle style, double fontSize) {
    return _createText(
      "Community Resilience Data Depot system (CoRD2) will target"
      " important concerns relating to resilient and AI-driven "
      "data services through networked communities and "
      "cross-sector partnerships.",
      style,
      fontSize
    );
  }

  Padding _createBullet(String text, TextStyle style, double fontSize, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        const Text("\u2022  "),
        Flexible(
          fit: FlexFit.loose,
          child: _createText(text, style, fontSize)
        )
      ])
    );
  }

  Column _createPageContent(double screenWidth) {
    const double defaultFont = 16.0;
    double fontScaling = screenWidth > 750 ? 1.0 : 0.8;
    TextStyle boldStyle = const TextStyle(fontWeight: FontWeight.bold);
    TextStyle headerStyle = const TextStyle(fontWeight: FontWeight.w400);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: _createText("CoRD\u00B2", boldStyle, 35.0 * fontScaling)
        ),
        Flexible(
          fit: FlexFit.loose,
          child:  _createSummary(headerStyle, defaultFont * fontScaling)
        ),
        _createBullet(
          "Data of interest for this project are from different "
              "origins and have different analytical desires. "
              "Such origin diversity arises due to the different "
              "partners involved in this project as well as different "
              "data generation sources. An integrated distributed data "
              "storage and retrieval system to coordinate and accommodate "
              "all desires is needed.",
          headerStyle,
          defaultFont * fontScaling,
          const EdgeInsets.only(left: 20.0)
        ),
        _createBullet(
          "As natural disasters may cause "
              "failures in computer systems (e.g., "
              "data loss, equipment failure, and power "
              "disruption), cutting-edge resilience "
              "techniques will be designed and deployed to "
              "improve the reliability of data and "
              "computer systems.",
          headerStyle,
          defaultFont * fontScaling,
          const EdgeInsets.only(left: 20.0)
        ),
        _createBullet(
          "State-of-the-art machine learning "
              "techniques will be designed to analyze "
              "multi-modal data sources (e.g., texts "
              "and images).",
          headerStyle,
          defaultFont * fontScaling,
          const EdgeInsets.only(left: 20.0, bottom: 20.0)
        ),
        const Flexible(
          fit: FlexFit.loose,
          child: GoogleMap(initialCameraPosition: _ucf,),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double lrPadding = width > 750 ? 150.0 : 50;
    double tbPadding = width > 750 ? 50.0 : 15;

    return Scaffold (
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: tbPadding,
                left: lrPadding,
                right: lrPadding,
                bottom: tbPadding,
            ),
            child: _createPageContent(width)
          )
        ),
    );
  }
}