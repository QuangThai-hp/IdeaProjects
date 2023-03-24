import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/providers/donViTinhs.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';
import 'package:room_finder_flutter/widgets/ImageVideoUpload.dart';
import '../components/RFCongratulatedDialog.dart';
import '../providers/Profile.dart';
import '../providers/Profiles.dart';
import '../providers/SanPham.dart';
import '../providers/khuVucs.dart';
import '../utils/RFImages.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart' as RFWidget;
import 'package:intl/intl.dart' as intl;

class RFThongTinCaNhan extends StatefulWidget {
  String? email ;
  RFThongTinCaNhan({this.email});
  @override
  _RFThongTinCaNhan createState() => _RFThongTinCaNhan();
}

class _RFThongTinCaNhan extends State<RFThongTinCaNhan> {
  String? email = '123124124';
  String? nameUser = '';
  String? phone;
  String? diaChi = '';
  bool load = false;

  Future<void> _loadProfile(BuildContext context) async{
    Profiles provider = Provider.of<Profiles>(context, listen: false);
    print('asd');
    provider.getProfile().then((value){
      if (this.mounted) {
        setState(() {
          widget.email = provider.ProFiless.mail;
          nameUser = provider.ProFiless.name;
          phone = provider.ProFiless.field_dien_thoai;
          diaChi = provider.ProFiless.field_dia_chi;
          load == true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final profileImg =  Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // width: 100,
      // height: 100,
      decoration: boxDecorationWithRoundedCorners(
          boxShape: BoxShape.circle,
          border: Border.all(color: white, width: 4)),
      child: rfCommonCachedNetworkImage(rf_user,
          fit: BoxFit.cover,
          width: 125,
          height: 125,
          radius: 150
      ),
    );
    final profileContent = Container(
      margin: EdgeInsets.only(top: 64.0),
      decoration: boxDecoration(bgColor: context.scaffoldBackgroundColor, radius: 10, showShadow: true),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            16.height,
            // Text('Ho ten: ${nameUser}', style: boldTextStyle(size: 18)),
            Text('Email: ${widget.email}',
              style: TextStyle(color: color_primary_black, fontSize: 14),),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(height: 1),
            ),
          ],
        ),
      ),
    );

    if(load == false){
      _loadProfile(context);
    }
    return load==false ? Center(
      child: CircularProgressIndicator(),
    )
        :
    Scaffold(
      appBar: AppBar(
            title: Text('Thông tin cá nhân', style: boldTextStyle(color: appStore.textPrimaryColor)),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.edit, color: appStore.isDarkModeOn ? white : rf_primaryColor, size: 20),
              ),
            ],
          ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 32, left: 2, right: 2),
        child: Container(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Stack(
                    children: <Widget>[profileContent, profileImg],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: boxDecoration(bgColor: context.scaffoldBackgroundColor, radius: 10, showShadow: true),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          8.height,
                          Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                  'Thông tin',style: boldTextStyle(size: 16)
                              ),
                            ],
                          ),
                          16.height,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 44,
                                  ),

                                  // Text('hoTen: ${diaChi}',
                                  //   style: TextStyle(color: color_primary_black, fontSize: 16),
                                  // ),
                                ],
                              ),
                              24.height,
                              Row(
                                children: [
                                  SizedBox(
                                    width: 44,
                                  ),
                                  Text(
                                    'Email: ${widget.email}',
                                    style: TextStyle(
                                        color: color_primary_black, fontSize: 16),
                                  ),
                                ],
                              ),
                              24.height,
                              Row(
                                children: [
                                  SizedBox(
                                    width: 44,
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: color_primary_black, fontSize: 16),
                                  ),
                                ],
                              ),
                              8.height,
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: boxDecoration(bgColor: context.scaffoldBackgroundColor, radius: 10, showShadow: true),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        8.height,
                        Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                'Liên hệ',style: boldTextStyle(size: 16)
                            ),
                          ],
                        ),
                        16.height,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 44,
                                ),
                                Text('',
                                  style: TextStyle(color: color_primary_black, fontSize: 16),
                                ),
                              ],
                            ),
                            16.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: 44,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: color_primary_black, fontSize: 16),
                                ),
                              ],
                            ),
                            16.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: 44,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: color_primary_black, fontSize: 16),
                                ),
                              ],
                            ),
                            16.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: 44,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: color_primary_black, fontSize: 16),
                                ),
                              ],
                            ),
                            16.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: 44,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: color_primary_black, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                ]
            ),
          ),
      ),
    // ),
    // ]
    );
  }
}
