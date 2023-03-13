import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/RFConformationDialog.dart';
import 'package:room_finder_flutter/providers/auth.dart';
import 'package:room_finder_flutter/screens/RFResetPasswordScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart' as RFWidget;

import '../components/RFCongratulatedDialog.dart';
import '../models/http_exeption.dart';
import '../utils/RFWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  Map<String, String> _authData = {'email': '', 'password': ''};
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  Timer? timer;
  late Box box1;

  @override
  void initState() {
    super.initState();
    createBox();

    init();
  }

  void createBox() async {
    box1 = await Hive.openBox('emailController');
    getData();
  }

  void getData() async {
    if(box1.get('emailController')!=null){
      emailController.text=box1.get('emailController');
      isChecked==true;
      setState(() { });
    };
    if(box1.get('passwordController')!=null){
      passwordController.text=box1.get('passwordController');
      isChecked==true;
      setState(() { });
    };
  }
  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);

    widget.showDialog
        ? Timer.run(() {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                Future.delayed(Duration(seconds: 5), () {
                  Navigator.of(context).pop(true);
                });
                return Material(
                    type: MaterialType.transparency,
                    child: RFConformationDialog(widget.contentAlert));
              },
            );
          })
        : SizedBox();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _submit() async {
    if (isChecked) {
      box1.put('emailController', emailController.text);
      box1.put('passwordController', passwordController.text);
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .login(emailController.text, passwordController.text, context);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog('Thông báo', 'Đăng nhập thành công');
      // });
    } on HttpException catch (error) {
      RFWidget.showErrorDialog(error.message, context);
    } catch (error) {
      print(error);
      showInDialog(context, barrierDismissible: true, builder: (context) {
        return RFCongratulatedDialog();
      });
      RFWidget.showErrorDialog(
          'Could not authentication you. Please again later', context);
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
        mainWidgetHeight: 230,
        subWidgetHeight: 190,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nhớ mật khẩu',

                ),
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      isChecked = !isChecked;
                      setState(() {});
                    })
              ],
            ),
            if (_isLoading)
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
        subWidget: socialLoginWidget(context,
            title1: "Bạn chưa có tài khoản? ",
            title2: "Đăng ký ngay", callBack: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/sign-up', (route) => false);
        }),
      ),
    );
  }
}
