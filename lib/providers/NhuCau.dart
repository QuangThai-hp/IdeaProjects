import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class NhuCau with ChangeNotifier {
  String? nid;
  final String title;
  final String created;
  final String field_loai_nhu_cau;
  final String field_khoang_dien_tich;
  final String field_khoang_gia;
  final String field_ghi_chu;
  final String field_nhu_cau_huong;

  NhuCau({
    this.nid = '',
    required this.title,
    required this.created,
    required this.field_loai_nhu_cau,
    required this.field_khoang_dien_tich,
    required this.field_khoang_gia,
    required this.field_ghi_chu,
    required this.field_nhu_cau_huong,

  });
}
