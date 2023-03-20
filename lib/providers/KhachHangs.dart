import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'KhachHangChuNha.dart';

class KhachHangs with ChangeNotifier {
  List<KhachHang> _items = [];
  final String? authToken;
  final String? uid;
  late int _start;

  int get start => _start;

  set start(int value) {
    _start = value;
  }

  KhachHangs(this.authToken, this.uid, this._items, this._start);
  List<KhachHang> get items {
    return [..._items];
  }

  KhachHang findById(int id) {
    return _items.firstWhere((element) => element.nid == id);
  }

  Future<void> getListKhachHang(int start, int limit,String? name, String? phone) async {
    // try
    {
      final response = await http.post(Uri.parse(RFGetKhachHang),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'start': start,
            'length': limit,
            'name': name,
            'phone':phone
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      _start =
          jsonDecode(response.body)['startBtn'].toString().toDouble().toInt();
      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(
          jsonDecode(response.body)[
              'content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<KhachHang> loadedKhachHangs = [];
      extractedData.forEach((element) {
        loadedKhachHangs.add(KhachHang(
          nid: element['nid'],
          hoTen: element['hoTen'],
          field_dien_thoai: element['field_dien_thoai'],
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



  Future<void> editKhachHang(
      String? nid, String? title, String? field_dien_thoai) async {
    // try
    {
      // ncscs
      final response = await http.put(Uri.parse(RFSuaKhachHang),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'nid': nid,
            'title': title,
            'field_dien_thoai': field_dien_thoai
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          });
      print(response.body);
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
}
