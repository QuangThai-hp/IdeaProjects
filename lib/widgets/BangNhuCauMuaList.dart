import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/screens/RFFormNhuCau.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';

import '../main.dart';
import '../utils/RFString.dart';
import '../utils/RFWidget.dart';

class BangNhuCauCanMuaList extends StatefulWidget {
  String phanLoai = 'Tất cả';
  BangNhuCauCanMuaList({required this.phanLoai});

  @override
  State<BangNhuCauCanMuaList> createState() => _BangNhuCauCanMuaListState();
}

class _BangNhuCauCanMuaListState extends State<BangNhuCauCanMuaList> {
  late List<NhuCau> nhuCaus = [];
  late String trangThaiCu = '';

  Future<void> _reloadNhuCau(BuildContext context) async{
    final provider = Provider.of<NhuCaus>(context);
    print(widget.phanLoai);
    provider.getListNhuCau(widget.phanLoai).then((value){
      print(this.mounted);
      if(this.mounted){
        setState(() {
          nhuCaus = provider.items;
          trangThaiCu = widget.phanLoai;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.8;

    if(trangThaiCu != widget.phanLoai)
      _reloadNhuCau(context);

    return
      trangThaiCu != widget.phanLoai || trangThaiCu == '' ? Center(
        child: CircularProgressIndicator(),
      ) :
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: nhuCaus.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          // NhuCau data = nhuCaus[index];
          return
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  children: <Widget>[

                    Row(
                      children: [
                        Container(
                          height: width * 0.32,
                          width: width * 0.32,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: ClipRRect(
                                  borderRadius: new BorderRadius.circular(12.0),
                                  child: CachedNetworkImage(
                                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                    imageUrl: nhuCaus[index].field_anh_san_pham,
                                    fit: BoxFit.cover,
                                    height: width * 0.32,
                                    width: width * 0.32,
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
                            children: <Widget>[
                              5.height,
                              Text(nhuCaus[index].title, style: TextStyle(color: appStore.textPrimaryColor, fontWeight: FontWeight.bold),),
                              text(nhuCaus[index].field_quan_huyen == null ? '' : nhuCaus[index].field_quan_huyen, maxLine: 1, textColor: appStore.textSecondaryColor, fontSize: textSizeSMedium),
                              SizedBox(height: 2),
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
                                children: [
                                  Icon(Icons.monetization_on, size: 14, color: color_primary_black,),
                                  5.width,
                                  text(nhuCaus[index].field_gia.toString(), textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                  5.width,
                                  Text(nhuCaus[index].field_don_vi_tinh, style: TextStyle(color: t7textColorSecondary, fontSize: textSizeSMedium) ), //, fontSize: textSizeSMedium),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.refresh, size: 14, color: color_primary_black,),
                                  5.width,
                                  text(nhuCaus[index].field_trang_thai_nhu_cau != '' ? nhuCaus[index].field_trang_thai_nhu_cau : 'Chưa kết nối', maxLine: 1, isLongText: true, textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                ],
                              ),
                              SizedBox(height: 8),
                              Divider(height: 0.5, color: t7view_color, thickness: 1)
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.remove_red_eye,color:Colors.green, size: 18, ), // icon
                                  4.width,
                                  Text("Chi tiết",style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14
                                  )), // text
                                ],
                              )

                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RFFormNhuCauScreen(nid: nhuCaus[index].nid.toInt(),)
                            )
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
                                  Icon(Icons.edit,color:Colors.green, size: 18, ), // icon
                                  4.width,
                                  Text("Sửa",style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14
                                  )), // text
                                ],
                              )

                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white

                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(Icons.restore_from_trash_outlined,color:Colors.red, size: 18, ), // icon
                                  4.width,
                                  Text("Xoá",style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 14
                                  )), // text
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              onTap: (){
                // Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => RFChiTietDinhDuongNgayScreen(ngayDinhDuong : data.field_ngay_dinh_duong!.substring(0, 10))), (route) => false);

                // Provider.of<SanPham>(context).field_ngay_dinh_duong = data.field_ngay_dinh_duong!.substring(0, 10);
                // pushNamedAndRemoveUntil
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil(RFChiTietDinhDuongNgayScreen.routeName, (route)=>false);
                // RFChiTietDinhDuongNgayScreen().launch(context);
              },
            );
        },
      );
  }
}
