import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class NhuCau with ChangeNotifier {
  String? nid;
  final String title;
  final String created;
  final String? field_sale;
  final String? field_don_vi_tinh;
  final String? field_dia_chi;
  final String? field_dien_tich;
  final String? field_so_tang;

  final String? field_gia;
  final String? field_huong;
  final String? field_chu_nha;
  final String? field_phuong_xa;
  final String? field_quan_huyen;
  final String? field_dien_thoai;


  NhuCau({
    this.nid = '',
    required this.title,
    required this.created,
    this.field_sale,
     this.field_don_vi_tinh,
     this.field_dia_chi,
     this.field_dien_tich,
     this.field_so_tang,

    this.field_gia,
     this.field_huong,
     this.field_chu_nha,
     this.field_phuong_xa,
     this.field_quan_huyen,
     this.field_dien_thoai,

  });
}
