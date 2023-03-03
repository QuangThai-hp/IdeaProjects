import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/khuVuc.dart';
import 'package:room_finder_flutter/providers/donViTinhs.dart';
class NhuCauSua with ChangeNotifier {
 final String? nid;
 final String? ngayNhap;
 final String? nhuCau;
 final KhachHangChuNha? khachHangChuNha;
 final String? title;
 final KhuVuc? quanHuyen;
 final KhuVuc? phuongXa;
 final int? soPhongNgu;
 final int? SoPhongVeSinh;
 final String? huong;
 final int? soTang;
 final String? thongTinPhapLy;
 final String? tinhTrangNoiThat;
 final double? Gia;
 final DonViTinh? donViTinhGia;
 final double? giaBangSo;
 final double? dienTichDat;
 final double? dienTichSuDung;
 final double? chieuDai;
 final double? chieRong;
 final double? soTienCoc;
 final String? ghiChu;

 NhuCauSua({
      this.nid,
      this.ngayNhap,
      this.nhuCau,
      this.khachHangChuNha,
      this.title,
      this.quanHuyen,
      this.phuongXa,
      this.soPhongNgu,
      this.SoPhongVeSinh,
      this.huong,
      this.soTang,
   this.thongTinPhapLy,
      this.tinhTrangNoiThat,
      this.Gia,
      this.donViTinhGia,
      this.giaBangSo,
      this.dienTichDat,
      this.dienTichSuDung,
      this.chieuDai,
      this.chieRong,
      this.soTienCoc,
      this.ghiChu});
}
