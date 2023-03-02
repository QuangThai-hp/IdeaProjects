import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/screens/RFFormSuaKhachHang.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';


import 'package:provider/provider.dart';
import 'package:room_finder_flutter/widgets/ListNhuCauInnerCustomer.dart';

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
                  leading: Icon(Icons.person_2_outlined, color: Colors.brown, size: 30),
                  title: Text('${dataKhachHang.hoTen}', style: primaryTextStyle()),
                  subtitle: Container(
                    child: Text(dataKhachHang.field_dien_thoai.toString(), style: TextStyle(color: Colors.blue),),
                  ),
                  onExpansionChanged: (expansion){
                    if(expansion){
                      SanPhams sanPham = Provider.of<SanPhams>(context, listen: false);
                      sanPham.getListNhuCau(dataKhachHang.nid.toInt()).then((value){
                        setState(() {
                          dataKhachHang.sanPham = sanPham.items;
                        });
                      });
                    }
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
                                'Nhu cầu',
                                style: boldTextStyle(size: 18),
                              ).expand(),
                            ],
                          ),
                          16.height,
                          ListNhuCauInnerCustomer(sanPham: dataKhachHang.sanPham,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RFFormSuaKhachHang(nid: dataKhachHang.nid,name: dataKhachHang.hoTen,phone: dataKhachHang.field_dien_thoai,)
                                  )
                                  );

                                setState(() {

                                });

                                },
                                icon: Icon( // <-- Icon
                                  Icons.edit,
                                  size: 24.0,
                                ),
                                label: Text('Sửa'), // <-- Text
                              ),
                              8.width,
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon( // <-- Icon
                                  Icons.delete,
                                  size: 24.0,
                                ),
                                label: Text('Xóa'), // <-- Text
                              ),
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
