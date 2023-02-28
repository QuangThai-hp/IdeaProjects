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
  late List<NhuCau> nhuCaus = [];
  late String trangThaiCu = '';

  Future<void> _reloadCanMua(BuildContext context) async{
    final provider = Provider.of<NhuCaus>(context);
    provider.getListNhuCau('Cần bán').then((value){
      setState(() {
        nhuCaus = provider.items;
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
      itemCount: nhuCaus.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        NhuCau data = nhuCaus[index];
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

                          child: Image.asset(rf_logo_happyhome, height: img_width_height, width: img_width_height, fit: BoxFit.fill),
                        ),
                        8.width,
                        Container(
                          alignment: Alignment.topLeft,
                          width: c_width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('${data.title}', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: rf_primaryColor,
                                fontSize: 14
                              ),),
                              8.height,
                              Row(
                                children: [
                                  Text('Giá: ${data.field_gia}', style: TextStyle(
                                      fontWeight: FontWeight.bold, color: rf_primaryColor,
                                      fontSize: 14
                                  ),),
                                  10.width,
                                  Text('Hướng: ${data.field_huong}', style: TextStyle(
                                      fontWeight: FontWeight.bold, color: rf_primaryColor,
                                      fontSize: 14
                                  ),),
                                ],
                              ),
                              8.height,
                              Text('Vị trí: ${data.field_quan_huyen}-${data.field_phuong_xa}', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: rf_primaryColor,
                                  fontSize: 14
                              ),),
                              8.height,
                              Text('Số Điện Thoại: ${data.field_dien_thoai}', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: rf_primaryColor,
                                  fontSize: 14
                              ),),
                            ],
                          ).expand(),
                        ),
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
