import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import '../screens/RFHomeScreen.dart';
import 'KhachHang.dart';

class KhachHangs with ChangeNotifier {
  late List<KhachHang> _items = [];
  final String authToken;
  final int uid;

  KhachHangs(this.authToken, this.uid, this._items);
  List<KhachHang> get items{
    return [..._items];
  }
  KhachHang findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }

  Future<void> getListKhachHang() async{
    try
    {
      final response = await http.post(
          Uri.parse(RFGetCustomerWithStatus),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,

          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<KhachHang> loadedKhachHangs = [];
      extractedData.forEach((element) {

          loadedKhachHangs.add(KhachHang(
              nid: element['nid'],
              hoTen: element['hoTen'],
              field_dien_thoai: element['field_dien_thoai']

              // field_phan_loai_nhom_san_pham: element['field_phan_loai_nhom_san_pham'],
              // field_dien_tich: element['field_dien_tich'].toString().toDouble(),
          ));

      });//
      _items = loadedKhachHangs;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }



}
