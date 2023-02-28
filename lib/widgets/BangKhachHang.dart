import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';

import 'package:provider/provider.dart';

class BangKhachHangList extends StatefulWidget {
  @override
  State<BangKhachHangList> createState() => _BangKhachHangListState();
}

class _BangKhachHangListState extends State<BangKhachHangList> {
  late List<KhachHang> khachHangs = [];
  late String isLoadedData = '';
  bool isExpanded = false;

  Future<void> _reloadKhachHangList(BuildContext context) async{
    final provider = Provider.of<KhachHangs>(context);
    provider.getListKhachHang().then((value){
      setState(() {
        khachHangs = provider.items;
        isLoadedData = '1';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.65;
    double img_width_height = 60;

    if(isLoadedData == '')
      _reloadKhachHangList(context);
    return
      isLoadedData == '' ? Center(
        child: CircularProgressIndicator(),
      ) :
      ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: khachHangs.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          KhachHang dataKhachHang = khachHangs[index];

          return
            GestureDetector(
              child: ListTileTheme(
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  leading: Icon(Icons.home_outlined, color: Colors.brown, size: 30),
                  title: Text('${dataKhachHang.hoTen}', style: primaryTextStyle()),

                  subtitle: Container(
                   child: Text(dataKhachHang.field_dien_thoai.toString(), style: TextStyle(color: Colors.blue),),
                  ),
                  onExpansionChanged: (String nidKhachHang){
                    setState(() {

                    });
                  },

                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.blue.withAlpha(32), borderRadius: radius()),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nhu cầu khách hàng',
                                style: boldTextStyle(size: 18),
                              ).expand(),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius(100)),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: context.iconColor,
                                ),
                              )
                            ],
                          ),
                          16.height,
                          SettingItemWidget(
                            title: 'Design System Tokens',
                            subTitle: '16 March, 2020',
                            leading: Container(
                              padding: EdgeInsets.all(4),
                              decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
                              child: Icon(
                                Icons.personal_injury_rounded,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SettingItemWidget(
                            title: 'Design Specs',
                            subTitle: '18 March, 2018',
                            leading: Container(
                              padding: EdgeInsets.all(4),
                              decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
                              child: Icon(Icons.folder_open, color: Colors.blue),
                            ),
                          ),
                          SettingItemWidget(
                            title: 'Guidelines',
                            subTitle: '31 December, 2020',
                            leading: Container(
                              padding: EdgeInsets.all(4),
                              decoration: boxDecorationDefault(color: Colors.blue.withAlpha(32), borderRadius: radius()),
                              child: Icon(Icons.folder_open, color: Colors.blue),
                            ),
                          ),
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                          ).paddingAll(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppButton(
                                onTap: () {},
                                color: context.cardColor,
                                shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                                text: 'Purchase Me',
                                textStyle: primaryTextStyle(),
                                padding: EdgeInsets.all(8),
                              ),
                              8.width,
                              AppButton(
                                onTap: () {},
                                shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                                text: 'I want this Kit',
                                textStyle: primaryTextStyle(color: Colors.white),
                                padding: EdgeInsets.all(8),
                                color: Colors.blueAccent,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
              },
            );
        },
    );
  }
}
