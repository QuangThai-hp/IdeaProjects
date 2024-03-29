import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';

import 'package:room_finder_flutter/screens/RFMobileSignInScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

import '../utils/RFImages.dart';
import '../utils/RFWidget.dart';

class RFSplashScreen extends StatefulWidget {
  @override
  _RFSplashScreenState createState() => _RFSplashScreenState();
}

class _RFSplashScreenState extends State<RFSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);

    await Future.delayed(Duration(seconds: 2));
    finish(context);
    RFEmailSignInScreen().launch(context);
  }

  @override
  void dispose() {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);

    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rf_primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 80),
            width: 200,
            height: 200,
            decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, border: Border.all(color: white, width: 4)),
            child: rfCommonCachedNetworkImage(rf_logo_happyhome, fit: BoxFit.cover, width: 200, height: 200, radius: 150),
          ),
        ],
      ).center(),
    );
  }
}
