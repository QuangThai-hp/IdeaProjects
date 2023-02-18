import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/screens/RFHotelDescriptionScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFSanPhamListComponent extends StatelessWidget {
  final SanPham? sanPhamData;
  final bool? showHeight;

  RFSanPhamListComponent({this.sanPhamData, this.showHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
      padding: EdgeInsets.only(left: 8, right: 4, top: 8, bottom: 8),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       //   rfCommonCachedNetworkImage(sanPhamData!.field_image.validate(), height: 100, width: 100, fit: BoxFit.cover).cornerRadiusWithClipRRect(8),
          16.width,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(//
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sanPhamData!.title.validate(), style: boldTextStyle()),
                      8.height,
                      Row(
                        children: [
                          Icon(Icons.money_off, color: Colors.brown, size: 20),
                          3.width,
                          // Text(sanPhamData!.field_gia.validate(), style: primaryTextStyle()),
                          8.width,
                          Icon(Icons.line_axis, color: Colors.brown, size: 20),
                          3.width,
                          Text(sanPhamData!.field_duong.validate(), style: primaryTextStyle()),
                        ],
                      )
                    ],
                  ).expand(),
                  // Row(
                  //   children: [
                  //     Container(
                  //       decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: greenColor),
                  //       padding: EdgeInsets.all(4),
                  //     ),
                  //     6.width,
                  //     Text(sanPhamData!.field_dia_chi.validate(), style: secondaryTextStyle()),
                  //   ],
                  // ),
                ],
              ),
              8.height,
              Row(
                children: [
                  Icon(Icons.nat, color: Colors.brown, size: 20),
                  6.width,
                  Text(sanPhamData!.field_huong.validate(), style: primaryTextStyle()),
                ],
              ),
            ],
          ).expand()
        ],
      ),
    ).onTap(() {
      // RFHotelDescriptionScreen(sanPhamData: sanPhamData).launch(context);
    }, splashColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent);
  }
}
