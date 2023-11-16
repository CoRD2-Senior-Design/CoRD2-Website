import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class Cord2 extends StatefulWidget {
  const Cord2({super.key});

  @override
  Cord2State createState() => Cord2State();
}

class Cord2State extends State<Cord2>{

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
        Expanded(
          child: _createText(text, style, fontSize)
        )
      ])
    );
  }

  ListView _createPageContent(double screenWidth) {
    const double defaultFont = 16.0;
    double fontScaling = screenWidth > 750 ? 1.0 : 0.8;

    TextStyle boldStyle = const TextStyle(fontWeight: FontWeight.bold);
    TextStyle headerStyle = const TextStyle(fontWeight: FontWeight.w400);

    double lrPadding = screenWidth > 750 ? 150.0 : 50;
    double tbPadding = screenWidth > 750 ? 50.0 : 15;

    return ListView(
      padding: EdgeInsets.only(
        top: tbPadding,
        left: lrPadding,
        right: lrPadding,
        bottom: tbPadding,
      ),
      children: <Widget>[
        Center(
          child: _createText("CoRD\u00B2", boldStyle, 35.0 * fontScaling)
        ),
        _createSummary(headerStyle, defaultFont * fontScaling),
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
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500, maxWidth: (screenWidth * 0.75)),
          child: Stack(
            children: [
              FlutterMap(
                options: const MapOptions(
                    initialCenter: LatLng(28.6026, -81.2001),
                    initialZoom: 6
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.cord2.map',
                    tileProvider: CancellableNetworkTileProvider(),
                  ),
                ]
              ),
              Container(
                color: const Color.fromRGBO(0, 0, 0, 0.75),
                width: screenWidth,
                height: 30,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("CoRD2 Map", style: TextStyle(color: Colors.white))
                    )
                  ])
              )
            ],
          )

        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold (
      body: SelectionArea(
        child: Center(
            child: _createPageContent(width)
        ),
      )
    );
  }
}