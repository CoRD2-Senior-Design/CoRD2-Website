import 'package:flutter/material.dart';

class Cord2 extends StatelessWidget{
  const Cord2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
        body: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, left: 100.0, right: 100.0),
            child: Column(
              children: <Widget>[
                Text(
                    "CoRD\u00B2",
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)
                ),
                Text(
                    "Community Resilience Data Depot system (CoRD2) will target"
                    " important concerns relating to resilient and AI-driven "
                    "data services through networked communities and "
                    "cross-sector partnerships.",
                    style: TextStyle(fontSize: 20.0)
                )
              ],
            ),
          )

        ),
    );
  }
}