import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/providers/NhuCauSua.dart';
import 'package:room_finder_flutter/providers/khuVuc.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

import 'SanPham.dart';

class NhuCauSuas with ChangeNotifier {
  late List<NhuCauSua> _items = [];
  final String authToken;
  final String uid;
  late NhuCauSua _nhuCauSua = NhuCauSua();

  set nhuCauSua(NhuCauSua value) {
    _nhuCauSua = value;
  }

  set items(List<NhuCauSua> value) {
    _items = value;
  }

  NhuCauSua get nhuCauSua => _nhuCauSua;

  NhuCauSuas(this.authToken, this.uid, this._items);
  List<NhuCauSua> get items{
    return [..._items];
  }

  Future<void> getNhuCauByNid(int? nid) async{
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

    final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    final List<NhuCauSua> loadedNhuCaus = [];
    extractedData.forEach((element) {

      loadedNhuCaus.add(NhuCauSua(
        nid: element['nid']
        ngayNhap: element['ngayNhap'],
          nhuCau: element['nhuCau'],

        khachHangChuNha: KhachHangChuNha(
          hoTen: element['hoTen'],
          dienThoai: element['dienThoai'],
        ),
        title: element['title'],
        quanHuyen: KhuVuc(
          tid: element['tid'].toString().toInt(),
          name: element['name'],

        ),
        phuongXa: KhuVuc(
          tid: element['tid'].toString().toInt(),
          name: element['name'],

        ),
        soPhongNgu: element['soPhongNgu'].toString().toInt(),
        SoPhongVeSinh: element['SoPhongVeSinh'].toString().toInt(),
        huong: element['huong'],
        soTang: element['soTang'].toString().toInt(),
        thongTinPhapLy: element['thongTinPhapLy'],
        tinhTrangNoiThat: element['thongTinPhapLy'],
        Gia: element['Gia'].toString().toDouble(),
        donViTinhGia: DonViTinh(
          tid: element['tid'].toString().toInt(),
          name: element['name'],

        ),
        giaBangSo: element['giaBangSo'].toString().toDouble(),
        dienTichDat: element['dienTichDat'].toString().toDouble(),
        dienTichSuDung: element['dienTichSuDung'].toString().toDouble(),
        chieuDai: element['chieuDai'].toString().toDouble(),
        chieRong: element['chieRong'].toString().toDouble(),
        soTienCoc: element['soTienCoc'].toString().toDouble(),
        ghiChu: element['ghiChu'],
        //element['KhachHangChuNha:{hoTen,dienThoai}'],
      ));

    });
    _items = loadedNhuCaus;

    //json.decode(response.body) as Map<String, dynamic>;
    notifyListeners();
  }



}
