import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:provider/provider.dart';

class BangNhuCauCanMuaList extends StatefulWidget {
  @override
  State<BangNhuCauCanMuaList> createState() => _BangNhuCauCanMuaListState();
}

class _BangNhuCauCanMuaListState extends State<BangNhuCauCanMuaList> {
  late List<NhuCau> nhuCaus = [];
  late String trangThaiCu = '';

  Future<void> _reloadNhuCauCanMua(BuildContext context) async{
    final provider = Provider.of<NhuCaus>(context);
    provider.getListNhuCau('Mua bán').then((value){
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
      _reloadNhuCauCanMua(context);
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
                              Text('${data.title}', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: rf_primaryColor,
                                fontSize: 14
                              ),)
                            ],
                          ).expand(),
                        ),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Text("Số tầng: ", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(data.field_so_tang.toString(), style: TextStyle(color: Colors.blue),),
                        10.width,
                        Text("Diện tích: ", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(data.field_dien_tich.toString(), style: TextStyle(color: Colors.blue),),


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
