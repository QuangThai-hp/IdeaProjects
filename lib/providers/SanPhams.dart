import 'dart:convert';

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

      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<SanPham> loadedSanPhams = [];
      extractedData.forEach((element) {
        loadedSanPhams.add(SanPham(
            nid: element['nid'],
            title: element['title'],
            field_dia_chi: element['field_dia_chi'],
            field_so_tang: element['field_so_tang'].toString().toDouble(),
            field_duong: element['field_duong'],
            field_huong: element['field_huong'],
            field_gia: element['field_gia'].toString().toDouble(),
            field_don_vi_tinh: element['field_don_vi_tinh'],
            field_sale: element['field_sale'].toString().toInt(),
            // field_phan_loai_nhom_san_pham: element['field_phan_loai_nhom_san_pham'],
            // field_dien_tich: element['field_dien_tich'].toString().toDouble(),
        ));
      });
      _items = loadedSanPhams;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  Future<void> save(
      String nid,
      String field_ngay_dinh_duong,
      String tenBuaAn,
      List<String> nameThucPhams,
      List<double> soLuongThucPhams,
      BuildContext context
      )
  async {
    try
    {
      final response = await http.post(
          Uri.parse(RFSaveSanPhamChoThue),
          body: json.encode({
            'uid': uid,
            'auth': authToken,
            'nid': nid,
            'field_ngay_dinh_duong': field_ngay_dinh_duong,
            'tenBuaAn': tenBuaAn,
            'nameThucPhams': jsonEncode(nameThucPhams),
            'soLuongThucPhams': jsonEncode(soLuongThucPhams)
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
