import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/CaNhans.dart';


class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {
        'tid': query + index.toString(),
        'name': query + index.toString(),
      };
    });
  }
}

class CitiesService {
  List<String> matches = <String>[];
  void getSuggestions(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getLoaiBatDongSan();
    provider.addListener(() async {
      matches.addAll(provider.TenLoaiBatDongSan);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getNguonKhach(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getNguonKhach();
    provider.addListener(() async {
      matches.addAll(provider.NguonKhach);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }

  void getChiNhanh(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getChiNhanh();
    provider.addListener(() async {
      matches.addAll(provider.ChiNhanh);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }


  void getNhomSanPham(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getNhomSanPham();
    provider.addListener(() async {
      matches.addAll(provider.NhomSanPham);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }

  void getNhomNhuCau(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getNhomNhuCau();
    provider.addListener(() async {
      matches.addAll(provider.NhomNhuCau);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getLoaiHinh(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getLoaiHinh();
    provider.addListener(() async {
      matches.addAll(provider.LoaiHinh);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getQuanHuyen(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getQuanHuyen();
    provider.addListener(() async {
      matches.addAll(provider.QuanHuyen);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getDonViTinh(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getDonViTinh();
    provider.addListener(() async {
      matches.addAll(provider.DonViTinh);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getLoaiHoaHong(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getLoaiHoaHong();
    provider.addListener(() async {
      matches.addAll(provider.LoaiHoaHong);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getHuong(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getHuong();
    provider.addListener(() async {
      matches.addAll(provider.Huong);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getNhanSu(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getNhanSu('3');
    provider.addListener(() async {
      matches.addAll(provider.NhanSu);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }
  void getPhuongXa(String query, BuildContext context) {
    print(query);
    final provider = Provider.of<CaNhans>(context, listen: false);
    provider.getPhuongxa('116');
    provider.addListener(() async {
      matches.addAll(provider.PhuongXa);
      // return matches;
      // matches = [...{...matches}];
      // print(matches);
    });
    // matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  }

}
