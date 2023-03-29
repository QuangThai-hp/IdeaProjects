import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/Profiles.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import '../utils/RFString.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class RFSuaThongTinCaNhan extends StatefulWidget {
  static const routeName = '/form-sua-thong-tin';
  final String? uid, name, phone, email, diaChi, ngaySinh;
  RFSuaThongTinCaNhan({this.uid, this.name, this.phone, this.email, this.diaChi, this.ngaySinh});
  @override
  _RFSuaThongTinCaNhanState createState() => _RFSuaThongTinCaNhanState();
}

class _RFSuaThongTinCaNhanState extends State<RFSuaThongTinCaNhan> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController ngaySinhController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode diaChiFocusNode = FocusNode();
  FocusNode ngaySinhFocusNode = FocusNode();

  FocusNode f4 = FocusNode();
  DateTime? selectedDate;

  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.name);
    dienThoaiController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    diaChiController = TextEditingController(text: widget.diaChi);
    ngaySinhController.text= "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    print(dienThoaiController.text);
    try {
      await Provider.of<Profiles>(context, listen: false).editProfile(
        widget.uid,
        fullNameController.text,
        dienThoaiController.text,
        emailController.text,
        diaChiController.text,
        ngaySinhController.text,
      );
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      showErrorDialog(error.message, context);
    } catch (error) {
      print(error);
      showErrorDialog(
          'Could not authentication you. Please again later', context);
    }
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
        ngaySinhController.text = "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: RFAppSubTitle,
        mainWidgetHeight: 250,
        subWidgetHeight: 190,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sửa thông tin cá nhân', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: fullNameController,
              focus: fullNameFocusNode,
              nextFocus: diaChiFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Họ tên",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            TextFormField(
              controller: ngaySinhController,
              focusNode: ngaySinhFocusNode,
              readOnly: true,
              onTap: () {
                selectDateAndTime(context);
              },
              onFieldSubmitted: (v) {
                ngaySinhFocusNode.unfocus();
                FocusScope.of(context).requestFocus(f4);
              },
              decoration: inputDecoration(
                context,
                hintText: "Ngày nhập",
                suffixIcon: Icon(Icons.calendar_month_rounded, size: 16, color: appStore.isDarkModeOn ? white : gray),
              ),
            ),
            16.height,
            AppTextField(
              controller: diaChiController,
              focus: diaChiFocusNode,
              nextFocus: dienThoaiFocusNode,
              textFieldType: TextFieldType.ADDRESS,
              decoration: rfInputDecoration(
                lableText: "Địa chỉ",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: dienThoaiController,
              focus: dienThoaiFocusNode,
              nextFocus: emailFocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: "Điện thoại",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: emailController,
              focus: emailFocusNode,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: "Email",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            32.height,
            if (_isLoading)
              CircularProgressIndicator()
            else
              AppButton(
                color: rf_primaryColor,
                child:
                    Text('Sửa thông tin', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  _submit();
                  RFHomeScreen rf_home = new RFHomeScreen();
                  rf_home.selectedIndex = 4;
                  rf_home.launch(context);
                  // RFHomeScreen().launch(context);
                },
              ),
            rfCommonRichText(title: "Huỷ nhập dữ liệu. ", subTitle: "Quay lại")
                .paddingAll(8)
                .onTap(
              () {
                RFHomeScreen rf_home = new RFHomeScreen();
                rf_home.selectedIndex = 4;
                rf_home.launch(context);

                // rf_search.
                // Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route)=>false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
