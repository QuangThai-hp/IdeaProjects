import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class KhachHang with ChangeNotifier {
  String? nid;
  final String hoTen;
  final String field_dien_thoai;
  final String field_dia_chi;
  final String field_trang_thai;
  final String field_ghi_chu;


  KhachHang({
    this.nid = '',
    required this.hoTen,
    required this.field_dien_thoai,
  required this.field_dia_chi,
    required this.field_trang_thai,
    required this.field_ghi_chu,
  });
}
