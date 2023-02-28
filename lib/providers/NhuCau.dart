import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class NhuCau with ChangeNotifier {
  String? nid;
  final String? hoTen;
  final String? field_dien_thoai;
  final String? title;
  final String? field_dien_tich;
  final String? field_gia;
  final String? field_huong;
  final String? field_phuong_xa;
  final String? field_quan_huyen;
  final String? field_nhom_nhu_cau;
  final String? field_anh_san_pham;

  NhuCau({
    this.nid = '',
    this.hoTen,
    this.field_dien_thoai,
    this.title,
    this.field_dien_tich,
    this.field_gia,
    this.field_huong,
     this.field_phuong_xa,
     this.field_quan_huyen,
     this.field_nhom_nhu_cau,
     this.field_anh_san_pham,


  });
}
