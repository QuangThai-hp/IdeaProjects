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
      final extectedContextData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['context']);
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['nhu_cau']); //json.decode(response.body) as Map<String, dynamic>;
      final List<NhuCau> loadedNhuCaus = [];
      final List<NhuCau> loadedczzontext = [];

      extractedData.forEach((element) {

        loadedNhuCaus.add(NhuCau(
          nid: element['nid'],
          created: element['created'],
          title: element['title'],
          field_sale: element['field_sale'],
          field_don_vi_tinh: element['field_don_vi_tinh'],
          field_dia_chi: element['field_dia_chi'],
          field_dien_tich: element['field_dien_tich'],
          field_so_tang: element['field_so_tang'],
          field_gia: element['field_gia'],
          field_huong: element['field_huong'],
          field_chu_nha: element['field_chu_nha'],
          field_phuong_xa: element['field_phuong_xa'],
          field_quan_huyen: element['field_quan_huyen'],
          field_dien_thoai: element['field_dien_thoai'],

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
