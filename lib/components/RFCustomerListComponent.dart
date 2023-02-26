import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFAccountFragment.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/providers/customer.dart';
import 'package:room_finder_flutter/screens/RFHotelDescriptionScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFCustomerListComponent extends StatelessWidget {
  final Customer? customer;

  RFCustomerListComponent({this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // rfCommonCachedNetworkImage(hotelData!.img.validate(), height: 100, width: 100, fit: BoxFit.cover).cornerRadiusWithClipRRect(8),
          8.width,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Colors.brown, size: 20,),
                          6.width,
                          Text(customer!.hoTen.validate(), style: boldTextStyle(color: Colors.black87)),
                        ],
                      ),
                      8.height,
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, color: Colors.brown, size: 20,),
                          6.width,
                          Text(customer!.field_dien_thoai.validate()),
                        ],
                      ),
                      // Text(hotelData!.roomCategoryName.validate(), style: boldTextStyle()),

                    ],
                  ).expand(),
                  Row(
                    children: [
                      Container(
                        decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: customer!.field_trang_thai == 'Khách hàng tiềm năng' ? greenColor : dodgerBlue),
                        padding: EdgeInsets.all(4),
                      ),
                      6.width,
                      // Text(customer!.field_trang_thai.validate(), style: secondaryTextStyle()),
                    ],
                  ),
                ],
              ),
              8.height,
              // showHeight.validate() ? 8.height : 24.height,
            ],
          ).expand()
        ],
      ),
    ).onTap(() {
      // RFHotelDescriptionScreen(hotelData: hotelData).launch(context);
      RFAccountFragment().launch(context);
    }, splashColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent);
  }
}
