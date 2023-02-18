import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class SanPham with ChangeNotifier {
  String? nid;
  final String title;
  final String field_dia_chi;
  final double? field_so_tang;
  final String? field_duong;
  final String? field_huong;
  final double field_gia;
  final String? field_don_vi_tinh;
  final int field_sale;
  final String? field_phan_loai_nhom_san_pham;
  final double? field_dien_tich;
  final String? field_phuong_xa;
  // Thuộc tính sp cho thuê
  final String? field_tinh_trang_noi_that;
  final double? field_so_tien_coc;
  final double? field_dien_tich_su_dung;
  final int? field_so_phong_ve_sinh;
  final int? field_so_phong_ngu;
  final String? field_anh_san_pham;

  SanPham({
    this.nid = '',
    required this.title,
    required this.field_dia_chi,
    this.field_so_tang,
    this.field_duong,
    this.field_huong,
    required this.field_gia,
    this.field_don_vi_tinh,
    required this.field_sale,
    this.field_phan_loai_nhom_san_pham,
    this.field_dien_tich,
    this.field_phuong_xa,
    this.field_tinh_trang_noi_that,
    this.field_so_tien_coc,
    this.field_dien_tich_su_dung,
    this.field_so_phong_ve_sinh,
    this.field_so_phong_ngu,
    this.field_anh_san_pham,
  });
}
