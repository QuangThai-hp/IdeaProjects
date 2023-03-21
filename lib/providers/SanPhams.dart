import 'dart:convert';
import 'dart:io';

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

  Future<void> save(Map<String, dynamic> sanPham, String routeAfterSave, BuildContext context) async {
    print(RFSaveSanPham);
    try
    {
      final response = await http.post(
          Uri.parse(RFSaveSanPham),
          body: json.encode({
            'uid': uid,
            'auth': authToken,
            'sanPham': sanPham
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
        rfHomeScreenFragment.selectedIndex = 0;
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

  Future<void> getListNhuCau(int khachHangID) async{
    // try
    {
      // ncscs
      final response = await http.post(
          Uri.parse(RFGetListNhuCauByKhachHang),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            "khachHangID": khachHangID
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(khachHangID);
      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<SanPham> loaded = [];
      extractedData.forEach((element) {
        loaded.add(SanPham(
          nid: element['nid'],
          title: element['title'],
          field_trang_thai_nhu_cau: element['field_trang_thai_nhu_cau'],
        ));
      });
      _items = loaded;
      notifyListeners();
    }
  }

}
