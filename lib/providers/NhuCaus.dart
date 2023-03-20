import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'SanPham.dart';

class NhuCaus with ChangeNotifier {
  late List<NhuCau> _items = [];
  late List<KhuVuc> _khuVuc = [];
  late List<Map<String, dynamic>> _mucGiaNhaBan = [];
  late List<Map<String, dynamic>> _mucGiaThue = [];
  late List<Map<String, dynamic>> _dienTich = [];

  List<Map<String, dynamic>> get dienTich => _dienTich;

  set dienTich(List<Map<String, dynamic>> value) {
    _dienTich = value;
  }

  List<Map<String, dynamic>> get mucGiaThue => _mucGiaThue;

  set mucGiaThue(List<Map<String, dynamic>> value) {
    _mucGiaThue = value;
  }

  List<Map<String, dynamic>> get mucGiaNhaBan => _mucGiaNhaBan;

  set mucGiaNhaBan(List<Map<String, dynamic>> value) {
    _mucGiaNhaBan = value;
  }

  final String authToken;
  final String uid;
  late NhuCau _nhuCau = NhuCau(hinhAnhs: []);
  List<String> file_images = [];
  late int _start;
  List<KhuVuc> get khuVuc => _khuVuc;

  set khuVuc(List<KhuVuc> value) {
    _khuVuc = value;
  }

  int get start => _start;

  set start(int value) {
    _start = value;
  }

  final map = Map<String, dynamic>();

  set nhuCau(NhuCau value) {
    _nhuCau = value;
  }

  set items(List<NhuCau> value) {
    _items = value;
  }

  NhuCau get nhuCau => _nhuCau;

  NhuCaus(this.authToken, this.uid, this._items, this._start);

  List<NhuCau> get items{
    return [..._items];
  }

