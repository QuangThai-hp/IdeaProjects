import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/RFCongratulatedDialog.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/providers/auth.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RFFormSua extends StatefulWidget {
  static const routeName = '/form-sua';
 final String? nid,name,phone;
  RFFormSua({ this.nid, this.name, this.phone});
  @override
  _RFFormSuaState createState() => _RFFormSuaState();
}

class _RFFormSuaState extends State<RFFormSua> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();

  FocusNode f4 = FocusNode();

  var _isLoading = false;
  late String? idKhachHang;
  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.name);
    dienThoaiController = TextEditingController(text: widget.phone);
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
        fullNameController.text,
        dienThoaiController.text,
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
              controller: fullNameController,
              focus: fullNameFocusNode,
              nextFocus: dienThoaiFocusNode,
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
            AppTextField(
              controller: dienThoaiController,
              focus: dienThoaiFocusNode,
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
          ],
        ),
      ),
    );
  }
}
