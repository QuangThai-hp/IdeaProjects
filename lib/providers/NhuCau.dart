import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';

class NhuCau with ChangeNotifier {
  String? nid;
  final String? ngayNhap;
  final String? nhuCau;
  final KhachHangChuNha? khachHangChuNha;
  final String? hoTen;
  final String? field_dien_thoai;
  final String title;
  final double field_dien_tich;
  final double? field_gia;
  final String? field_huong;
  final String? field_phuong_xa;

  final String? field_quan_huyen;
  final String field_nhom_nhu_cau;
  final String field_anh_san_pham;
  final String field_trang_thai_nhu_cau;
  final String field_don_vi_tinh;

  NhuCau({
    this.nid = '',
    this.hoTen,
    this.khachHangChuNha = null,
    this.ngayNhap,
    this.nhuCau,
    this.field_dien_thoai,
    this.title = '',
    this.field_dien_tich = 0,
    this.field_gia,
    this.field_huong,
     this.field_phuong_xa,
     this.field_quan_huyen,
     this.field_nhom_nhu_cau = '',
     this.field_anh_san_pham = '',
    this.field_trang_thai_nhu_cau = '',
    this.field_don_vi_tinh = ''
  });


}
