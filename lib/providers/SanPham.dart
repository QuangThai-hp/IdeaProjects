import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';

class SanPham with ChangeNotifier {
  String? nid;
  final String? hoTen;
  final String? title;
  final String? field_dia_chi;
  final double? field_so_tang;
  final String? field_duong;
  final String? field_huong;
  final String? field_phuong_xa;
  final String? field_quan_huyen;
  final double? field_gia;
  final double? field_gia_bang_so;
  final String? field_don_vi_tinh;
  final int? field_sale;
  final String? field_phap_ly;
  final String? field_phan_loai_nhom_san_pham;
  final double? field_dien_tich;
  final String? field_nhom_nhu_cau;
  final String? field_ngay_nhap;
  final String? field_ghi_chu;
  final String? field_dien_thoai;
  // Thuộc tính sp cho thuê
  final String? field_tinh_trang_noi_that;
  final double? field_so_tien_coc;
  final double? field_dien_tich_su_dung;
  final double? field_chieu_dai;
  final double? field_chieu_rong;
  final int? field_so_phong_ve_sinh;
  final int? field_so_phong_ngu;
  late List<String>? field_anh_san_pham = [];

  final KhachHangChuNha? khachHangChuNha;

  SanPham({
    this.nid = '',
    this.hoTen,
    this.title,
    this.field_dia_chi,
    this.field_so_tang,
    this.field_duong,
    this.field_huong,
    this.field_phuong_xa,
    this.field_quan_huyen,
    this.field_gia,
    this.field_gia_bang_so,
    this.field_don_vi_tinh,
    this.field_sale,
    this.field_phap_ly,
    this.field_phan_loai_nhom_san_pham,
    this.field_dien_tich,
    this.field_nhom_nhu_cau,
    this.field_ngay_nhap,
    this.field_ghi_chu,
    this.field_dien_thoai,
    this.field_tinh_trang_noi_that,
    this.field_so_tien_coc,
    this.field_dien_tich_su_dung,
    this.field_chieu_dai,
    this.field_chieu_rong,
    this.field_so_phong_ve_sinh,
    this.field_so_phong_ngu,
    this.field_anh_san_pham,
    this.khachHangChuNha
  });


}
