import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';

class KhachHang with ChangeNotifier {
  String? nid;

  final String? hoTen;
  final String? field_dien_thoai;





  KhachHang({
    this.nid = '',
    this.hoTen,
    this.field_dien_thoai,

  });


}
