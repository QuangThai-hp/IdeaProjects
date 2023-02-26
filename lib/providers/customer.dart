import 'package:flutter/cupertino.dart';

class Customer with ChangeNotifier {
  String? nid;
  final String hoTen;
  final String field_dien_thoai;
  final String field_dia_chi;
  final String field_trang_thai;

  Customer({
    this.nid = '',
    required this.hoTen,
    required this.field_dien_thoai,
    required this.field_dia_chi,
    required this.field_trang_thai,
  });
}
