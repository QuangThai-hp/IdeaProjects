import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/screens/ChiTietNhuCau.dart';
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
  bool isLoading = false;
  int start = 0;

  // bool reset;
  Map<String, dynamic> thongTinTimKiem = <String, dynamic> {"timKiem": false};

  BangNhuCauCanMuaList({
    required this.phanLoai,
    required bool this.isLoading,
    required this.start,
    required Map<String, dynamic> this.thongTinTimKiem
  });

  @override
  State<BangNhuCauCanMuaList> createState() => _BangNhuCauCanMuaListState();
}

class _BangNhuCauCanMuaListState extends State<BangNhuCauCanMuaList> {
  late List<NhuCau> nhuCaus = [];
  String ketQuaNhuCau = '';
  int limit = 10;

  Future<void> _reloadNhuCau() async{
    setState(() {
      ketQuaNhuCau = '';
    });
    final provider = await Provider.of<NhuCaus>(context, listen: false);
    provider.getListNhuCau(widget.phanLoai, widget.thongTinTimKiem, widget.start, this.limit).then((value){
      if(this.mounted){
        setState(() {
          nhuCaus = provider.items;
          widget.start = provider.start;
          widget.isLoading = false;
          if(nhuCaus.length == 0)
            ketQuaNhuCau = 'Không có thông tin nhu cầu';
          // widget.reset = false;
        });
      }
    });
  }

