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
  final String authToken;
  final String uid;
  late NhuCau _nhuCau = NhuCau(hinhAnhs: []);
  List<String> file_images = [];
  late int _start;

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
    print(RFGetThongTinNhuCau);
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
    print(jsonDecode(response.body));

    map['field_anh_san_pham'] = jsonDecode(response.body)['field_anh_san_pham'];

    _nhuCau = new NhuCau(
      nid: jsonDecode(response.body)['nid'],
      title: jsonDecode(response.body)['title'],
      khachHangChuNha: jsonDecode(response.body)['KhachHangChuNha'] == null ? null : KhachHangChuNha(
        hoTen: jsonDecode(response.body)['KhachHangChuNha']['hoTen'] == null ? '' : jsonDecode(response.body)['KhachHangChuNha']['hoTen'],
        dienThoai: jsonDecode(response.body)['KhachHangChuNha']['dienThoai'] == null ? '' : jsonDecode(response.body)['KhachHangChuNha']['dienThoai'],
      ),

      nhuCau: jsonDecode(response.body)['nhuCau'],
      ngayNhap: jsonDecode(response.body)['ngayNhap'],
      quanHuyen: jsonDecode(response.body)['quanHuyen'] == null ? null : KhuVuc(
        tid: jsonDecode(response.body)['quanHuyen']['tid'].toString().toInt(),
        name: jsonDecode(response.body)['quanHuyen']['name'],
      ),
      phuongXa: jsonDecode(response.body)['phuongXa'] == null ? null : KhuVuc(
        tid: jsonDecode(response.body)['phuongXa']['tid'].toString().toInt(),
        name: jsonDecode(response.body)['phuongXa']['name'],
      ),
      soPhongNgu: jsonDecode(response.body)['soPhongNgu'].toString().toInt(),
      SoPhongVeSinh: jsonDecode(response.body)['SoPhongVeSinh'].toString().toInt(),
      field_huong: jsonDecode(response.body)['field_huong'],
      soTang: jsonDecode(response.body)['soTang'].toString().toInt(),
      thongTinPhapLy: jsonDecode(response.body)['thongTinPhapLy'],
      tinhTrangNoiThat: jsonDecode(response.body)['tinhTrangNoiThat'].toString(),
      field_gia: jsonDecode(response.body)['field_gia'].toString().toDouble(),
      donViTinhGia: jsonDecode(response.body)['donViTinhGia'] == null ? null : DonViTinh(
        tid: jsonDecode(response.body)['donViTinhGia']['tid'].toString().toInt(),
        name: jsonDecode(response.body)['donViTinhGia']['name'],
      ),
      giaBangSo: jsonDecode(response.body)['giaBangSo'].toString().toDouble(),
      field_dien_tich: jsonDecode(response.body)['dienTichDat'].toString().toDouble(),
      dienTichSuDung: jsonDecode(response.body)['dienTichDat'].toString().toDouble(),
      chieuDai: jsonDecode(response.body)['chieuDai'].toString().toDouble(),
      chieuRong: jsonDecode(response.body)['chieRong'].toString().toDouble(),
      soTienCoc: jsonDecode(response.body)['soTienCoc'].toString().toDouble(),
      ghiChu: jsonDecode(response.body)['ghiChu'],
      hinhAnhs: (map['field_anh_san_pham'] as List).map((item) => item as String).toList()//jsonDecode(response.body)['field_anh_san_pham'] == null || jsonDecode(response.body)['field_anh_san_pham'] == '' ? [] : jsonDecode(response.body)['field_anh_san_pham'],
    );
    //json.decode(response.body) as Map<String, dynamic>;
    notifyListeners();
  }

  Future<void> getListNhuCau(String? type, int start, int limit) async{
    print(RFGetNhuCauByPhanLoai);
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetNhuCauByPhanLoai),
          body: json.encode({
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
      print(loadedNhuCaus.length);
      _items = loadedNhuCaus;
      // if(!responseData['success'])
      //   throw HttpException(responseData['content']);
      notifyListeners();
    }
    // catch(error){
    //   throw error;
    // }
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
}
