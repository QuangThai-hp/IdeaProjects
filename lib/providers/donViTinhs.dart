import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'DonViTinh.dart';

class DonViTinhs with ChangeNotifier {
  late List<DonViTinh> _items = [];
  final String authToken;
  final int uid;

  DonViTinhs(this.authToken, this.uid, this._items);
  List<DonViTinh> get items{
    return [..._items];
  }
  DonViTinh findById(int id){
    return _items.firstWhere((element) => element.tid == id);
  }

  Future<void> getListDonViTinh() async{
    try
    {
      final response = await http.post(
          Uri.parse(RFGetDonViTinh),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)); //json.decode(response.body) as Map<String, dynamic>;
      final List<DonViTinh> loadedDonViTinhs = [];
      extractedData.forEach((element) {
        loadedDonViTinhs.add(DonViTinh(
            tid: element['tid'].toString().toInt(),
            name: element['name'],
        ));
      });
      _items = loadedDonViTinhs;
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

}
