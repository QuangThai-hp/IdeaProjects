import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/screens/RFResetPasswordScreen.dart';
import 'package:room_finder_flutter/screens/RFSignUpScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/codePicker/country_code_picker.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/auth.dart';

enum AuthMode { Signup, Login }

class RFMobileSignIn extends StatefulWidget {
  @override
  _RFMobileSignInState createState() => _RFMobileSignInState();
}

class _RFMobileSignInState extends State<RFMobileSignIn> {
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': ''
  };

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    changeStatusColor(appStore.scaffoldBackground!);
    super.dispose();
  }

  void _showErrorDialog(String message){
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Thông báo'),
      content: Text(message),
      actions: <Widget>[
        TextButton(onPressed: (){
          Navigator.of(ctx).pop();
        }, child: Text('Đóng lại'))
      ],
    ));
  }

  Future<void> _submit() async{
    setState(() {
      _isLoading = true;
    });

    try{
      if(_authMode == AuthMode.Login){
        await Provider.of<Auth>(context, listen: false).login(
            _authData['email']!,
            _authData['password']!
        );
      }

      Navigator.of(context).pushReplacementNamed('/products-overview');

    } on HttpException catch(error){
      _showErrorDialog(error.message);
    } catch (error){
      print(error);
      _showErrorDialog('Could not authentication you. Please again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RFCommonAppComponent(
          title: RFAppName,
          subTitle: RFAppSubTitle,
          cardWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Đăng nhập', style: boldTextStyle(size: 18)),
              16.height,
              Text(
                'Vui lòng nhập số điện thoại. Chúng tôi sẽ gửi cho bạn mã code gồm 4 ký tự để xác thực đăng nhập.',
                style: primaryTextStyle(),
                maxLines: 4,
                textAlign: TextAlign.center,
              ).flexible(),
              16.height,
              Container(
                padding: EdgeInsets.only(left: 15),
                decoration: boxDecoration(showShadow: false, bgColor: context.cardColor, radius: 8, color: context.dividerColor),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CountryCodePicker(onChanged: print, padding: EdgeInsets.all(0), showFlag: true,initialSelection: 'vn',),
                    Container(
                      height: 25.0,
                      width: 1.0,
                      color: context.dividerColor,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Số điện thoại"),
                      onChanged: (value) {},
                    ).expand(),
                  ],
                ),
              ),
              24.height,
              AppButton(
                color: rf_primaryColor,
                child: Text('Gửi mã', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  RFEmailSignInScreen().launch(context);
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    child: Text("Reset Password?", style: primaryTextStyle()),
                    onPressed: () {
                      RFResetPasswordScreen().launch(context);
                    }),
              ),
            ],
          ),
          subWidget: socialLoginWidget(
            context,
            title1: "New Member? ",
            title2: "Sign up Here",
            callBack: () {
              RFSignUpScreen().launch(context);
            },
          ),
        ),
      ),
    );
  }
}
