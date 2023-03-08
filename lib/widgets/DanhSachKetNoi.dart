import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFHomeFragment.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/screens/RFFormSuaKhachHang.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/widgets/ListNhuCauInnerCustomer.dart';

class DanhSachKetNoi extends StatefulWidget {
  @override
  State<DanhSachKetNoi> createState() => _DanhSachKetNoiState();
}

class _DanhSachKetNoiState extends State<DanhSachKetNoi> {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Nhà 3 tầng',
      'phone': '0123456789',
      'address': 'Số 1 đườngs quán nam lê chân hsải phòng ksshong biset viet gì cả' ,
      'price':'1',
      'donvitinh':'tỷ',
      'area': '100 m²',
    },
    {
      'title': 'Căn hộ cao cấp',
      'phone': '0987654321',
      'address': 'Số 2 đường thiên lôi vĩnh niên hải phòng việt nam',
      'price':'1',
      'donvitinh':'tỷ',
      'area': '80 m²',
    },
    // ...
  ];

  late List<KhachHang> khachHangs = [];
  late String isLoadedData = '';
  bool isExpanded = false;

  Future<void> _reloadKhachHangList(BuildContext context) async {
    final provider = Provider.of<KhachHangs>(context);
    provider.getListKhachHang().then((value) {
      setState(() {
        khachHangs = provider.items;
        isLoadedData = '1';
      });
    });
  }

  @override
  Widget build(BuildContext context) {

   return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount:items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {

              final item = items[index];
              return GestureDetector(
                child: ListTileTheme(

                  contentPadding: EdgeInsets.all(0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        8.height,
                        Row(
                          children: [
                            SizedBox(
                              width: 330,
                              child: Text(
                                item['address'],
                                style: primaryTextStyle(),
                              ),
                            ),
                            // text
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diện Tích:${item['area']}',
                              style: primaryTextStyle(),
                            ),

                            Text(
                              'Giá: ${item['price']}${item['donvitinh']}',
                              style: primaryTextStyle(),
                            ),

                            TextButton(
                              onPressed: () {
                                showConfirmDialogCustom(
                                  context,
                                  cancelable: false,
                                  title: "Bạn chắc chắn muốn kết nối",
                                  dialogType: DialogType.CONFIRMATION,
                                  onCancel: (v) {
                                    finish(context);
                                  },
                                  onAccept: (v) {
                                    RFHomeScreen rf_home = new RFHomeScreen();
                                    rf_home.selectedIndex = 0;
                                    rf_home.launch(context);
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget> [
                                  Row(
                                    children: [
                                      Icon(Icons.handshake,color:Colors.blueAccent, size: 18, ), // icon
                                      Text("Kết nối",style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14
                                      )), // text
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              );
            },
          );
  }
}
