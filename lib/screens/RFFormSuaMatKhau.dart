import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';

import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../utils/RFString.dart';

import 'package:provider/provider.dart';

class RFFormSuaMatKhau extends StatefulWidget {
  static const routeName = '';
 final String? nid;
  RFFormSuaMatKhau({ this.nid,});
  @override
  _RFFormSuaMatKhauState createState() => _RFFormSuaMatKhauState();
}

class _RFFormSuaMatKhauState extends State<RFFormSuaMatKhau> {
  TextEditingController MatKhauHienTaiController = TextEditingController();
  TextEditingController MatKhauMoiController = TextEditingController();
  TextEditingController NhapLaiMatKhauController = TextEditingController();

  FocusNode MatKhauHienTaiFocusNode = FocusNode();
  FocusNode MatKhauMoiFocusNode = FocusNode();
  FocusNode NhapLaiMatKhauFocusNode = FocusNode();

  FocusNode f4 = FocusNode();

  var _isLoading = false;
  late String? idKhachHang;
  @override
  void initState() {
    super.initState();

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
    try {
      await Provider.of<KhachHangs>(context, listen: false).editKhachHang(
        widget.nid,
        MatKhauHienTaiController.text,
        MatKhauMoiController.text,
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

  @override
  Widget build(BuildContext context) {

    print(widget.nid);
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: RFAppSubTitle,
        mainWidgetHeight: 250,
        subWidgetHeight: 190,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sửa thông tin khách hàng', style: boldTextStyle(size: 18)),
            16.height,

            AppTextField(
              controller: MatKhauHienTaiController,
              focus: MatKhauHienTaiFocusNode,
              nextFocus: MatKhauMoiFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Mật Khẩu Cũ",
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
              controller: MatKhauMoiController,
              focus: MatKhauMoiFocusNode,
              nextFocus: NhapLaiMatKhauFocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: "Mật Khẩu Mới",
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
            16.height,  AppTextField(
              controller: NhapLaiMatKhauController,
              focus: NhapLaiMatKhauFocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: "Nhập lại Mật Khẩu",
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
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home', (route) => false);
                  // RFHomeScreen().launch(context);
                },
              ),
            rfCommonRichText(title: "Huỷ nhập dữ liệu. ", subTitle: "Quay lại").paddingAll(8).onTap(
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
