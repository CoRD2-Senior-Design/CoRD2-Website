import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cord2_website/components/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chat_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ChatModel _selectedChat;
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool _chat = false;
  late List<ChatModel> _chats = [];
  late StreamSubscription<DatabaseEvent> _chatSubscription;

  @override
  void initState() {
    super.initState();
    getChatData();
  }

  void getChatData() async {
    DatabaseReference chatRef = FirebaseDatabase.instance.ref('chats/${user?.uid}');
    _chatSubscription = chatRef.onValue.listen((DatabaseEvent event) async {
      List<ChatModel> newList = [];
      for (DataSnapshot val in event.snapshot.children) {
        final map = val.value as Map?;
        Map<String, String> otherUser = {};
        List<String> participants = [];
        for (Object? part in map?['participants']) {
          participants.add(part.toString());
          if (part.toString() != user?.uid) {
            otherUser['uid'] = part.toString();
            DocumentSnapshot doc = await users.doc(part.toString()).get();
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            otherUser['name'] = data['name'];
          }
        }
        if (otherUser.entries.isEmpty) continue;
        DateTime lastUpdate = DateTime.parse(map!['lastUpdate'].toString());
        newList.add(
            ChatModel(otherUser, participants, lastUpdate, val.key)
        );
        setState(() {
          _chats = newList;
        });
      }
    });
  }

  @override
  void dispose() {
    _chatSubscription.cancel();
  }

  Widget chatHistory() {
    return ListView.builder(
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final item = _chats[index];
          return Container(
              child: Card(
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                               _selectedChat = item;
                               _chat = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text("Chat with: ${item.participant['name']!}"),
                              Text(DateFormat.yMEd().add_jms().format(item.lastUpdate))
                            ],
                          )
                      )
                  )
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 600, maxWidth: (screenWidth * 0.3)),
              child: chatHistory()
            )
          ),
          Expanded(
            flex: 2,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 600, maxWidth: (screenWidth * 0.6)),
              child: _chat ? MessagePage(chat: _selectedChat, closeChat: () => setState(() {_chat = false; })) : Text("Select a chat", textAlign: TextAlign.center,),
            )
          )
        ]
      )
    );
  }
}