  Future<void> getNhuCauByNid(int nid) async{
    final response = await http.post(
        Uri.parse(RFGetThongTinNhuCau),
        body: json.encode({
          'uid': this.uid,
          'auth': this.authToken,
          'nid': nid
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        }
    );
    if(!jsonDecode(response.body)['success'])
      throw HttpException(jsonDecode(response.body)['content']);

    map['field_anh_san_pham'] = jsonDecode(response.body)['content']['field_anh_san_pham'];

    _nhuCau = new NhuCau(
      nid: jsonDecode(response.body)['content']['nid'],
      title: jsonDecode(response.body)['content']['title'],
      khachHangChuNha: jsonDecode(response.body)['content']['KhachHangChuNha'] == null ? null : KhachHangChuNha(
        hoTen: jsonDecode(response.body)['content']['KhachHangChuNha']['hoTen'] == null ? '' : jsonDecode(response.body)['content']['KhachHangChuNha']['hoTen'],
        dienThoai: jsonDecode(response.body)['content']['KhachHangChuNha']['dienThoai'] == null ? '' : jsonDecode(response.body)['content']['KhachHangChuNha']['dienThoai'],
      ),

      nhuCau: jsonDecode(response.body)['content']['nhuCau'],
      ngayNhap: jsonDecode(response.body)['content']['ngayNhap'],
      quanHuyen: jsonDecode(response.body)['content']['quanHuyen'] == null ? null : KhuVuc(
        tid: jsonDecode(response.body)['content']['quanHuyen']['tid'].toString().toInt(),
        name: jsonDecode(response.body)['content']['quanHuyen']['name'],
      ),
      phuongXa: jsonDecode(response.body)['content']['phuongXa'] == null ? null : KhuVuc(
        tid: jsonDecode(response.body)['content']['phuongXa']['tid'].toString().toInt(),
        name: jsonDecode(response.body)['content']['phuongXa']['name'],
      ),
      soPhongNgu: jsonDecode(response.body)['content']['soPhongNgu'].toString().toInt(),
      SoPhongVeSinh: jsonDecode(response.body)['content']['SoPhongVeSinh'].toString().toInt(),
      field_huong: jsonDecode(response.body)['content']['field_huong'],
      soTang: jsonDecode(response.body)['content']['soTang'].toString().toInt(),
      thongTinPhapLy: jsonDecode(response.body)['content']['thongTinPhapLy'],
      tinhTrangNoiThat: jsonDecode(response.body)['content']['tinhTrangNoiThat'].toString(),
      field_gia: jsonDecode(response.body)['content']['field_gia'].toString().toDouble(),
      donViTinhGia: jsonDecode(response.body)['content']['donViTinhGia'] == null ? null : DonViTinh(
        tid: jsonDecode(response.body)['content']['donViTinhGia']['tid'].toString().toInt(),
        name: jsonDecode(response.body)['content']['donViTinhGia']['name'],
      ),
      giaBangSo: jsonDecode(response.body)['content']['giaBangSo'].toString().toDouble(),
      field_dien_tich: jsonDecode(response.body)['content']['dienTichDat'].toString().toDouble(),
      dienTichSuDung: jsonDecode(response.body)['content']['dienTichDat'].toString().toDouble(),
      chieuDai: jsonDecode(response.body)['content']['chieuDai'].toString().toDouble(),
      chieuRong: jsonDecode(response.body)['content']['chieRong'].toString().toDouble(),
      soTienCoc: jsonDecode(response.body)['content']['soTienCoc'].toString().toDouble(),
      ghiChu: jsonDecode(response.body)['content']['ghiChu'],
      hinhAnhs: (map['field_anh_san_pham'] as List).map((item) => item as String).toList()//jsonDecode(response.body)['field_anh_san_pham'] == null || jsonDecode(response.body)['field_anh_san_pham'] == '' ? [] : jsonDecode(response.body)['field_anh_san_pham'],
    );
    //json.decode(response.body) as Map<String, dynamic>;
    notifyListeners();
  }

  Future<void> getListNhuCau(String? type, Map<String, dynamic>? thongTinTimKiem, int start, int limit) async{
    try
    {
      final response = await http.post(
          Uri.parse(RFGetNhuCauByPhanLoai),
          body: json.encode({
            'thongTinTimKiem': thongTinTimKiem!['timKiem'] ? thongTinTimKiem : null,
            'uid': this.uid,
            'auth': this.authToken,
            'type': type,
            'start': start,
            'length': limit// Tất cả / Cần mua / Cần bán / Cần thuê / Cho thuê / Huỷ
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      _start = jsonDecode(response.body)['startBtn'].toString().toDouble().toInt();

      final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
      final List<NhuCau> loadedNhuCaus = [];
      final String canMuaUrlImage = 'https://happyhomehaiphong.com/images/da-luu/can-mua.png';
      final String canThueUrlImage = 'https://happyhomehaiphong.com/images/da-luu/can-thue.png';
      final String noImageUrl = 'https://happyhomehaiphong.com/images/da-luu/no-image.png';

      extractedData.forEach((element) {
        loadedNhuCaus.add(NhuCau(
          nid: element['nid'],
          field_dien_thoai: element['field_dien_thoai'],
          title: element['title'],
          field_gia: element['field_gia'].toString().toDouble(),
          field_dien_tich: element['field_dien_tich'].toString().toDouble(),
          field_huong: element['field_huong'].toString(),
          field_quan_huyen: element['field_quan_huyen'],
          field_phuong_xa: element['field_phuong_xa'],
          field_nhom_nhu_cau: element['field_nhom_nhu_cau'],
          field_don_vi_tinh: element['field_don_vi_tinh'].toString(),
          field_trang_thai_nhu_cau: element['field_trang_thai_nhu_cau'].toString(),
          field_anh_san_pham: (element['field_nhom_nhu_cau'] == 'Cần mua' ? canMuaUrlImage : (element['field_nhom_nhu_cau'] == 'Cần thuê' ? canThueUrlImage : (element['field_anh_san_pham'] == '' ? noImageUrl : element['field_anh_san_pham']))),
          khachHangChuNha: KhachHangChuNha(
            hoTen: element['hoTen'] == null ? '' : element['hoTen'],
            dienThoai: element['field_dien_thoai'] == null ? "" : element['field_dien_thoai'],
          ),
          hoTen: element['hoTenNguoiNhap'] == null ? '' : element['hoTenNguoiNhap'],
          hinhAnhs: []
        ));
      });
      _items = loadedNhuCaus;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  Future<void> delete(int? nid) async{
    final response = await http.post(
        Uri.parse(RFXoaNhuCau),
        body: json.encode({
          'uid': this.uid,
          'auth': this.authToken,
          'nid': nid
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        }
    );

    //json.decode(response.body) as Map<String, dynamic>;
    notifyListeners();
  }

  Future<void> khoiTaoTimKiemNhuCau() async{
    _khuVuc.clear();
    print(RFBaseKhoiTaoTimKiemNhuCau);
    // try
        {
      final response = await http.post(
          Uri.parse(RFBaseKhoiTaoTimKiemNhuCau),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final listQuan = List<Map<String, dynamic>>.from(jsonDecode(response.body)['listQuan']);
      final mucGiaNhaBan = List<Map<String, dynamic>>.from(jsonDecode(response.body)['mucGiaNhaBan']);
      final mucGiaNhaChoThue = List<Map<String, dynamic>>.from(jsonDecode(response.body)['mucGiaNhaChoThue']);
      final khoangDienTich = List<Map<String, dynamic>>.from(jsonDecode(response.body)['khoangDienTich']);
      listQuan.forEach((element) {
        _khuVuc.add(KhuVuc(
          tid: element['tid'].toString().toInt(),
          name: element['name']
        ));
      });
      mucGiaNhaBan.forEach((element) {
        _mucGiaNhaBan.add({
          "key": element['key'],
          "value": element['value']
        });
      });
      mucGiaNhaChoThue.forEach((element) {
        _mucGiaThue.add({
          "key": element['key'],
          "value": element['value']
        });
      });
      khoangDienTich.forEach((element) {
        _dienTich.add({
          "key": element['key'],
          "value": element['value']
        });
      });
      // _items = loadedNhuCaus;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
  }

}
