import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/screens/RFFormSuaKhachHang.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';
import 'package:room_finder_flutter/widgets/ListNhuCauInnerCustomer.dart';

class BangKhachHangList extends StatefulWidget {
  String? phone;
  String? name;


  BangKhachHangList({this.name, this.phone});
  @override
  State<BangKhachHangList> createState() => _BangKhachHangListState();
}

class _BangKhachHangListState extends State<BangKhachHangList> {
  late List<KhachHang> khachHangs = [];
  late String isLoadedData = '';

  int start = 0;
  int limit = 10;

  Future<void> _reloadKhachHangList(BuildContext context) async {
    final provider = Provider.of<KhachHangs>(context, listen: false);

    provider
        .getListKhachHang(start, limit, widget.name, widget.phone)
        .then((value) {
      if (this.mounted) {
        setState(() {
          khachHangs = provider.items;
          start = provider.start;
          isLoadedData = '1';
          print(start);
        });
      }
    });
    print(widget.name);
    print('1');
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.65;
    double img_width_height = 60;

    if (isLoadedData == '') _reloadKhachHangList(context);
    return isLoadedData == ''
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: khachHangs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  KhachHang dataKhachHang = khachHangs[index];

                  return GestureDetector(
                    child: ListTileTheme(
                      contentPadding: EdgeInsets.all(0),
                      child: ExpansionTile(
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        leading: IconButton(
                            onPressed: () {
                              Uri url = Uri(
                                  scheme: 'tel',
                                  path: "${dataKhachHang.field_dien_thoai}");

                              launchUrl(url);
                            },
                            icon: Icon(Icons.phone)),
                        title: Text('${dataKhachHang.hoTen}',
                            style: primaryTextStyle()),
                        onExpansionChanged: (expansion) {
                          if (expansion) {
                            SanPhams sanPham =
                                Provider.of<SanPhams>(context, listen: false);
                            sanPham
                                .getListNhuCau(dataKhachHang.nid.toInt())
                                .then((value) {
                              setState(() {
                                dataKhachHang.sanPham = sanPham.items;
                              });
                            });
                          }
                        },
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.withAlpha(32),
                                borderRadius: radius()),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Nhu cầu',
                                      style: boldTextStyle(size: 18),
                                    ).expand(),
                                  ],
                                ),
                                16.height,
                                ListNhuCauInnerCustomer(
                                  sanPham: dataKhachHang.sanPham,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RFFormSuaKhachHang(
                                                      nid: dataKhachHang.nid,
                                                      name: dataKhachHang.hoTen,
                                                      phone: dataKhachHang
                                                          .field_dien_thoai,
                                                    )));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 24.0,
                                      ),
                                      label: Text('Sửa'), // <-- Text
                                    ),
                                    8.width,
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        size: 24.0,
                                      ),
                                      label: Text('Xóa'), // <-- Text
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                },
              ),
              start == -2
                  ? Text('123')
                  : // Không phân trang
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        start == -1 || start > 10
                            ? Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.lightBlue,
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.navigate_before,
                                    color: Colors.white,
                                  ),
                                  iconSize: 30,
                                  onPressed: () {
                                    setState(() {
                                      start == -1 ? start = 0 : start -= 20;
                                    });
                                    _reloadKhachHangList(context);
                                  },
                                ),
                              )
                            : SizedBox(
                                width: 0,
                              ), //Trang cuối hoặc từ trang 2 trở đi
                        start > 10 ? 8.width : 0.width,
                        start >= 10
                            ? Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.lightBlue,
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.navigate_next_outlined,
                                    color: Colors.white,
                                  ),
                                  iconSize: 30,
                                  onPressed: () {
                                    _reloadKhachHangList(context);
                                  },
                                ),
                              )
                            : SizedBox(),
                      ],
                    )
            ],
          );
  }
}
