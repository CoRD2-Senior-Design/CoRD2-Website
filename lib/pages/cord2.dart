import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cord2_website/components/chat_screen.dart';
import 'package:cord2_website/components/search.dart';
import 'package:cord2_website/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

import '../models/point_data.dart';

class Cord2 extends StatefulWidget {
  const Cord2({super.key});

  @override
  Cord2State createState() => Cord2State();
}

class Cord2State extends State<Cord2>{
  final double latitude = 28.5384;
  final double longitude = -81.3789;
  CollectionReference events = FirebaseFirestore.instance.collection("events");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  late List<Marker> _markers = [];
  late List<PointData> _data = [];
  late MapController mapController;
  bool _info = true;
  PointData? _selectedMarker;
  Map<String, dynamic>? _selectedGeoMarker;
  final int blurple = 0xff20297A;
  late ChatModel _selectedChat;


  @override
  void initState() {
    super.initState();
    mapController = MapController();
    createMarkers();
  }

  void zoomTo(double lat, double lon) {
    mapController.move(LatLng(lat, lon), 15.0);
  }

  void refreshMap() async {
    createMarkers();
  }

  // shows user submitted reports
  void createMarkers() async {
    List<Marker> markers = [];
    List<PointData> points = [];
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await events.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    QuerySnapshot userSnapshot = await users.get();
    // Get data from docs and convert map to List
    final allUsers = userSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // loop through allData and add markers there
    for (var point in allData) {
      String theUser;
      DocumentSnapshot doc = await users.doc(point['creator'].toString()).get();
      if (!mounted) return;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String username = data['name'];
      DateTime time = point['time'].toDate();
      String imageURL = point['images'].toString();

      // if active show/add, otherwise dont show
      if (point['active'] == true) {
        var pointData = PointData(
            point['latitude'] as double,
            point['longitude'] as double,
            point['description'],
            point['title'],
            point['eventType'],
            imageURL.substring(1, imageURL.length -1),
            DateFormat.yMEd().add_jms().format(time),
            username,
            point['creator']);

        markers.add(Marker(
            point: LatLng(
                point['latitude'] as double, point['longitude'] as double),
            width: 56,
            height: 56,
            child: customMarker(pointData)));
        points.add(pointData);
      }
    }

    setState(() {
      if (!mounted) return;
      _markers = markers;
      _data = points;
    });
  }

