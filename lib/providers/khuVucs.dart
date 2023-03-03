import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'KhuVuc.dart';

class KhuVucs with ChangeNotifier {
  late List<KhuVuc> _items = [];
  final String authToken;
  final int uid;

  KhuVucs(this.authToken, this.uid, this._items);
  List<KhuVuc> get items{
    return [..._items];
  }
  KhuVuc findById(int id){
    return _items.firstWhere((element) => element.tid == id);
  }

  Future<void> getListKhuVuc(String type, int? parentId) async{
    print(type);
    print(parentId);
    // try
    // {
      final response = await http.post(
          Uri.parse(RFGetKhuVuc),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'type': type,
            'parentID': parentId
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)); //json.decode(response.body) as Map<String, dynamic>;
      final List<KhuVuc> loadedKhuVucs = [];
      extractedData.forEach((element) {
        loadedKhuVucs.add(KhuVuc(
            tid: element['tid'].toString().toInt(),
            name: element['name'],
        ));
      });
      _items = loadedKhuVucs;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    // }
    // catch(error){
    //   throw error;
    // }
  }

}
