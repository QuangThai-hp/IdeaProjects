import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'Profile.dart';

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
    if(!jsonDecode(response.body)['success'])
      throw HttpException(jsonDecode(response.body)['user']);

    print(jsonDecode(response.body));
    _profile = new Profile(
      uid: jsonDecode(response.body)['user']['uid'],
      name: jsonDecode(response.body)['user']['name'],
      mail: jsonDecode(response.body)['user']['mail'],
      field_ho_ten: jsonDecode(response.body)['user']['field_ho_ten'],
      field_dien_thoai: jsonDecode(response.body)['user']['field_dien_thoai'],
      field_dia_chi: jsonDecode(response.body)['user']['field_dia_chi'],
      field_ngay_sinh: jsonDecode(response.body)['user']['field_ngay_sinh'],
    );
    notifyListeners();
  }

  Future<void> editProfile(String? uid,String? mail,String? field_ho_ten,String? field_dia_chi,String? field_ngay_sinh, String? field_dien_thoai) async {
    // try
    {
      // ncscs
      final response = await http.put(Uri.parse(RFProfile),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'uid': uid,
            'mail': mail,
            'field_ho_ten': field_ho_ten,
            'field_dia_chi': field_dia_chi,
            'field_dien_thoai': field_dien_thoai,
            'field_ngay_sinh': field_ngay_sinh,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      print(response.body);
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
}
