import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/screens/RFFormSuaMatKhau.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';


class RFHeThongFragment extends StatefulWidget {
  @override
  State<RFHeThongFragment> createState() => _RFHeThongFragmentState();
}

class _RFHeThongFragmentState extends State<RFHeThongFragment> {
  final List<RoomFinderModel> settingData = settingList();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: "Account",
        mainWidgetHeight: 200,
        subWidgetHeight: 100,
        accountCircleWidget: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 150),
                width: 100,
                height: 100,
                decoration: boxDecorationWithRoundedCorners(
                    boxShape: BoxShape.circle,
                    border: Border.all(color: white, width: 4)),
                child: rfCommonCachedNetworkImage(rf_user,
                    fit: BoxFit.cover, width: 100, height: 100, radius: 150),
              ),
              Positioned(
                bottom: 8,
                right: -4,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(6),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor,
                    boxShape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.4,
                          blurRadius: 3,
                          color: gray.withOpacity(0.1),
                          offset: Offset(1, 6)),
                    ],
                  ),
                  child: Icon(Icons.edit,
                      color: appStore.isDarkModeOn ? white : rf_primaryColor,
                      size: 16),
                ),
              ),
            ],
          ),
        ),
        subWidget: Column(
          children: [
            16.height,
            Text('Pham the Manh', style: boldTextStyle(size: 18)),
            8.height,
            16.height,
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.scaffoldBackgroundColor,
                    side: BorderSide(color: context.dividerColor, width: 1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rf_call.iconImage(
                          iconColor:
                              appStore.isDarkModeOn ? white : rf_primaryColor),
                      8.width,
                      Text('Gọi ngay',
                          style: boldTextStyle(
                              color: appStore.isDarkModeOn
                                  ? white
                                  : rf_primaryColor)),
                    ],
                  ),
                ).expand(),
                16.width,
                AppButton(
                  color: rf_primaryColor,
                  elevation: 0.0,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  width: context.width(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rf_message.iconImage(iconColor: whiteColor),
                      // rfCommonCachedNetworkImage(rf_message, color: white, height: 16, width: 16),
                      8.width,
                      Text('Nhắn tin ', style: boldTextStyle(color: white)),
                    ],
                  ),
                  onTap: () {},
                ).expand()
              ],
            ).paddingSymmetric(horizontal: 16),
            16.height,
            Container(
              height: 42.0,
              width: SizeConfig.screenWidth,
              color: Colors.black12,
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.payments_outlined,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Giao dịch',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                  10.height,
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.document_scanner_outlined,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Tài liệu học tập',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                  10.height,
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.directions,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Danh mục Quận huyện',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                  10.height,
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.contacts,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Danh mục Phường xã',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                  10.height,
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.contacts,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Danh mục Hướng',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                ],
              ),
            ),
            Container(
              height: 42.0,
              width: SizeConfig.screenWidth,
              color: Colors.black12,
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.medical_information_outlined,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Thay đổi thông tin cá nhân',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                  10.height,
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.contacts,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Thông tin liên hệ',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      )),
                  10.height,
                  TextButton(
                      onPressed: () {
                       showDialog(context: context, builder: (BuildContext context)=> AlertDialog(
                         title: const Text('Đăng xuất'),
                         content: const Text('Bạn có chắc đăng xuất'),
                         actions: <Widget>[
                           TextButton(
                             onPressed: (){
                               finish(context);
                             },
                             child: const Text('Hủy'),
                           ),
                           TextButton(
                             onPressed: (){
                               RFEmailSignInScreen().launch(context).then((value){
                                 finish(context);
                               });
                             },
                             child: const Text('OK'),
                           ),
                         ],
                       ),);
                      },
                      //  RFEmailSignInScreen().launch(v).then((value) {
                      //                             finish(context);
                      //                           });
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Đăng xuất',
                                style: TextStyle(
                                    color: color_primary_black, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