  @override
  void initState() {
    _reloadNhuCau();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool timKiem = (widget.thongTinTimKiem['timKiem']);
    var width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.75;
    if(widget.isLoading)
      _reloadNhuCau();

    return
    Column(
      children: [
        widget.isLoading == true ?  Container(child: CircularProgressIndicator(),) : SizedBox(),
        Column(
            children: [
              (timKiem) ? Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Thông tin tìm kiếm: '),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Quận: ', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(widget.thongTinTimKiem['selectedValueQuan'] != null ? widget.thongTinTimKiem['selectedValueQuan'] : '')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('Phường: ', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(widget.thongTinTimKiem['selectedValuePhuong'] != null ? widget.thongTinTimKiem['selectedValuePhuong'] : '')
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Nhu cầu: ', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(widget.thongTinTimKiem['selectedNhuCau'] != null ? widget.thongTinTimKiem['selectedNhuCau'] : '')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('Mức giá: ', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text((widget.thongTinTimKiem['selectedNhuCau'] == 'Cần bán' || widget.thongTinTimKiem['selectedNhuCau'] == 'Cần mua') ?
                                (widget.thongTinTimKiem['selectedValueMucGiaBan'] == null ? '' : widget.thongTinTimKiem['selectedValueMucGiaBan']) :
                              (widget.thongTinTimKiem['selectedValueMucGiaThue'] == null ? '' : widget.thongTinTimKiem['selectedValueMucGiaThue'])
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Hướng: ', style: TextStyle(fontWeight: FontWeight.bold),),
                              alignment: Alignment.topLeft,
                            ),
                            5.width,
                            Container(
                              width: c_width,
                              child: Text((widget.thongTinTimKiem['selectedHuong'].length) > 0 ? widget.thongTinTimKiem['selectedHuong'].join(', ') : ''),

                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Diện tích: ', style: TextStyle(fontWeight: FontWeight.bold),),
                              alignment: Alignment.topLeft,
                            ),
                            5.width,
                            Container(
                                width: c_width,
                                child: Text(widget.thongTinTimKiem['selectedValueDienTich'] != null ? widget.thongTinTimKiem['selectedValueDienTich'] : '')

                            )
                          ],
                        ),
                      ],
                    ),
                    8.height,
                    OutlinedButton.icon(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff19A7CE))),
                        onPressed: (){
                          setState(() {
                            widget.thongTinTimKiem.clear();
                            widget.thongTinTimKiem.putIfAbsent("timKiem", () => false);
                            widget.isLoading = true;
                            widget.start = 0;
                            this.ketQuaNhuCau = '';
                          });
                        }, icon: Icon(Ionicons.refresh, size: 16, color: Colors.white,), label: Text('Khôi phục danh sách', style: TextStyle(color: Colors.white),))
                  ],
                ),
              ) : SizedBox(),
              (ketQuaNhuCau != '')  ? Text(ketQuaNhuCau, style: TextStyle(color: Colors.red),).paddingAll(10) : SizedBox(),
              Container(
                child: Column(
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
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: TextButton(
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
                                                  Icon(Ionicons.search_outline,color: rf_primaryColor, size: 18, ), // icon
                                                  2.width,
                                                  Text("Tìm kết nối",style: TextStyle(fontSize: 12,color: rf_primaryColor)), // text
                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                        flex: 3,
                                      ),
                                      Expanded(child: TextButton(
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
                                                Icon(Ionicons.link_outline, color: rf_primaryColor, size: 18, ), // icon
                                                2.width,
                                                Text("Kết nối ngay",style: TextStyle(
                                                    color: rf_primaryColor,
                                                    fontSize: 12
                                                )), // text
                                              ],
                                            )

                                          ],
                                        ),
                                      ), flex: 3,),
                                      Expanded(child: TextButton(
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
                                                Text("Nhân bản",style: TextStyle(
                                                    color: rf_primaryColor,
                                                    fontSize: 12
                                                )), // text
                                              ],
                                            )

                                          ],
                                        ),
                                      ), flex: 3,),
                                      Expanded(
                                        child: PopupMenuButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: appStore.textPrimaryColor,
                                          ),
                                          onSelected: (dynamic value) {
                                            if(value == 'Xem chi tiết'){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => ChiTietNhuCau(nid: nhuCaus[index].nid.toInt(),)),
                                              );
                                            }
                                            else if(value == 'Sửa'){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => RFFormNhuCauScreen(nid: nhuCaus[index].nid.toInt(),)),
                                              );
                                            }
                                            else{

                                            }
                                          },
                                          itemBuilder: (context) {
                                            List<PopupMenuEntry<Object>> list = [];
                                            list.add(
                                              PopupMenuItem(
                                                child: TextIcon(text: "Xem chi tiết", textStyle: primaryTextStyle(), prefix: Icon(Ionicons.eye, size: 18,),),
                                                value: 'Xem chi tiết',
                                              ),
                                            );
                                            list.add(
                                              PopupMenuItem(
                                                child: TextIcon(text: "Sửa nhu cầu", textStyle: primaryTextStyle(), prefix: Icon(Ionicons.pencil, size: 18,),),
                                                value: 'Sửa',
                                              ),
                                            );
                                            list.add(
                                              PopupMenuItem(
                                                child: TextIcon(text: "Xoá nhu cầu", textStyle: primaryTextStyle(color: Colors.red), prefix: Icon(Ionicons.trash, size: 18, color: Colors.red,),),
                                                value: 'Xoá',
                                              ),
                                            );
                                            return list;
                                          },
                                        ),
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                  Divider(height: 0.5, color: t7view_color, thickness: 1),
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChiTietNhuCau(nid: nhuCaus[index].nid.toInt(),)),
                              );
                            },
                          );
                      },
                    ),
                    widget.start == -2 ? SizedBox() : // Không phân trang
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.start == -1 || widget.start > 10 ? Ink(
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
                                widget.start == -1 ? widget.start = 0 : widget.start -= 20;
                                widget.isLoading = true;
                              });
                              _reloadNhuCau();
                            },
                          ),
                        ) : SizedBox(width: 0,), //Trang cuối hoặc từ trang 2 trở đi
                        widget.start > 10 ? 8.width : 0.width,
                        widget.start >= 10 ? Ink(
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
                              setState(() {
                                widget.isLoading = true;
                              });
                              _reloadNhuCau();
                            },
                          ),
                        ) : SizedBox(),
                      ],
                    )
                  ],
                ),
              )
            ]
        )
      ],
    );
  }
}
