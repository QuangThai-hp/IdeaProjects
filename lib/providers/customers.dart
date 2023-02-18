import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'customer.dart';

class Customers with ChangeNotifier {
  late List<Customer> _items = [];
  final String authToken;

  Customers(this.authToken, this._items);
  List<Customer> get items{
    return [..._items];
  }
  Customer findById(int id){
    return _items.firstWhere((element) => element.nid == id);
  }

  Future<void> getListCustomerWithStatus(String status) async{
    try{
      final response = await http.post(
          Uri.parse(RFGetCustomerWithStatus),
          body: json.encode({
            'status': status,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)); //json.decode(response.body) as Map<String, dynamic>;
      final List<Customer> loadedCustomers = [];
      extractedData.forEach((element) {
        loadedCustomers.add(Customer(
            nid: element['nid'],
            hoTen: element['hoTen'],
            field_dien_thoai: element['dienThoai'],
            field_dia_chi: element['field_dia_chi'],
            field_trang_thai: element['field_trang_thai'],
            field_nhu_cau_khoang_gia: element['field_nhu_cau_khoang_gia'],
            field_nhu_cau_dien_tich: element['field_nhu_cau_dien_tich']
        ));
      });
      _items = loadedCustomers;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

}
