import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:search_choices/search_choices.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/NhuCaus.dart';
import '../providers/khuVucs.dart';
import '../utils/RFWidget.dart';

class FormTimKiemNhuCau extends StatefulWidget {
  final Function(Map<String, dynamic>) callback;

  FormTimKiemNhuCau({required this.callback});

  @override
  State<FormTimKiemNhuCau> createState() => _FormTimKiemNhuCauState();
}

class _FormTimKiemNhuCauState extends State<FormTimKiemNhuCau> {

  List<DropdownMenuItem> nhuCaus = [
    DropdownMenuItem(
      value: 'Cần mua',
      child: Text('Cần mua'),
    ),
    DropdownMenuItem(
      value: 'Cần bán',
      child: Text('Cần bán'),
    ),
    DropdownMenuItem(
      value: 'Cần thuê',
      child: Text('Cần thuê'),
    ),
    DropdownMenuItem(
      value: 'Cho thuê',
      child: Text('Cho thuê'),
    ),
  ];

  List listToSearch=['Đông', 'Tây', 'Nam','Bắc', 'Đông Nam', 'Đông Bắc', 'Tây Nam', 'Tây Bắc', 'Đông Tứ Trạch', 'Tây Tứ Trạch'];

  List<DropdownMenuItem> listQuan = [];
  List<DropdownMenuItem> listPhuongXa = [];
  List<DropdownMenuItem> mucGiaChoThue = [];
  List<DropdownMenuItem> mucGiaBan = [];
  List<DropdownMenuItem> mucGia = [];
  List<DropdownMenuItem> dienTich = [];


  List<dynamic> selectedList = [];
  var selected;
  String selectedNhuCau = '';
  String selectedHuong = '';
  List<String> selectedListHuong = [];
  String? selectedValueQuan = null;
  String? selectedValuePhuong = null;
  String? selectedValueMucGiaBan = null;
  String? selectedValueMucGiaThue = null;
  String? selectedValueDienTich = null;
  bool gettingPhuongByQUan = false;

  List<DropdownMenuItem> listHuong = [ //'', '', '','', '', 'Đông ', '', 'Tây ', '', ''
    DropdownMenuItem(
      value: 'Đông',
      child: Text('Đông'),
    ),
    DropdownMenuItem(
      value: 'Tây',
      child: Text('Tây'),
    ),
    DropdownMenuItem(
      value: 'Nam',
      child: Text('Nam'),
    ),
    DropdownMenuItem(
      value: 'Bắc',
      child: Text('Bắc'),
    ),
    DropdownMenuItem(
      value: 'Đông Nam',
      child: Text('Đông Nam'),
    ),
    DropdownMenuItem(
      value: 'Đông Bắc',
      child: Text('Đông Bắc'),
    ),
    DropdownMenuItem(
      value: 'Đông Bắc',
      child: Text('Đông Bắc'),
    ),
    DropdownMenuItem(
      value: 'Tây Nam',
      child: Text('Tây Nam'),
    ),
    DropdownMenuItem(
      value: 'Tây Bắc',
      child: Text('Tây Bắc'),
    ),
    DropdownMenuItem(
      value: 'Đông Tứ Trạch',
      child: Text('Đông Tứ Trạch'),
    ),
    DropdownMenuItem(
      value: 'Tây Tứ Trạch',
      child: Text('Tây Tứ Trạch'),
    ),
  ];

