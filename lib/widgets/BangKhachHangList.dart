import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:provider/provider.dart';

class BangKhachHangList extends StatefulWidget {
  @override
  State<BangKhachHangList> createState() => _BangKhachHangListState();
}

class _BangKhachHangListState extends State<BangKhachHangList> {
  late List<KhachHang> khachHangs = [];
  late String trangThaiCu = '';

  Future<void> _reloadKhachHangs(BuildContext context) async{
    final provider = Provider.of<KhachHangs>(context);
    provider.getListKhachHang().then((value){
      setState(() {
        khachHangs = provider.items;
        trangThaiCu = '1';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.65;
    double img_width_height = 60;

    if(trangThaiCu == '')
      _reloadKhachHangs(context);
    return
      trangThaiCu == '' ? Center(
        child: CircularProgressIndicator(),
      ) :
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: khachHangs.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          KhachHang data = khachHangs[index];
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

                              width: c_width,
                              child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Text('${data.hoTen}', style: TextStyle(
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
                            Text("Mã: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${data.nid.toString()}', style: TextStyle(color: Colors.blue),),

                            10.width,
                            Text("Điện thoại: ", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(data.field_dien_thoai.toString(), style: TextStyle(color: Colors.blue),),

                          ],
                        ),
                        4.height,
                        Row(
                          children: [
                            Text("Trạng Thái: ", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(data.field_trang_thai.toString(), style: TextStyle(color: Colors.blue),),

                          ],
                        ),4.height,


                      ],
                    ).expand(),
                  ],
                ),
              ),
              onTap: (){
                // Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => RFChiTietDinhDuongNgayScreen(ngayDinhDuong : data.field_ngay_dinh_duong!.substring(0, 10))), (route) => false);

                // Provider.of<KhachHang>(context).field_ngay_dinh_duong = data.field_ngay_dinh_duong!.substring(0, 10);
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
