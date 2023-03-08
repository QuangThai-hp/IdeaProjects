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
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/RFWidget.dart';

class DanhSachKetNoi extends StatefulWidget {
  @override
  State<DanhSachKetNoi> createState() => _DanhSachKetNoiState();
}

class _DanhSachKetNoiState extends State<DanhSachKetNoi> {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Nhà 3 tầng',
      'address': 'Số 1 đườngs quán nam lê chân hsải phòng ' ,
      'price':'1',
      'donvitinh':'tỷ',
      'area': '100 m²',
      'imageUrl':'https://www.invert.vn/media/downloads/221203T1328_631.jpg'
    },
    {
      'title': 'Căn hộ cao cấp',
      'address': 'Số 2 đường thiên lôi vĩnh niên hải phòng việt nam',
      'price':'1',
      'area': '80 m²',
      'imageUrl':'https://www.invert.vn/media/downloads/221203T1328_631.jpg'

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
    var width = MediaQuery.of(context).size.width;
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

                    margin: EdgeInsets.only(bottom: 16),

                    child: Column(
                      children: <Widget>[

                        Row(
                          children: [
                            Container(
                              height: width * 0.28,
                              width: width * 0.28,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: new BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                        imageUrl: item['imageUrl'],
                                        fit: BoxFit.cover,
                                        height: width * 0.28,
                                        width: width * 0.28,
                                      ),
                                    ),
                                  )

                                  // Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: Container(
                                  //     margin: EdgeInsets.only(right: 10, top: 10),
                                  //     child: Icon(Icons.favorite_border, color: appStore.iconColor, size: 20),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(item['title'],style: TextStyle(fontWeight: FontWeight.bold), ),
                                  SizedBox(height: 5),
                                  // Row(
                                  //   children: <Widget>[
                                  //     RatingBar(
                                  //       initialRating: 5,
                                  //       minRating: 1,
                                  //       itemSize: 16,
                                  //       direction: Axis.horizontal,
                                  //       itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  //       itemBuilder: (context, _) => Icon(
                                  //         Icons.star,
                                  //         color: t7colorPrimary,
                                  //       ),
                                  //       onRatingUpdate: (rating) {},
                                  //     ),
                                  //     text(mListings[index].hotel_review, textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                  //   ],
                                  // ),


                                  Row(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Icon(Icons.location_on_outlined, size: 14, color: color_primary_black,),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          item['address'],
                                          style: primaryTextStyle(),
                                        ),
                                      ),


                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.monetization_on, size: 14, color: color_primary_black,),
                                      Text('${item['price']}/${item['donvitinh']}'),
                                      5.width,
                                      Icon(Icons.area_chart_outlined, size: 14, color: color_primary_black,),
                                      Text(item['area']),
                                      5.width,
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
                                            backgroundColor: Colors.white

                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.handshake_outlined,color:Colors.green, size: 18, ), // icon
                                                4.width,
                                                Text("kết nối",style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14
                                                )), // text
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                      //, fontSize: textSizeSMedium),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Divider(height: 0.5, color: t7view_color, thickness: 1)
                                ],
                              ),
                            )
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
