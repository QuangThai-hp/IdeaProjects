import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/utils/RFString.dart';



class KhachHangs with ChangeNotifier {
  late List<KhachHang> _items = [];
  final String authToken;
  final String uid;

  KhachHangs(this.authToken, this.uid, this._items);
  List<KhachHang> get items{
    return [..._items];
  }
  KhachHang findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }

  // Lấy danh sách sản phẩm theo loại (Mua bán / Cho thuê)
  Future<void> getListKhachHang() async{
    // try
    {

      // ncscs
      final response = await http.post(
          Uri.parse(RFGetKhachHang),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<KhachHang> loadedKhachHangs = [];
      extractedData.forEach((element) {
        loadedKhachHangs.add(KhachHang(
          nid: element['nid'],
          hoTen: element['hoTen'],
          field_dien_thoai: element['field_dien_thoai'],
          field_dia_chi: element['field_dia_chi'],
          field_trang_thai: element['field_trang_thai'],
          field_ghi_chu: element['field_ghi_chu']

        ));
      });
      _items = loadedKhachHangs;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

}
