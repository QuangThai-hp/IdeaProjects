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
import 'package:room_finder_flutter/screens/RFSuaThongTinCaNhan.dart';
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
  @override
  _RFThongTinCaNhan createState() => _RFThongTinCaNhan();
}

class _RFThongTinCaNhan extends State<RFThongTinCaNhan> {
  Profile proFile = Profile();
  bool load = false;

  @override
  void initState() {
    _loadProfile();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadProfile() async{
    Profiles profile = Provider.of<Profiles>(context, listen: false);
    profile.getProfile().then((value){
        setState(() {
          proFile = profile.ProFiless;
          load == true;
        });
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
            Text('Tên đăng nhập: ${proFile.name}', style: boldTextStyle(size: 18)),
            Text('${proFile.mail}',
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
    return Scaffold(
      appBar: AppBar(
            title: Text('Thông tin cá nhân', style: boldTextStyle(color: appStore.textPrimaryColor)),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RFSuaThongTinCaNhan(
                          uid: proFile.uid,
                          email: proFile.mail,
                          name: proFile.field_ho_ten,
                          phone: proFile.field_dien_thoai,
                          diaChi: proFile.field_dia_chi,
                        )));
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
                                  Text('Họ và tên: Thái${proFile.field_ho_ten}',
                                    style: TextStyle(color: color_primary_black, fontSize: 16),
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
                                    'Ngày sinh: ${proFile.field_ngay_sinh}',
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
                                    'Địa chỉ: ${proFile.field_dia_chi}',
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
                                Text('Số điện thoại: ${proFile.field_dien_thoai}',
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
                                  'Email: ${proFile.mail}',
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
