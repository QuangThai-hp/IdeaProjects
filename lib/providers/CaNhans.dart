import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/providers/CaNhan.dart';
import 'SanPham.dart';

class CaNhans with ChangeNotifier {
  late List<CaNhan> _items = [];
  final String authToken;
  final String uid;

  late List<String> _TenLoaiBatDongSan = [];
  List<String> get TenLoaiBatDongSan => _TenLoaiBatDongSan;

  late List<String> _NguonKhach = [];
  List<String> get NguonKhach => _NguonKhach;

  late List<String> _ChiNhanh = [];
  List<String> get ChiNhanh => _ChiNhanh;

  late List<String> _NhomSanPham = [];
  List<String> get NhomSanPham => _NhomSanPham;

  late List<String> _NhomNhuCau = [];
  List<String> get NhomNhuCau => _NhomNhuCau;

  late List<String> _LoaiHinh = [];
  List<String> get LoaiHinh => _LoaiHinh;

  late List<String> _QuanHuyen = [];
  List<String> get QuanHuyen => _QuanHuyen;

  late List<String> _DonViTinh = [];
  List<String> get DonViTinh => _DonViTinh;

  late List<String> _LoaiHoaHong = [];
  List<String> get LoaiHoaHong => _LoaiHoaHong;

  late List<String> _NhanSu = [];
  List<String> get NhanSu => _NhanSu;

  late List<String> _PhuongXa = [];
  List<String> get PhuongXa => _PhuongXa;

  late List<String> _Huong = [];
  List<String> get Huong => _Huong;

  CaNhans(this.authToken, this.uid, this._items);
  List<CaNhan> get items{
    return [..._items];
  }
  CaNhan findById(int id){
    return _items.firstWhere((element) => element.tid == id);
  }


  Future<void> getLoaiBatDongSan() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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

      final List<String> loadedLoaiBatDongSans = [];
      extractedData.forEach((element) {



          loadedLoaiBatDongSans.add('${element['name']}');
      });

      _TenLoaiBatDongSan=loadedLoaiBatDongSans;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }


  Future<void> getNguonKhach() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['nguon_khach']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedNguonKhachs = [];
      extractedData.forEach((element) {


          loadedNguonKhachs.add('${element['name']}');
      });

      _NguonKhach=loadedNguonKhachs;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

  Future<void> getChiNhanh() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['chi_nhanh']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {

        loadedDatas.add('${element['tid']}');
        loadedDatas.add('${element['name']}');

      });

      _ChiNhanh=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getNhomSanPham() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['nhom_san_pham']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _NhomSanPham=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getNhomNhuCau() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['nhom_nhu_cau']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _NhomNhuCau=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getLoaiHinh() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['loai_hinh']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _LoaiHinh=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getQuanHuyen() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['quan_huyen']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _QuanHuyen=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

  Future<void> getDonViTinh() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['don_vi_tinh']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _DonViTinh=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

  Future<void> getLoaiHoaHong() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['loai_hoa_hong']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _LoaiHoaHong=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getNhanSu(String idChiNhanh) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadNhanSu),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'idChiNhanh':idChiNhanh,


          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _NhanSu=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getPhuongxa(String idQuanHuyen) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadPhuongXa),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'idQuanHuyen':idQuanHuyen,


          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print(jsonDecode(response.body));
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _PhuongXa=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }
  Future<void> getHuong() async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadCaNhan),
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
      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['huong']); //json.decode(response.body) as Map<String, dynamic>;

      final List<String> loadedDatas = [];
      extractedData.forEach((element) {


        loadedDatas.add('${element['name']}');
      });

      _Huong=loadedDatas;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

}
