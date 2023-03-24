import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'Profile.dart';
import 'SanPham.dart';

class Profiles with ChangeNotifier {
  final String authToken;
  final int uid;
  late Profile _profile = Profile();


  set ProFiless(Profile value) {
    _profile = value;
  }


  Profile get ProFiless => _profile;

  Profiles(this.authToken, this.uid);

  Future<void> getProfile() async{
    final response = await http.post(
        Uri.parse(RFProfile),
        body: json.encode({
          'uid': this.uid,
          'auth': this.authToken,
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        }
    );
    print(jsonDecode(response.body));
    _profile = new Profile(
      uid: jsonDecode(response.body)['uid'],
      name: jsonDecode(response.body)['name'],
      mail: jsonDecode(response.body)['mail'],
      field_dien_thoai: jsonDecode(response.body)['field_dien_thoai'],
      field_dia_chi: jsonDecode(response.body)['field_dia_chi'],
    );
    notifyListeners();
  }
}
