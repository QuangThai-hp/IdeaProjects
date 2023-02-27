import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';
import 'package:room_finder_flutter/widgets/BangSanPhamChoThueList.dart';
import 'package:room_finder_flutter/widgets/BangKhachHang.dart';
class RFKhachHangFragment extends StatefulWidget {
  static const routeName = '/khach-hang';

  @override
  _RFKhachHangFragmentState createState() => _RFKhachHangFragmentState();
}

class _RFKhachHangFragmentState extends State<RFKhachHangFragment> {
  TextEditingController tenSanPhamController = TextEditingController();
  FocusNode tenSanPhamFocusNode = FocusNode();
  DateTime? selectedDate;
  FocusNode f4 = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: 'Danh sách khách hàng',
        mainWidgetHeight: 150,
        subWidgetHeight: 115,
        cardWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tìm kiếm SĐT khách hàng', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: tenSanPhamController,
              focus: tenSanPhamFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Nhập số điện thoại",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppButton(
              color: rf_primaryColor,
              elevation: 0.0,
              child: Text('Tìm kiếm', style: boldTextStyle(color: white)),
              width: context.width(),
              onTap: () {
              },
            ),
          ],
        ),
        subWidget: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: context.height(),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20 , right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text("Danh sách khách hàng", style: boldTextStyle(size: 18)),

                            ),
                            Container(
                              child: BangKhachHangList(),
                            )
                          ]
                      ),
                      // Text("Danh sách khách hàng", style: boldTextStyle(size: 18)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _bottomTab(),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/form-bua-an', (route)=>false);
          // toasty(context, 'Default FAB Button');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
