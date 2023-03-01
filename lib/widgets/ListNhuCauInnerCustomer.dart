import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/providers/KhachHangChuNha.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';

class ListNhuCauInnerCustomer extends StatefulWidget {
  List<SanPham> sanPham = [];

  ListNhuCauInnerCustomer({required this.sanPham});
  // const ListNhuCauInnerCustomer({Key? key}) : super(key: key);

  @override
  State<ListNhuCauInnerCustomer> createState() => _ListNhuCauInnerCustomerState();
}

class _ListNhuCauInnerCustomerState extends State<ListNhuCauInnerCustomer> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.sanPham.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        SanPham data = widget.sanPham[index];
        return
          SettingItemWidget(
            title: data.title,
            subTitle: data.field_trang_thai_nhu_cau,
            leading: Container(
              padding: EdgeInsets.all(4),
              decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
              child: Icon(
                Icons.personal_injury_rounded,
                color: Colors.blue,
              ),
            ),
          );
      },
    );
  }
}
