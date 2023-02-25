import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';

import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import '../components/RFConformationDialog.dart';
import '../fragment/RFSearchFragment.dart';
import 'package:room_finder_flutter/providers/them.dart';
import 'customer.dart';

class ThemCaNhans with ChangeNotifier {
  late List<ThemCaNhan> _items = [];
  final String authToken;
  final String uid;

  ThemCaNhans(this.authToken, this.uid, this._items);

  List<ThemCaNhan> get items{
    return [..._items];
  }




  Future<void> save(


   String title_ca_nhan,
  String field_dien_thoai,
   String title_san_pham,
   String field_nguon_khach,
   String field_chi_nhanh_khach_hang,
   String field_sale,
   String field_phan_loai_nha_cho_thue,
      String field_nhom_nhu_cau,
   String field_nhom_san_pham,
   String field_loai_hinh_san_pham,
   String field_quan_huyen,
   String field_phuong_xa,
   String field_duong_pho,
   String field_dia_chi,
   String field_huong,
   String field_phap_ly,
   String field_tinh_trang_noi_that,
   String field_chieu_dai,
   String field_chieu_rong,
   String field_dien_tich,
   String field_dien_tich_su_dung,
    String field_so_tang,
   String field_so_can,
   String field_duong,
   String field_so_phong_ngu,
   String field_so_phong_ve_sinh,
  String field_so_tien_coc,
   String field_don_vi_tinh,
   String field_loai_hoa_hong,
   String field_ghi_chu,
   String field_link_video,
   String field_hoa_hong,
      String field_gia,

      BuildContext context
    )
  async {
    try
    {
      final response = await http.post(
          Uri.parse(RFSaveCaNhan),
          body: json.encode({
            'uid': uid,
            'auth': authToken,


            'title_ca_nhan': title_ca_nhan,
            'field_dien_thoai': field_dien_thoai,
            'title_san_pham': title_san_pham,
            'field_nguon_khach':field_nguon_khach,
            'field_chi_nhanh_khach_hang':field_chi_nhanh_khach_hang,
            'field_sale':field_sale,
            'field_phan_loai_nha_cho_thue':field_phan_loai_nha_cho_thue,
            'field_nhom_nhu_cau': field_nhom_nhu_cau,
            'field_nhom_san_pham':field_nhom_san_pham,
            'field_loai_hinh_san_pham':field_loai_hinh_san_pham,
            'field_quan_huyen':field_quan_huyen,
            'field_phuong_xa':field_phuong_xa,
            'field_duong_pho':field_duong_pho,
            'field_dia_chi':field_dia_chi,
            'field_huong':field_huong,
            'field_phap_ly':field_phap_ly,
            'field_tinh_trang_noi_that':field_tinh_trang_noi_that,
            'field_chieu_dai':field_chieu_dai,
            'field_chieu_rong':field_chieu_rong,
            'field_dien_tich_su_dung':field_dien_tich_su_dung,
            'field_so_tang':field_so_tang,
            'field_so_can':field_so_can,
            'field_duong':field_duong,
            'field_so_phong_ngu':field_so_phong_ngu,
            'field_so_phong_ve_sinh':field_so_phong_ve_sinh,
            'field_so_tien_coc':field_so_tien_coc,
            'field_don_vi_tinh':field_don_vi_tinh,
            'field_loai_hoa_hong':field_loai_hoa_hong,
            'field_ghi_chu':field_ghi_chu,
            'field_link_video':field_link_video,
            'field_hoa_hong':field_hoa_hong,
            'field_gia':field_gia,

          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );
      final responseData = json.decode(response.body);

      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
        RFHomeScreen rfHomeScreenFragment = new RFHomeScreen();
        rfHomeScreenFragment.selectedIndex = 1;
        rfHomeScreenFragment.contentAlert = responseData['content'];
        rfHomeScreenFragment.showDialog = true;
        rfHomeScreenFragment.launch(context);
      }
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }


}
