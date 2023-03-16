import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/screens/RFFormNhuCau.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/providers/NhuCau.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/RFString.dart';
import '../utils/RFWidget.dart';

class BangNhuCauCanMuaList extends StatefulWidget {
  String phanLoai = 'Tất cả';
  bool reset = false;
  BangNhuCauCanMuaList({required this.phanLoai, required this.reset});

  @override
  State<BangNhuCauCanMuaList> createState() => _BangNhuCauCanMuaListState();
}

class _BangNhuCauCanMuaListState extends State<BangNhuCauCanMuaList> {
  late List<NhuCau> nhuCaus = [];
  late String trangThaiCu = '';
  int start = 0;
  int limit = 10;

  Future<void> _reloadNhuCau(BuildContext context) async{
    final provider = Provider.of<NhuCaus>(context, listen: false);
    print(widget.phanLoai);
    if(widget.reset)
      setState(() {
        this.start = 0;
      });

    provider.getListNhuCau(widget.phanLoai, this.start, this.limit).then((value){
      if(this.mounted){
        setState(() {
          nhuCaus = provider.items;
          trangThaiCu = widget.phanLoai;
          start = provider.start;
          widget.reset = false;
          print(start);
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
      trangThaiCu != widget.phanLoai || trangThaiCu == '' ?
      Center(child: CircularProgressIndicator(),) :
      nhuCaus.length == 0 ? Text('Không có thông tin nhu cầu') // không phân trang
          : Column(
            children: [
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
                          margin: EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text("[${nhuCaus[index].nid}] - ${nhuCaus[index].title}", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),)
                              ),
                              8.height,
                              Row(
                                children: [
                                  Container(
                                    height: width * 0.25,
                                    width: width * 0.25,
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        5.height,
                                        Row(
                                          children: [
                                            Icon(Ionicons.navigate_circle, size: 18, color: color_primary_black,),
                                            5.width,
                                            text(nhuCaus[index].field_quan_huyen == null ? '' : nhuCaus[index].field_quan_huyen, maxLine: 1, textColor: appStore.textSecondaryColor, fontSize: textSizeSMedium),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Icon(Icons.monetization_on, size: 18, color: color_primary_black,),
                                            5.width,
                                            text(
                                                NumberFormat.currency(locale: 'vi', symbol: '').format( nhuCaus[index].field_gia), textColor: t7textColorSecondary, fontSize: textSizeSMedium
                                            ),
                                            5.width,
                                            Text(nhuCaus[index].field_don_vi_tinh, style: TextStyle(color: t7textColorSecondary, fontSize: textSizeSMedium) ), //, fontSize: textSizeSMedium),
                                          ],
                                        ),
                                        Row(

                                          children: [
                                            Icon(Ionicons.git_branch, size: 14, color: color_primary_black,),
                                            5.width,
                                            text(nhuCaus[index].field_trang_thai_nhu_cau != '' ? nhuCaus[index].field_trang_thai_nhu_cau : 'Chưa kết nối', maxLine: 1, isLongText: true, textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Ionicons.person, size: 14, color: color_primary_black,),
                                            5.width,
                                            Expanded(
                                                child: text(nhuCaus[index].khachHangChuNha?.hoTen, textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                            ),
                                            10.width,
                                            Icon(Ionicons.call, size: 14, color: color_primary_black,),
                                            5.width,
                                            text(nhuCaus[index].khachHangChuNha?.dienThoai, textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Ionicons.person, size: 14, color: color_primary_black,),
                                            5.width,
                                            Expanded(
                                              child: InkWell(
                                                child: text("Sale: ${nhuCaus[index].hoTen}", textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                                onTap: () => {
                                                  Clipboard.setData(ClipboardData(text: nhuCaus[index].hoTen))
                                                      .then((value) { //only if ->
                                                        final snackBar = SnackBar(
                                                          content: Text('Đã sao chép thông tin người nhập'),
                                                          action: SnackBarAction(
                                                            label: 'Undo',
                                                            onPressed: () {},
                                                          ),
                                                        );

                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar); // -> show a notification
                                                  })
                                                },
                                              ),
                                              // child: text("Sale: ${nhuCaus[index].hoTen}", textColor: t7textColorSecondary, fontSize: textSizeSMedium),
                                            ),
                                          ],
                                        ),
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
                                            Icon(Ionicons.git_branch_outline,color: rf_primaryColor, size: 18, ), // icon
                                            2.width,
                                            Text("Kết nối",style: TextStyle(fontSize: 12,color: rf_primaryColor)), // text
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
                                            Icon(Ionicons.eye_outline,color: rf_primaryColor, size: 18, ), // icon
                                            2.width,
                                            Text("Chi tiết",style: TextStyle(color: rf_primaryColor, fontSize: 12
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
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Ionicons.pencil_sharp,color: rf_primaryColor, size: 18, ), // icon
                                            2.width,
                                            Text("Sửa",style: TextStyle(
                                                color: rf_primaryColor,
                                                fontSize: 12
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
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Ionicons.copy_outline, color: rf_primaryColor, size: 18, ), // icon
                                            2.width,
                                            Text("Copy",style: TextStyle(
                                                color: rf_primaryColor,
                                                fontSize: 12
                                            )), // text
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final provider = Provider.of<NhuCaus>(context);
                                      provider.delete(nhuCaus[index].nid.toInt(),);
                                      setState(() {

                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white

                                    ),

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(Ionicons.trash, color:Colors.red, size: 18, ), // icon
                                            2.width,
                                            Text("Xoá",style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12
                                            )), // text
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(height: 0.5, color: t7view_color, thickness: 1),
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
                ),
                start == -2 ? SizedBox() : // Không phân trang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      start == -1 || start > 10 ? Ink(
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
                              print(start);
                            });
                            _reloadNhuCau(context);
                          },
                        ),
                      ) : SizedBox(width: 0,), //Trang cuối hoặc từ trang 2 trở đi
                      start > 10 ? 8.width : 0.width,
                      start >= 10 ? Ink(
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
                            _reloadNhuCau(context);
                          },
                        ),
                      ) : SizedBox(),
                    ],
                  )
            ],
          );

  }
}
