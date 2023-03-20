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
import 'package:room_finder_flutter/widgets/BangKhachHangList.dart';

import 'package:room_finder_flutter/widgets/BangNhuCauMuaList.dart';
import 'package:room_finder_flutter/widgets/FormTimKiemKhachHang.dart';

class RFKhachHangFragment extends StatefulWidget {
  static const routeName = '/khach-hang';

  @override
  _RFKhachHangFragmentState createState() => _RFKhachHangFragmentState();
}

class _RFKhachHangFragmentState extends State<RFKhachHangFragment> {
  BangKhachHangList bangkhachhang = new BangKhachHangList();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: appStore.textPrimaryColor),
            onPressed: () async {
              BangKhachHangList result = await showDialog(
                context: context,
                builder: (BuildContext context) => FormTimKiemKhachHang(),
              );

              setState(() {
                bangkhachhang = result;

              });
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: context.height(),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text("Danh sách khách hàng",
                                  style: boldTextStyle(size: 18)),
                            ),
                            BangKhachHangList(
                              name: bangkhachhang.name,
                              phone: bangkhachhang.phone,

                            ),
                          ]),
                      // Text("Danh sách khách hàng", style: boldTextStyle(size: 18)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