  MouseRegion customMarker(PointData data) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () => handleMarkerSelect(data),
            child: const Icon(Icons.person_pin_circle_rounded)
        )
    );
  }

  void handleMarkerSelect(PointData data) async {
    String theUser = data.creatorId;
    DocumentSnapshot doc = await users.doc(theUser).get();
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    setState(() {
      _info = true;
      _selectedMarker = data;
    });
  }

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
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 750, minHeight: 750),
              child: renderMap(screenWidth),
              ),
            ),
            Expanded(
              flex: 2,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 750, minHeight: 750),
                child: _info ? renderSelection() : MessagePage(chat: _selectedChat, closeChat: () => setState(() {_info = true;})),
              ),
            )
          ]
        )
      ],
    );
  }

  void handleUserChat() async {
    final selectedMarker = this._selectedMarker;
    DatabaseReference ref = FirebaseDatabase.instance.ref('chats/${FirebaseAuth.instance.currentUser?.uid}');
    DataSnapshot snapshot = await ref.get();
    for (DataSnapshot val in snapshot.children) {
      final map = val.value as Map?;
      List<String> participants = map?['participants'].map<String>((val) => val.toString()).toList();
      bool match = false;
      for (Object? part in map?['participants']) {
        Map<String, String> participant = {};
        if (part.toString() == selectedMarker?.creatorId) {
          match = true;
          DocumentSnapshot doc = await users.doc(part.toString()).get();
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          participant['name'] = data['name'];
          participant['uid'] = part.toString();
          DateTime lastUpdate = DateTime.parse(map!['lastUpdate'].toString());
          setState(() {
            _selectedChat = ChatModel(participant, participants, lastUpdate, val.key);
            _info = false;
          });
        }
      }
      if (match) return;
    }
    var chatId = Uuid().v4();
    DatabaseReference newChat = FirebaseDatabase.instance.ref('chats/${selectedMarker?.creatorId}/$chatId');
    var res =await newChat.update({
      "lastUpdate": DateTime.now().toString(),
      "participants": ["${selectedMarker?.creatorId}", "${FirebaseAuth.instance.currentUser?.uid}"]
    });
    ref = FirebaseDatabase.instance.ref('chats/${FirebaseAuth.instance.currentUser?.uid}/$chatId');
    res = await ref.update({
      "lastUpdate": DateTime.now().toString(),
      "participants": ["${selectedMarker?.creatorId}", "${FirebaseAuth.instance.currentUser?.uid}"]
    });
    DatabaseReference newMsg = FirebaseDatabase.instance.ref('msgs');
    res = await newMsg.update({
      chatId: []
    });
    Map<String, String> participant = {};
    DocumentSnapshot doc = await users.doc(selectedMarker?.creatorId.toString()).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    participant['name'] = data['name'];
    participant['uid'] = selectedMarker!.creatorId.toString();
    List<String> participants = [selectedMarker!.creatorId, FirebaseAuth.instance.currentUser!.uid];
    DateTime lastUpdate = DateTime.now();

    setState(() {
      _selectedChat = ChatModel(participant, participants, lastUpdate, chatId);
      _info = false;
    });
  }

  Widget renderSelection() {
    final _selectedMarker = this._selectedMarker;
    if (_selectedMarker != null) {
      return Container(
          color: const Color.fromRGBO(83, 83, 83, 0.5),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child:  Padding(
                      padding: const EdgeInsets.only(top:20, bottom:20),
                      child:
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:25, bottom:5),
                              child: Center(
                                  child: Text(
                                      style: GoogleFonts.jost(
                                          textStyle: const
                                          TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff060C3E),
                                            decoration: TextDecoration.underline,
                                            decorationColor: Color(0xff242C73), // Color of the underline
                                            decorationThickness: 2.0,     // Thickness of the underline
                                            decorationStyle: TextDecorationStyle.solid,
                                          )),
                                      _selectedMarker.title)),
                            ),
                            const SizedBox(height:5),
                            Text(
                                style: GoogleFonts.jost(
                                    textStyle: const
                                    TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff060C3E),
                                    )),
                                _selectedMarker.eventType),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                  child: Text(
                                      style: GoogleFonts.jost(
                                          textStyle: const
                                          TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff060C3E),
                                          )),
                                      'Submitted by: ${_selectedMarker.creator}')),
                            ),
                            SizedBox(height:5),
                            Center(
                              child:  Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                      color: Colors.deepOrange,
                                      child: Text(
                                          style: GoogleFonts.jost(
                                              textStyle: const
                                              TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              )),
                                          _selectedMarker.description))),
                            ),
                            SizedBox(height:10),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                  child: Image.network(
                                    _selectedMarker.imageURL,
                                    width: 250,
                                    height: 250,
                                  )
                              ),
                            ),
                            SizedBox(height:10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(child: Text(_selectedMarker.formattedDate, style: GoogleFonts.jost(
                                  textStyle: const
                                  TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff060C3E),
                                  )),)),
                            ),
                            SizedBox(height:10),
                            if (FirebaseAuth.instance.currentUser != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child:
                                ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        EdgeInsets.all(10.0), // Adjust the padding to change the size
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff242C73)), // Default color
                                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                          if (states.contains(MaterialState.hovered))
                                            return Colors.blueAccent.withOpacity(0.5); // Hover color
                                          return Colors.red; // No overlay color
                                        },
                                      ),
                                    ),
                                    onPressed: () { handleUserChat(); },
                                    child: Text(
                                      "Chat with this user",
                                      style: GoogleFonts.jost(
                                          textStyle: const
                                          TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          )),
                                    )
                                ),
                              ),
                          ],
                        ),
                      )
                  ),
            ),
          )
          );
    } else {
      return Container(
        color: const Color.fromRGBO(83, 83, 83, 0.5),
        child: const Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select a Marker to View Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]
          )
        )
      );
    }
  }

  Widget renderMap(double screenWidth) {
    return Scaffold(
      body: Search(
          map: FlutterMap(
            mapController: mapController,
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
                _buildClusterLayer(_markers, Colors.blue),
              ]
          ),
          data: _data,
          onSelect: handleMarkerSelect,
          mapContext: context,
          zoomTo: zoomTo
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          FloatingActionButton(
            onPressed: () {
              refreshMap();
            },
            backgroundColor:  Color(0xff060C3E),
            child: Icon(Icons.refresh, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  MarkerClusterLayerWidget _buildClusterLayer(
      List<Marker> markers, Color color) {
    return MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
            maxClusterRadius: 75,
            size: const Size(40, 40),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50),
            markers: markers,
            builder: (context, markers) {
              return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
              ),
              child: Text(markers.length.toString(),
              style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.none,
              )));
          }));
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