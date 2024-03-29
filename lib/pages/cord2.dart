import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cord2_website/components/chat_screen.dart';
import 'package:cord2_website/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class MarkerData {
  final String title;
  final String creatorId;
  final String creator;
  final String description;
  final double latitude;
  final double longitude;
  final String eventType;
  final DateTime time;

  MarkerData(
      this.title,
      this.creatorId,
      this.creator,
      this.description,
      this.latitude,
      this.longitude,
      this.eventType,
      this.time
      );
}

class Cord2 extends StatefulWidget {
  const Cord2({super.key});

  @override
  Cord2State createState() => Cord2State();
}

class Cord2State extends State<Cord2>{
  CollectionReference events = FirebaseFirestore.instance.collection("events");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  late List<Marker> _markers = [];
  bool _info = true;
  MarkerData? _selectedMarker;
  final int blurple = 0xff20297A;
  late ChatModel _selectedChat;


  @override
  void initState() {
    super.initState();
    createMarkers();
  }

  void createMarkers() async {
    List<Marker> markers = [];
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await events.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()as Map<String, dynamic>).toList();

    // loop through allData and add markers there
    for (var point in allData) {
      // if active show/add, otherwise dont show
      if (point['active'] == true) {
        MarkerData markerData = MarkerData(
            point['title'],
            point['creator'],
            "",
            point['description'],
            point['latitude'] as double,
            point['longitude'] as double,
            point['eventType'],
            point['time'].toDate()
        );
        markers.add(Marker(
            point: LatLng(point['latitude'] as double, point['longitude'] as double),
            width: 56,
            height: 56,
            child: customMarker(markerData)
        ));
      }
    }

    setState(() {
      _markers = markers;
    });

  }

  MouseRegion customMarker(MarkerData data) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () => handleMarkerSelect(data),
            child: const Icon(Icons.person_pin_circle_rounded)
        )
    );
  }

  void handleMarkerSelect(MarkerData data) async {
    String theUser = data.creatorId;
    DocumentSnapshot doc = await users.doc(theUser).get();
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    setState(() {
      _info = true;
      _selectedMarker = MarkerData(
          data.title,
          data.creatorId,
          userData['name'],
          data.description,
          data.latitude,
          data.longitude,
          data.eventType,
          data.time
      );
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
              constraints: BoxConstraints(maxHeight: 600, maxWidth: (screenWidth * 0.75)),
              child: renderMap(screenWidth),
              ),
            ),
            Expanded(
              flex: 2,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 600, maxWidth: (screenWidth * 0.25)),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Report Title: ${_selectedMarker.title}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Uploaded By: ${_selectedMarker.creator}\nDate: ${DateFormat.yMEd().add_jms().format(_selectedMarker.time)}",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Report Description: ${_selectedMarker.description}",
                      style: const TextStyle(
                        fontSize: 15.0
                      )
                    ),
                  ),
                  if (FirebaseAuth.instance.currentUser != null) GestureDetector(
                    onTap: () => handleUserChat(),
                    child: const Text.rich(
                      TextSpan(
                        text: "Chat with this user",
                        mouseCursor: MaterialStateMouseCursor.clickable,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15.0
                        )
                      )
                    )
                  ),
                ]
            )
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
    return Stack(
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
              MarkerLayer(markers: _markers)
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
            ]
          ),
        ),
      ]
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