import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import '../components/RFCongratulatedDialog.dart';
import 'KhuVuc.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart' as RFWidget;

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

  Future<void> getListKhuVuc(String type, int? parentId, BuildContext context) async{
    try
    {
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

      if(!jsonDecode(response.body)['success'])
        throw HttpException(jsonDecode(response.body)['content']);

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;

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
    }
    on HttpException catch(error) {
      RFWidget.showErrorDialog(error.message, context);
    }
    catch(error){
      throw error;
    }
  }

  Future<void> getListPhuongXaByNameQuan(String nameQuan, BuildContext context) async{
    try
    {
      final response = await http.post(
          Uri.parse(RFGetKhuVuc),
          body: json.encode({
            'type': 'Phường xã',
            'uid': this.uid,
            'auth': this.authToken,
            'nameQuan': nameQuan,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      if(!jsonDecode(response.body)['success'])
        throw HttpException(jsonDecode(response.body)['content']);

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<KhuVuc> loadedKhuVucs = [];
      extractedData.forEach((element) {
        loadedKhuVucs.add(KhuVuc(
            tid: element['tid'].toString().toInt(),
            name: element['name'],
        ));
      });
      _items = loadedKhuVucs;
      notifyListeners();
    }
    on HttpException catch(error){
      RFWidget.showErrorDialog(error.message, context);
    }catch (error){
      print(error);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog();
      // });
      RFWidget.showErrorDialog(error.toString(), context);
    }
  }

}
