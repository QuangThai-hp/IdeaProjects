import 'package:flutter/material.dart';
import 'package:room_finder_flutter/components/RFCustomerListComponent.dart';
import 'package:room_finder_flutter/components/RFHotelListComponent.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/providers/customer.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFViewAllSanPhamsListScreen extends StatelessWidget {
  final List<Customer> customerListData = SanPhamsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: "Khách hàng", appBarHeight: 60, showLeadingIcon: false, roundCornerShape: true),
      body: ListView.builder(
        padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 24),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          Customer data = customerListData[index % customerListData.length];
          return RFCustomerListComponent(customer: data);
        },
      ),
    );
  }
}
