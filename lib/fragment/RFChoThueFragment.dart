import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
// import 'package:room_finder_flutter/screens/RFChoThueDetailScreen.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';
import 'package:room_finder_flutter/widgets/BangSanPhamChoThueList.dart';
// import 'package:room_finder_flutter/widgets/BangDinhDuongNgayList.dart';

import '../components/RFConformationDialog.dart';

class RFChoThueFragment extends StatefulWidget {
  @override
  _RFChoThueFragmentState createState() => _RFChoThueFragmentState();
}

class _RFChoThueFragmentState extends State<RFChoThueFragment> {
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

  String formatDate(String? dateTime, {String format = DATE_FORMAT_2, bool isFromMicrosecondsSinceEpoch = false}) {
    if (isFromMicrosecondsSinceEpoch) {
      return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000));
    } else {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    }
  }

  void selectDateAndTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn ? ThemeData.dark() : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        tenSanPhamController.text = "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: 'Sản phẩm cho thuê',
        mainWidgetHeight: 150,
        subWidgetHeight: 115,
        cardWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tìm kiếm tiêu đề sản phẩm', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: tenSanPhamController,
              focus: tenSanPhamFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Tên sản phẩm",
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
                // RFChoThueDetailScreen().launch(context);
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
                    Text("Danh sách sản phẩm", style: boldTextStyle(size: 18)),
                    BangSanPhamChoThueList(),
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
          Navigator.of(context).pushNamedAndRemoveUntil('/form-them-sp-cho-thue', (route)=>false);
          // toasty(context, 'Default FAB Button');
        },
        backgroundColor: rf_primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
