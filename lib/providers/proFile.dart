import 'package:flutter/cupertino.dart';

class proFile with ChangeNotifier {
  String? nid;
  final String? hoTen;
  final String? field_dien_thoai;
  final String? field_dia_chi;
  final String? field_trang_thai;

  proFile({
    this.nid = '',
     this.hoTen,
     this.field_dien_thoai,
    this.field_dia_chi,
     this.field_trang_thai,
  });
}
