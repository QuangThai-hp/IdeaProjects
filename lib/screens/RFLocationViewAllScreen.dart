import 'package:flutter/material.dart';
import 'package:room_finder_flutter/components/RFLocationComponent.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFLocationViewAllScreen extends StatelessWidget {
  final List<RoomFinderModel> locationListData = locationList();
  final bool? locationWidth;

  RFLocationViewAllScreen({this.locationWidth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: "Khu vực", appBarHeight: 60, showLeadingIcon: false, roundCornerShape: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
        child: Wrap(
          spacing: 8,
          runSpacing: 16,
          children: List.generate(
            20,
            (index) {
              return RFLocationComponent(locationData: locationListData[index % locationListData.length], locationWidth: locationWidth);
            },
          ),
        ),
      ),
    );
  }
}
