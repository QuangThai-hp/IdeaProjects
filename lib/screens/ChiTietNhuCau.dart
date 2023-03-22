import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

import '../main.dart';
import '../main/utils/dots_indicator/src/dots_decorator.dart';
import '../main/utils/dots_indicator/src/dots_indicator.dart';
import '../providers/NhuCau.dart';
import '../providers/NhuCaus.dart';
import '../utils/RFString.dart';
import '../utils/RFWidget.dart';
import 'RFHomeScreen.dart';
import 'package:provider/provider.dart';

class ChiTietNhuCau extends StatefulWidget {
  final int? nid;

  const ChiTietNhuCau({Key? key, this.nid}) : super(key: key);

  @override
  State<ChiTietNhuCau> createState() => _ChiTietNhuCauState();
}

class _ChiTietNhuCauState extends State<ChiTietNhuCau> {
  PageController pageController = PageController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var currentIndexPage = 0;
  bool nhuCauLoaded = false;
  NhuCau nhuCau = NhuCau(hinhAnhs: [RFNoImage], quanHuyen: KhuVuc(tid: 0, name: '', type: ''), phuongXa: KhuVuc(tid: 0, name: '', type: ''));

  @override
  void initState() {
    _loadNhuCau();
    Timer.periodic(Duration(seconds: 5), (_) => {
      // print(currentIndexPage)
      setState(() {
        currentIndexPage = currentIndexPage + 1;
        if(currentIndexPage == nhuCau.hinhAnhs.length)
          currentIndexPage = 0;
        pageController.animateToPage(currentIndexPage, duration: Duration(seconds: 1), curve: Curves.easeIn);
      })
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadNhuCau() async{
    if(!nhuCauLoaded){
      print(widget.nid);
      NhuCaus nhuCaus = await Provider.of<NhuCaus>(context, listen: false);

      nhuCaus.getNhuCauByNid(widget.nid!).then((value){
        setState(() {
          nhuCauLoaded = true;
          nhuCau = nhuCaus.nhuCau;
        });
        print(nhuCau.hinhAnhs);
      });
    }

  }

  List<Widget> getSlider(){
    List<Widget> sliders = [];
    nhuCau.hinhAnhs.forEach((element) {
      sliders.add(Slider(file: element));
    });
    return sliders;
  }

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget() {
      return BackButton(
        color: appStore.textPrimaryColor,
        onPressed: () {
          // toasty(context, 'Back button');
          // RFHomeScreen rf_home = new RFHomeScreen();
          // rf_home.selectedIndex = 0;
          // rf_home.launch(context);
          Navigator.pop(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin nhu cầu', style: boldTextStyle(color: appStore.textPrimaryColor)),
        backgroundColor: Colors.white,
        leading: leadingWidget()
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 0, bottom: 20),
        child: Column(
          children: [
            Container(
              width: context.width(),
              height: context.width(),
              child: PageView(
                controller: pageController,
                children: getSlider(),
                onPageChanged: (int i) {
                  setState(() {
                    currentIndexPage = i;
                  });
                },
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(0),
              child: DotsIndicator(
                  dotsCount: nhuCau.hinhAnhs.length,
                  position: currentIndexPage,
                  decorator: DotsDecorator(
                    size: Size.square(8.0),
                    activeSize: Size.square(10.0),
                    color: t1_view_color,
                    activeColor: rf_primaryColor,
                  )

              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  Container(
                    child: Text(nhuCau.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    alignment: Alignment.topLeft,
                  ),
                  8.height,
                  Container(
                    child: Text(nhuCau.ghiChu),
                    alignment: Alignment.topLeft,
                  ),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Sale', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.person, size: 18,),),
                      Container(
                        child: InkWell(
                          child: Text(nhuCau.hoTen, style: TextStyle(color: rf_primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
                          onTap: () => {
                            Clipboard.setData(ClipboardData(text: nhuCau.field_dien_thoai))
                                .then((value) { //only if ->
                              final snackBar = SnackBar(
                                content: Text('Đã sao chép số điện thoại người nhập'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar); // -> show a notification
                            })
                          },
                        ),
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Nhu cầu', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.help_circle, size: 18,),),
                      Text(nhuCau.nhuCau, style: secondaryTextStyle()),
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Quận huyện', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.map_sharp, size: 18,),),
                      Text(nhuCau.quanHuyen.name, style: secondaryTextStyle()),
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Phường xã', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.navigate, size: 18,),),
                      Text(nhuCau.phuongXa.name, style: secondaryTextStyle()),
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Đường phố', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.trail_sign, size: 18,),),
                      Text(nhuCau.field_duong_pho, style: secondaryTextStyle()),
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Ngõ', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.pause, size: 18,),),
                      Text("${nhuCau.field_do_rong_ngo.toString()} m", style: secondaryTextStyle()),
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Giá bán', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Icons.monetization_on_sharp, size: 18,),),
                      text(
                          NumberFormat.currency(locale: 'vi', symbol: '').format( nhuCau.field_gia == null ? 0 : nhuCau.field_gia), textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      ),
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Hướng', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.compass, size: 18,),),
                      // Text(nhuCau.field_huong, style: TextStyle(fontSize: 18),)
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Diện tích', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.expand_outline, size: 18,),),
                      text(
                          "${NumberFormat.currency(locale: 'vi', symbol: '').format( nhuCau.dienTichSuDung)} m2",
                          textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Phòng ngủ', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Icon(Ionicons.bed, size: 18,),),
                      text(
                          nhuCau.soPhongNgu.toString(),
                          textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'WC', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Row(
                        children: [
                          Icon(Ionicons.man, size: 18,),
                          Icon(Ionicons.woman, size: 18,),
                        ],
                      ),),
                      text(
                          nhuCau.SoPhongVeSinh.toString(),
                          textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Pháp lý', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Row(
                        children: [
                          Icon(Ionicons.document, size: 18,),
                        ],
                      ),),
                      text(
                          nhuCau.thongTinPhapLy.toString(),
                          textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Xếp loại', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Row(
                        children: [
                          Icon(Ionicons.star, size: 18,),
                        ],
                      ),),
                      text(
                          nhuCau.field_xep_hang_san_pham.toString(),
                          textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(text: 'Chính chủ', textStyle: TextStyle(fontWeight: FontWeight.bold), prefix: Row(
                        children: [
                          Icon(Ionicons.checkmark_circle, size: 18,),
                        ],
                      ),),
                      text(
                          nhuCau.field_san_pham_chinh_chu.toString() == 0 ? 'Không chính chủ' : 'SP Chính chủ',
                          textColor: t7textColorSecondary, fontSize: textSizeSMedium
                      )
                    ],
                  ).paddingOnly(top: 8, bottom: 8),
                  Divider(color: context.dividerColor, height: 0),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text('Tình trạng nội thất', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: Text(nhuCau.tinhTrangNoiThat == '' ? 'Không có thông tin' : nhuCau.tinhTrangNoiThat),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  Divider(color: context.dividerColor, height: 0),

                ],
              ),
            )

          ],
        ),
      )
    );
  }
}

class Slider extends StatelessWidget {
  final String file;

  Slider({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          child: CachedNetworkImage(
            placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
            imageUrl: file,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Material(child: Icon(Icons.broken_image, size:  20,),),
          )),
    );
  }
}