  @override
  void initState() {
    final provider = Provider.of<NhuCaus>(context, listen: false);
    provider.khoiTaoTimKiemNhuCau().then((value){
      setState(() {
        listQuan = [];
        listPhuongXa.clear();
        mucGia.clear();
        mucGiaBan.clear();
        mucGiaChoThue.clear();
        dienTich.clear();
      });


      if(this.mounted){
        provider.khuVuc.forEach((element) {
          setState(() {
            listQuan.add(DropdownMenuItem(child: Text(element.name), value: element.name,));
          });
        });
        provider.mucGiaNhaBan.forEach((element) {
          setState(() {
            mucGiaBan.add(DropdownMenuItem(child: Text(element['value']), value: element['value'],));
          });
        });
        provider.mucGiaThue.forEach((element) {
          setState(() {
            mucGiaChoThue.add(DropdownMenuItem(child: Text(element['value']), value: element['value'],));
          });
        });
        provider.mucGiaThue.forEach((element) {
          setState(() {
            mucGiaChoThue.add(DropdownMenuItem(child: Text(element['value']), value: element['value'],));
          });
        });
        provider.dienTich.forEach((element) {
          setState(() {
            dienTich.add(DropdownMenuItem(child: Text(element['value']), value: element['value'],));
          });
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  Future<void> _loadPhuongXaByNameQuan(String nameQuan) async{
    setState(() {
      gettingPhuongByQUan = true;
      selectedValuePhuong = null;
      listPhuongXa = [];
    });

    {
      KhuVucs khuVucs = await Provider.of<KhuVucs>(context, listen: false);
      khuVucs.getListPhuongXaByNameQuan(
          nameQuan,
        context
      ).then((value){
        setState(() {
          khuVucs.items.forEach((element) {
            listPhuongXa.add(DropdownMenuItem(child: Text(element.name), value: element.name,));
          });
          gettingPhuongByQUan = false;
        });
      });
    }
  }

  // const FormTimKiemNhuCau({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  finish(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tìm kiếm nhu cầu', style: boldTextStyle(color: appStore.textPrimaryColor, size: 20)),
                    Container(padding: EdgeInsets.all(4), alignment: Alignment.centerRight, child: Icon(Icons.close, color: appStore.textPrimaryColor)),
                  ],
                )
              ),
              SearchChoices.single(
                items: nhuCaus,
                value: selectedNhuCau,
                hint: "Chọn nhu cầu",
                searchHint: "Nhu cầu",
                onChanged: (value) {
                  setState(() {
                    selectedNhuCau = value;

                  });
                },
                isExpanded: true,
              ),
              listQuan.length == 0 ? Center(child: CircularProgressIndicator(),) : SearchChoices.single(
                items: listQuan,
                value: selectedValueQuan,
                hint: "Nhập tên Quận",
                searchHint: "Tên Quận",
                onChanged: (value) {
                  setState(() {
                    selectedValueQuan = value;
                  });
                  _loadPhuongXaByNameQuan(value);
                },
                isExpanded: true,
              ),
              gettingPhuongByQUan ? Center(child: CircularProgressIndicator(),) : SearchChoices.single(
                items: listPhuongXa,
                value: selectedValuePhuong,
                hint: "Nhập tên Phường",
                searchHint: "Tên Phường",
                onChanged: (value) {
                  setState(() {
                    selectedValuePhuong = value;
                  });
                },
                isExpanded: true,
              ),
              selectedNhuCau == "Cần mua" || selectedNhuCau == "Cần bán" ? SearchChoices.single(
                items: mucGiaBan,
                value: selectedValueMucGiaBan,
                hint: "Mức giá bán",
                searchHint: "Mức giá",
                onChanged: (value) {
                  setState(() {
                    selectedValueMucGiaBan = value;
                  });
                },
                isExpanded: true,
              ) : (
                  selectedNhuCau == "Cần thuê" || selectedNhuCau == "Cho thuê" ? SearchChoices.single(
                    items: mucGiaChoThue,
                    value: selectedValueMucGiaThue,
                    hint: "Mức giá thuê",
                    searchHint: "Mức giá",
                    onChanged: (value) {
                      setState(() {
                        selectedValueMucGiaThue = value;
                      });
                    },
                    isExpanded: true,
                  ) : SizedBox()
              ),
              SearchChoices.single(
                items: dienTich,
                value: selectedValueDienTich,
                hint: "Khoảng diện tích",
                searchHint: "Diện tích",
                onChanged: (value) {
                  setState(() {
                    selectedValueDienTich = value;
                  });
                },
                isExpanded: true,
              ),
              CustomSearchableDropDown(
                initialValue: [],
                items: listToSearch,
                label: 'Chọn hướng',
                multiSelectTag: 'Hướng',
                multiSelectValuesAsWidget: true,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue
                    ),
                ),
                multiSelect: true,
                hint: 'Từ khoá tìm kiếm ...',
                prefixIcon:  Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                dropDownMenuItems: listToSearch.map((item) {
                  return item;
                }).toList() ?? [],
                onChanged: (value){
                  if(value!=null)
                  {
                    setState(() {
                      selectedList = jsonDecode(value);
                    });
                  }
                  else{
                    selectedList.clear();
                  }
                },
              ),
              Container(
                // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: OutlinedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff2192FF)) ,
                    ),
                    onPressed: (){
                      print({
                        "selectedValueQuan": selectedValueQuan,
                        "selectedValuePhuong": selectedValuePhuong,
                        "selectedHuong": selectedList,
                        "selectedNhuCau": selectedNhuCau,
                        "selectedValueMucGiaBan": selectedValueMucGiaBan,
                        "selectedValueMucGiaThue": selectedValueMucGiaThue,
                        "selectedValueDienTich": selectedValueDienTich,
                        "timKiem": true
                      });
                      widget.callback({
                        "selectedValueQuan": selectedValueQuan,
                        "selectedValuePhuong": selectedValuePhuong,
                        "selectedHuong": selectedList,
                        "selectedNhuCau": selectedNhuCau,
                        "selectedValueMucGiaBan": selectedValueMucGiaBan,
                        "selectedValueMucGiaThue": selectedValueMucGiaThue,
                        "selectedValueDienTich": selectedValueDienTich,
                        "timKiem": true
                      });
                      Navigator.of(context, rootNavigator: true).pop();
                      // print(selectedValueQuan);
                    },
                    icon: Icon(Ionicons.search, size: 16, color: Colors.white,),
                    label: Text('Tìm kiếm', style: TextStyle(color: Colors.white),),
                  ),
                  // child: TextIcon(text: "Tìm kiếm", textStyle: boldTextStyle(color: white)),
                ),
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
