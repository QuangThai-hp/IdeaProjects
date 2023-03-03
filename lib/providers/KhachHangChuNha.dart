import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../utils/RFString.dart';

class KhachHangChuNha with ChangeNotifier {
  String? nid;
  final String hoTen;
  final String dienThoai;
  final String? ghiChu;

  KhachHangChuNha({
    this.nid,
    this.hoTen='',
    this.dienThoai = '',
    this.ghiChu
  });


}
