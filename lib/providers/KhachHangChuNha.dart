import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class KhachHangChuNha with ChangeNotifier {
  String? uid;
  final String hoTen;
  final String dienThoai;
  final String? ghiChu;

  KhachHangChuNha({
    this.uid = '',
    required this.hoTen,
    required this.dienThoai,
    this.ghiChu
  });
}
