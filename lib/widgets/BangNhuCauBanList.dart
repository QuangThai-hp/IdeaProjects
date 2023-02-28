import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';

class BangNhuCauCanBanList extends StatefulWidget {
  @override
  State<BangNhuCauCanBanList> createState() => _BangNhuCauCanBanListState();
}

class _BangNhuCauCanBanListState extends State<BangNhuCauCanBanList> {
  late List<SanPham> sanPhams = [];
  late String trangThaiCu = '';

  Future<void> _reloadCanMua(BuildContext context) async{
    final provider = Provider.of<SanPhams>(context);
    provider.getListSanPham('Cần bán').then((value){
      setState(() {
        sanPhams = provider.items;
        trangThaiCu = '1';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.65;
    double img_width_height = 60;

    if(trangThaiCu == '')
      _reloadCanMua(context);
    return
      trangThaiCu == '' ? Center(
        child: CircularProgressIndicator(),
      ) :
      ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: sanPhams.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        SanPham data = sanPhams[index];
        return
          GestureDetector(
            child: Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(8),
            decoration: boxDecorationWithShadow(
              backgroundColor: context.cardColor,
              boxShadow: defaultBoxShadow(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // decoration: BoxDecoration(shape: BoxShape.circle, color: rf_primaryColor),
                          // padding: EdgeInsets.all(8),
                          child: Image.asset(rf_logo_happyhome, height: img_width_height, width: img_width_height, fit: BoxFit.fill),
                        ),
                        8.width,
                        Container(
                          alignment: Alignment.topLeft,
                          width: c_width,
                          child: Column(
                            children: [

                              Text('${data.hoTen}', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: rf_primaryColor,
                                fontSize: 14
                              ),),
                              10.height,
                              Text('${data.field_dien_thoai}', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: rf_primaryColor,
                                  fontSize: 14
                              ),),
                            ],
                          ).expand(),
                        ),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Text("Khu vực: ", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('${data.field_quan_huyen}-${data.field_phuong_xa}', style: TextStyle(color: Colors.blue),),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Text("Giá: ", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('${data.field_gia}', style: TextStyle(color: Colors.blue),),
                        10.width,
                        Text("Hướng: ", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('${data.field_huong}', style: TextStyle(color: Colors.blue),),
                      ],
                    ),

                  ],
                ).expand(),
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
