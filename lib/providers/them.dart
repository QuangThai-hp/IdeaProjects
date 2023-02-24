import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class ThemCaNhan with ChangeNotifier {

  final String field_nhom_nhu_cau;
  final String title_ca_nhan;
  final String? field_dien_thoai;
  final String? title_san_pham;





  ThemCaNhan({

    required this.field_nhom_nhu_cau,
    required this.title_ca_nhan,
    this.field_dien_thoai,
     this.title_san_pham,




  });
}
