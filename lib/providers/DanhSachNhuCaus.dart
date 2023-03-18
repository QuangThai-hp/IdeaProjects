import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'DanhSachNhuCau.dart';

class DanhSachNhuCaus with ChangeNotifier {
  late List<DanhSachNhuCau> _items = [];
  final String authToken;
  final int uid;

  DanhSachNhuCaus(this.authToken, this.uid, this._items);
  List<DanhSachNhuCau> get items{
    return [..._items];
  }
  DanhSachNhuCau findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }

  Future<void> getListDanhSachNhuCau( String? idKhachHang) async{
    try
    {
      final response = await http.post(
          Uri.parse(RFDanhSachNhuCau),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,

            'idKhachHang': idKhachHang
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)); //json.decode(response.body) as Map<String, dynamic>;
      final List<DanhSachNhuCau> loadedDanhSachNhuCaus = [];
      extractedData.forEach((element) {
        loadedDanhSachNhuCaus.add(DanhSachNhuCau(
          nid: element['nid'],
          title: element['title'],
          field_nhom_nhu_cau: element['field_nhom_nhu_cau'],
          field_trang_thai_nhu_cau: element['field_trang_thai_nhu_cau'],
        ));
      });
      _items = loadedDanhSachNhuCaus;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

}
