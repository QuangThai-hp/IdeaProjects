import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';

import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import '../components/RFConformationDialog.dart';
import '../fragment/RFSearchFragment.dart';
import 'package:room_finder_flutter/providers/them.dart';
import 'customer.dart';

class ThemCaNhans with ChangeNotifier {
  late List<ThemCaNhan> _items = [];
  final String authToken;
  final String uid;

  ThemCaNhans(this.authToken, this.uid, this._items);

  List<ThemCaNhan> get items{
    return [..._items];
  }




  Future<void> save(

      String field_nhom_nhu_cau,
      String title_ca_nhan,
      String field_dien_thoai,
      String title_san_pham,

      BuildContext context
    )
  async {
    try
    {
      final response = await http.post(
          Uri.parse(RFSaveCaNhan),
          body: json.encode({
            'uid': uid,
            'auth': authToken,

            'field_nhom_nhu_cau': field_nhom_nhu_cau,
            'title_ca_nhan': title_ca_nhan,
            'field_dien_thoai': field_dien_thoai,
            'title_san_pham': title_san_pham,
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
        rfHomeScreenFragment.selectedIndex = 1;
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


}
