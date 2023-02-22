import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'SanPham.dart';

class NhuCaus with ChangeNotifier {
  late List<NhuCau> _items = [];
  final String authToken;
  final String uid;

  NhuCaus(this.authToken, this.uid, this._items);
  List<NhuCau> get items{
    return [..._items];
  }
  NhuCau findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }


  Future<void> getListNhuCau(String type) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetSanPhamByType),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'type':type,

          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['nhu_cau_can_mua']); //json.decode(response.body) as Map<String, dynamic>;
      final List<NhuCau> loadedNhuCaus = [];
      extractedData.forEach((element) {

        loadedNhuCaus.add(NhuCau(
          nid: element['nid'],
          title: element['title'],
          created: element['created'],
          field_loai_nhu_cau: element['field_loai_nhu_cau'],
          field_khoang_dien_tich: element['field_khoang_dien_tich'],
          field_khoang_gia: element['field_khoang_gia'],
          field_ghi_chu: element['field_ghi_chu'],
          field_nhu_cau_huong: element['field_nhu_cau_huong'],

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
