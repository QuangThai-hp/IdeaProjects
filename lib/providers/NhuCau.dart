import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';

class NhuCau with ChangeNotifier {
  String? nid;
  final String? ngayNhap;
  String nhuCau = '';
  final KhachHangChuNha? khachHangChuNha;
  final String? hoTen;
  final String? field_dien_thoai;
  final String title;
  final double field_dien_tich;
  final double dienTichSuDung;
  final double? field_gia;
  final double? giaBangSo;
  final double? chieuDai;
  final double? chieuRong;
  final double? soTienCoc;
  final String? ghiChu;
  final String? field_huong;
  final String? field_phuong_xa;
  KhuVuc phuongXa = KhuVuc(tid: 0, name: '');
  KhuVuc quanHuyen = KhuVuc(tid: 0, name: '');
  final DonViTinh? donViTinhGia;
final int? soPhongNgu;
final int? SoPhongVeSinh;
final int? soTang;
final String? thongTinPhapLy;
final String? tinhTrangNoiThat;

  final String? field_quan_huyen;
  final String field_nhom_nhu_cau;
  final String field_anh_san_pham;
  final String field_trang_thai_nhu_cau;
  final String field_don_vi_tinh;
  List<String> hinhAnhs = ['https://happyhomehaiphong.com/images/da-luu/no-image.png'];

  NhuCau({
    this.nid = '',
    this.hoTen,
    this.khachHangChuNha = null,
    this.ngayNhap,
    this.nhuCau = '',
    this.field_dien_thoai,
    this.title = '',
    this.field_dien_tich = 0,
    this.dienTichSuDung = 0,

    this.field_gia,
    this.giaBangSo,
    this.chieuDai,
    this.chieuRong,
    this.soTienCoc,
    this.ghiChu,

    this.field_huong  = '',
    this.soPhongNgu,
    this.SoPhongVeSinh,
    this.soTang,
    this.donViTinhGia,
    required this.phuongXa,

    required this.quanHuyen,
    this.thongTinPhapLy,
    this.tinhTrangNoiThat,
    this.field_phuong_xa,
    this.field_quan_huyen,
    this.field_nhom_nhu_cau = '',
    this.field_anh_san_pham = '',
    this.field_trang_thai_nhu_cau = '',
    this.field_don_vi_tinh = '',
    required this.hinhAnhs
  });


}
