import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/screens/RFFormNhuCau.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFCommonAppComponent extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final Widget? cardWidget;
  final Widget? subWidget;
  final Widget? accountCircleWidget;
  final double? mainWidgetHeight;
  final double? subWidgetHeight;
  final bool? chucNang;
  final String? routeName;

  RFCommonAppComponent({
    this.title,
    this.subTitle,
    this.cardWidget,
    this.subWidget,
    this.mainWidgetHeight,
    this.subWidgetHeight,
    this.accountCircleWidget,
    this.chucNang,
    this.routeName
  });

  @override
  State<RFCommonAppComponent> createState() => _RFCommonAppComponentState();
}

class _RFCommonAppComponentState extends State<RFCommonAppComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: context.width(),
            height: widget.mainWidgetHeight ?? 300,
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              backgroundColor: rf_primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title.validate(), style: boldTextStyle(color: white, size: 22)),
                4.height,
                Text(widget.subTitle.validate(), style: primaryTextStyle(color: white)),
                (widget.chucNang != null && widget.chucNang == true) ? Container(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RFFormNhuCauScreen(nhom: "Khách hàng", previousPage: widget.routeName)
                                  ),
                                  (route) => false);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: getColorFromHex('#f2866c'),
                              primary: getColorFromHex('#f2866c'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: Colors.white, size: 16,),
                                4.width,
                                Text('Khách hàng', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            )
                        ),
                      ),
                      8.width,
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RFFormNhuCauScreen(nhom: "Cần Mua", previousPage: widget.routeName)
                                  ),
                                      (route) => false);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: getColorFromHex('#f2866c'),
                              primary: getColorFromHex('#f2866c'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: Colors.white, size: 16,),
                                4.width,
                                Text('Mua', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            )
                        ),
                      ),
                      8.width,
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(

                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RFFormNhuCauScreen(nhom: "Cho thuê", previousPage: widget.routeName)
                                  ),
                                      (route) => false);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: getColorFromHex('#f2866c'),
                              primary: getColorFromHex('#f2866c'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: Colors.white, size: 16,),
                                4.width,
                                Text('Cho thuê', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox(width: 5,),
                widget.chucNang != null && widget.chucNang == true ? Container(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(

                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RFFormNhuCauScreen(nhom: "Chủ nhà", previousPage: widget.routeName)
                                  ),
                                      (route) => false);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: getColorFromHex('#f2866c'),
                              primary: getColorFromHex('#f2866c'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: Colors.white, size: 16,),
                                4.width,
                                Text('Chủ nhà', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            )
                        ),
                      ),
                      8.width,
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(

                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RFFormNhuCauScreen(nhom: "Cần Bán", previousPage: widget.routeName)
                                  ),
                                      (route) => false);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: getColorFromHex('#f2866c'),
                              primary: getColorFromHex('#f2866c'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: Colors.white, size: 16,),
                                4.width,
                                Text('Bán', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            )
                        ),
                      ),
                      8.width,
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(

                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RFFormNhuCauScreen(nhom: "Cần thuê", previousPage: widget.routeName)
                                  ),
                                      (route) => false);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: getColorFromHex('#f2866c'),
                              primary: getColorFromHex('#f2866c'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: Colors.white, size: 16,),
                                4.width,
                                Text('Cần thuê', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox(width: 5,),
              ],
            ),
          ),
          Column(
            children: [
              widget.accountCircleWidget ??
                  Container(
                    margin: EdgeInsets.only(top: widget.subWidgetHeight ?? 200, left: 24, bottom: 24, right: 24),
                    padding: EdgeInsets.all(24),
                    decoration: appStore.isDarkModeOn ? boxDecorationWithRoundedCorners(backgroundColor: context.cardColor) : shadowWidget(context),
                    child: widget.cardWidget.validate(),
                  ),
              widget.subWidget.validate(),
            ],
          ),
        ],
      ),
    );
  }
}
