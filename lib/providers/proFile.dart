import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';

class Profile with ChangeNotifier {
  String? uid;
  final String? name;
  final String? mail;
  final String? field_dien_thoai;
  final String? field_dia_chi;

  Profile({
    this.uid = '',
    this.name,
    this.mail,
    this.field_dien_thoai,
    this.field_dia_chi,
  });


}
