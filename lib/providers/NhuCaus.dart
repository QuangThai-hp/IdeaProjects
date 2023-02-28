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
          Uri.parse(RFGetNhuCauByPhanLoai),
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

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<NhuCau> loadedNhuCaus = [];


      extractedData.forEach((element) {

        loadedNhuCaus.add(NhuCau(
          nid: element['nid'],
          hoTen: element['hoTen'],
          field_dien_thoai: element['field_dien_thoai'],
          title: element['title'],
          field_gia: element['field_gia'],
          field_dien_tich: element['field_dien_tich'],
          field_huong: element['field_huong'],
          field_quan_huyen: element['field_quan_huyen'],
          field_phuong_xa: element['field_phuong_xa'],
          field_nhom_nhu_cau: element['field_nhom_nhu_cau'],
          field_anh_san_pham: element['field_anh_san_pham'],


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
