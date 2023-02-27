import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'NhuCau.dart';

class KhuVucs with ChangeNotifier {
  late List<NhuCau> _items = [];
  final String authToken;
  final int uid;

  KhuVucs(this.authToken, this.uid, this._items);
  List<NhuCau> get items{
    return [..._items];
  }
  NhuCau findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }

  Future<void> getListKhuVuc(String? idKhachHang) async{
    // try
    // {
      final response = await http.post(
          Uri.parse(RFGetKhuVuc),
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
      final List<NhuCau> loadedNhuCaus = [];
      extractedData.forEach((element) {
        loadedNhuCaus.add(NhuCau(
            nid: element['tid'],
          title: element['title'],
          field_nhom_nhu_cau: element['field_nhom_nhu_cau'],
          field_trang_thai_nhu_cau: element['field_trang_thai_nhu_cau'],
        ));
      });
      _items = loadedNhuCaus;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    // }
    // catch(error){
    //   throw error;
    // }
  }

}
