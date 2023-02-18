import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/RFConformationDialog.dart';
import 'package:room_finder_flutter/providers/auth.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/screens/RFResetPasswordScreen.dart';
import 'package:room_finder_flutter/screens/RFSignUpScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart' as RFWidget;

import '../components/RFCongratulatedDialog.dart';
import '../models/http_exeption.dart';

enum AuthMode { Signup, Login }

// ignore: must_be_immutable
class RFEmailSignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  bool showDialog;
  String contentAlert = '';

  RFEmailSignInScreen({this.showDialog = false});

  @override
  _RFEmailSignInScreenState createState() => _RFEmailSignInScreenState();
}

class _RFEmailSignInScreenState extends State<RFEmailSignInScreen> {
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': ''
  };

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);

    widget.showDialog
        ? Timer.run(() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return Material(type: MaterialType.transparency, child: RFConformationDialog(widget.contentAlert));
        },
      );
    })
        : SizedBox();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _submit() async{
    setState(() {
      _isLoading = true;
    });

    try{
      if(_authMode == AuthMode.Login){
        await Provider.of<Auth>(context, listen: false).login(
            emailController.text,
            passwordController.text
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route)=>false);
      }
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog('Thông báo', 'Đăng nhập thành công');
      // });

    } on HttpException catch(error){
      RFWidget.showErrorDialog(error.message, context);
      // _showE(error.message);
    } catch (error){
      print(error);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog();
      // });
      RFWidget.showErrorDialog('Could not authentication you. Please again later', context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: RFAppSubTitle,
        mainWidgetHeight: 180,
        subWidgetHeight: 130,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Đăng nhập', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: emailController,
              focus: emailFocusNode,
              nextFocus: passWordFocusNode,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: "Tên đăng nhập",
                showLableText: true,
                // suffixIcon: Container(
                //   padding: EdgeInsets.all(2),
                //   decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: rf_rattingBgColor),
                //   child: Icon(Icons.done, color: Colors.white, size: 14),
                // ),
              ),
            ),
            16.height,
            AppTextField(
              controller: passwordController,
              focus: passWordFocusNode,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                lableText: 'Mật khẩu',
                showLableText: true,
              ),
            ),
            32.height,
            if(_isLoading)
              CircularProgressIndicator()
            else
              AppButton(
                color: rf_primaryColor,
                child: Text('Đăng nhập', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  _submit();
                },
              ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  child: Text("Quên mật khẩu?", style: primaryTextStyle()),
                  onPressed: () {
                    RFResetPasswordScreen().launch(context);
                  }),
            ),
          ],
        ),
        subWidget: socialLoginWidget(context, title1: "Bạn chưa có tài khoản? ", title2: "Đăng ký ngay", callBack: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/sign-up', (route)=>false);
        }),
      ),
    );
  }
}
