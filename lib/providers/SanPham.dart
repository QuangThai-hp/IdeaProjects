import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class SanPham with ChangeNotifier {
  String? nid;
  final String title;
  final String field_dia_chi;
  final double? field_so_tang;
  final String? field_duong;
  final String? field_huong;
  final String? field_phuong_xa;
  final String? field_quan_huyen;
  final double field_gia;
  final String? field_image;
  final String? field_don_vi_tinh;
  final int field_sale;
  final String? field_phan_loai_nhom_san_pham;
  final double? field_dien_tich;

  SanPham({
    this.nid = '',
    required this.title,
    required this.field_dia_chi,
    this.field_so_tang,
    this.field_duong,
    this.field_huong,
    this.field_phuong_xa,
    this.field_quan_huyen,
    required this.field_gia,
    this.field_image,
    required this.field_sale,
    this.field_don_vi_tinh,
    this.field_phan_loai_nhom_san_pham,
    this.field_dien_tich
  });
}
