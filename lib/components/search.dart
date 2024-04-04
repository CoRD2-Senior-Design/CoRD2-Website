import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/point_data.dart';

class Search extends StatelessWidget {
  Search(
      {Key? key,
        required this.map,
        required this.data,
        required this.onSelect,
        required this.mapContext,
        required this.zoomTo})
      : super(key: key);
  final Widget map;
  final List<PointData> data;
  final Function(PointData) onSelect;
  final BuildContext mapContext;
  final Function(double, double) zoomTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: map,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SearchAnchor(
          viewConstraints: BoxConstraints(maxHeight: 300),
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              onTap: () {
                controller.openView();
              },
              onChanged: (search) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          },
          isFullScreen: false,
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            if (controller.text.isEmpty) {
              List<ListTile> items = data.map((point) =>
                  ListTile(
                      title: Text(point.title),
                      onTap: () {
                        zoomTo(point.latitude, point.longitude);
                        controller.closeView(point.title);
                      }
                  )).toList();
              return items;
            } else {
              List<ListTile> items = data.where((point) => point.title.toLowerCase().contains(controller.text.toLowerCase()))
                  .map((point) =>
                  ListTile(
                      title: Text(point.title),
                      onTap: () {
                        zoomTo(point.latitude, point.longitude);
                        controller.closeView(point.title);
                      }
                  )).toList();
              return items;
            }
          },
        ),
      ),
    );
  }
}