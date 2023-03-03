import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'SanPham.dart';

class NhuCaus with ChangeNotifier {
  late List<NhuCau> _items = [];
  final String authToken;
  final String uid;
  late NhuCau _nhuCau = NhuCau();

  set nhuCau(NhuCau value) {
    _nhuCau = value;
  }

  set items(List<NhuCau> value) {
    _items = value;
  }

  NhuCau get nhuCau => _nhuCau;

  NhuCaus(this.authToken, this.uid, this._items);
  List<NhuCau> get items{
    return [..._items];
  }

  Future<void> getNhuCauByNid(int nid) async{
    final response = await http.post(
        Uri.parse(RFGetThongTinNhuCau),
        body: json.encode({
          'uid': this.uid,
          'auth': this.authToken,
          'nid': nid
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        }
    );
    _nhuCau = new NhuCau(
      nid: jsonDecode(response.body)['nid'],
      title: jsonDecode(response.body)['title'],
      khachHangChuNha: KhachHangChuNha(
        hoTen: jsonDecode(response.body)['KhachHangChuNha']['hoTen'],
        dienThoai: jsonDecode(response.body)['KhachHangChuNha']['dienThoai'],
      ),
    );
    //json.decode(response.body) as Map<String, dynamic>;
    notifyListeners();
  }

  Future<void> getListNhuCau(String? type) async{
    print(type);
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetNhuCauByPhanLoai),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'type':type == 'Tất cả' ? null : type,
            'trangThai': type != 'Huỷ' ? null : type
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(jsonDecode(response.body));

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<NhuCau> loadedNhuCaus = [];
      final String canMuaUrlImage = 'https://happyhomehaiphong.com/images/da-luu/can-mua.png';
      final String canThueUrlImage = 'https://happyhomehaiphong.com/images/da-luu/can-thue.png';
      final String noImageUrl = 'https://happyhomehaiphong.com/images/da-luu/no-image.png';

      extractedData.forEach((element) {

        loadedNhuCaus.add(NhuCau(
          nid: element['nid'],


          field_dien_thoai: element['field_dien_thoai'],
          title: element['title'],
          field_gia: element['field_gia'].toString().toDouble(),
          field_dien_tich: element['field_dien_tich'].toString().toDouble(),
          field_huong: element['field_huong'],
          field_quan_huyen: element['field_quan_huyen'],
          field_phuong_xa: element['field_phuong_xa'],
          field_nhom_nhu_cau: element['field_nhom_nhu_cau'],
          field_don_vi_tinh: element['field_don_vi_tinh'].toString(),
          field_trang_thai_nhu_cau: element['field_trang_thai_nhu_cau'].toString(),
          field_anh_san_pham: (element['field_nhom_nhu_cau'] == 'Cần mua' ? canMuaUrlImage : (element['field_nhom_nhu_cau'] == 'Cần thuê' ? canThueUrlImage : (element['field_anh_san_pham'] == '' ? noImageUrl : element['field_anh_san_pham']))),
        ));

      });
      _items = loadedNhuCaus;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

}
