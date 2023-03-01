import 'package:flutter/cupertino.dart';
import 'SanPham.dart';

class KhachHang with ChangeNotifier {
  String? nid;
  final String? hoTen;
  final String? field_dien_thoai;
  final String? field_dia_chi;
  final String? field_trang_thai;
  final String? field_ghi_chu;
  List<SanPham> sanPham = []; // nhu cầu của mỗi khách hàng


  KhachHang({
    this.nid = '',
    this.hoTen,
    this.field_dien_thoai,
    this.field_dia_chi,
    this.field_trang_thai,
    this.field_ghi_chu,
  });
}
