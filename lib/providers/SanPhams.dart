import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import '../screens/RFHomeScreen.dart';
import 'SanPham.dart';

class SanPhams with ChangeNotifier {
  late List<SanPham> _items = [];
  final String authToken;
  final String uid;

  SanPhams(this.authToken, this.uid, this._items);
  List<SanPham> get items{
    return [..._items];
  }
  SanPham findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }

  // Lấy danh sách sản phẩm theo loại (Mua bán / Cho thuê)
  Future<void> getListSanPham(String type) async{
    try
    {
      final response = await http.post(
          Uri.parse(RFGetSanPhamByType),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'type': type,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['nhuCau']); //json.decode(response.body) as Map<String, dynamic>;
      final List<SanPham> loadedSanPhams = [];
      extractedData.forEach((element) {

          // loadedSanPhams.add(SanPham(
          //     nid: element['nid'],
          //
          //     hoTen: element['hoTen'],
          //   field_dien_thoai: element['field_dien_thoai'],
          //
          //   title: element['title'],
          //
          //     field_gia: element['field_gia'].toString().toDouble(),
          //   field_dien_tich: element['field_dien_tich'].toString().toDouble(),
          //   field_huong: element['field_huong'],
          //   field_quan_huyen: element['field_quan_huyen'],
          //   field_phuong_xa: element['field_phuong_xa'],
          //   field_nhom_nhu_cau: element['field_nhom_nhu_cau'],
          //     // field_phan_loai_nhom_san_pham: element['field_phan_loai_nhom_san_pham'],
          //     // field_dien_tich: element['field_dien_tich'].toString().toDouble(),
          // ));

      });//
      _items = loadedSanPhams;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  Future<void> save(Map<String, dynamic> sanPham, String routeAfterSave, BuildContext context) async {
    print(json.encode({
      'uid': uid,
      'auth': authToken,
      'sanPham': sanPham
    }));
    // try
    // {
    //   final response = await http.post(
    //       Uri.parse(RFSaveSanPham),
    //       body: json.encode({
    //         'uid': uid,
    //         'auth': authToken,
    //         'sanPham': sanPham
    //       }),
    //       headers: {
    //         'Content-Type': 'application/json;charset=UTF-8',
    //         'Charset': 'utf-8',
    //       }
    //   );
    //   final responseData = json.decode(response.body);
    //
    //   print(responseData);
    //
    //   if(!responseData['success'])
    //     throw HttpException(responseData['content']);
    //   else{
    //     RFHomeScreen rfHomeScreenFragment = new RFHomeScreen();
    //     rfHomeScreenFragment.selectedIndex = 1;
    //     rfHomeScreenFragment.contentAlert = responseData['content'];
    //     rfHomeScreenFragment.showDialog = true;
    //     rfHomeScreenFragment.launch(context);
    //   }
    //   notifyListeners();
    // }
    // catch(error){
    //   throw error;
    // }
  }

  Future<void> getListNhuCau(int khachHangID) async{
    // try
    {
      // ncscs
      final response = await http.post(
          Uri.parse(RFGetListNhuCauByKhachHang),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            "khachHangID": khachHangID
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(khachHangID);
      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<SanPham> loaded = [];
      extractedData.forEach((element) {
        loaded.add(SanPham(
          nid: element['nid'],
          title: element['title'],
          field_trang_thai_nhu_cau: element['field_trang_thai_nhu_cau'],
        ));
      });
      _items = loaded;
      notifyListeners();
    }
  }

}
