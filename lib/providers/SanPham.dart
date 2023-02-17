import 'package:flutter/cupertino.dart';

class SanPham with ChangeNotifier {
  String? nid;
  final String title;
  final String field_dia_chi;
  final String field_so_tang;
  final String field_duong;
  final String field_huong;
  final String field_gia;
  final String field_image;

  SanPham({
    this.nid = '',
    required this.title,
    required this.field_dia_chi,
    required this.field_so_tang,
    required this.field_duong,
    required this.field_huong,
    required this.field_gia,
    required this.field_image
  });
}
