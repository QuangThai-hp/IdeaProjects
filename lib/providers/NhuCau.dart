import 'package:flutter/cupertino.dart';

class NhuCau with ChangeNotifier {
  String? nid;
  final String? title;
  final String? field_nhom_nhu_cau;
  final String? field_trang_thai_nhu_cau;

  NhuCau({
    this.nid = '',
    this.title,
    this.field_nhom_nhu_cau,
    this.field_trang_thai_nhu_cau,
  });
}
