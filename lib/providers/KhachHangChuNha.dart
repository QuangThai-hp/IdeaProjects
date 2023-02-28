import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../utils/RFString.dart';

class KhachHangChuNha with ChangeNotifier {
  String? uid;
  String? authToken;
  final String? hoTen;
  final String? dienThoai;
  final String? ghiChu;

  KhachHangChuNha({
    this.uid,
    this.hoTen,
    this.dienThoai,
    this.ghiChu
  });

  Future<void> getListNhuCau() async{
    // try
    {

      // ncscs
      final response = await http.post(
          Uri.parse(RFGetListNhuCauByKhachHang),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            "khachHangID": this.uid
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
