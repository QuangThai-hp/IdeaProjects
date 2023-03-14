import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:search_choices/search_choices.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/NhuCaus.dart';
import '../utils/RFWidget.dart';

class FormTimKiemNhuCau extends StatefulWidget {
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
      if(this.mounted){
        setState(() {
          provider.khuVuc.forEach((element) {
            listQuan.add(DropdownMenuItem(child: Text(element.name), value: element.tid,));
          });
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  late List selectedList;
  var selected;
  String selectedNhuCau = '';
  String selectedHuong = '';
  List<String> selectedListHuong = [];
  int? selectedValueQuan = null;
  TextEditingController textEditingController = TextEditingController();
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
                  print('nhu cầu ${value}');
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
                print(value);
                setState(() {
                  selectedValueQuan = value;
                });
                print(selectedValueQuan);
              },
              isExpanded: true,
            ),
            // SearchChoices.single(
            //   items: listPhuongXa,
            //   value: selectedValue,
            //   hint: "Nhập tên Phường",
            //   searchHint: "Tên Phường",
            //   onChanged: (value) {
            //     setState(() {
            //       selectedValue = value;
            //     });
            //   },
            //   isExpanded: true,
            // ),
            // SearchChoices.single(
            //   items: mucGia,
            //   value: selectedValue,
            //   hint: "Mức giá",
            //   searchHint: "Mức giá",
            //   onChanged: (value) {
            //     setState(() {
            //       selectedValue = value;
            //     });
            //   },
            //   isExpanded: true,
            // ),
            // SearchChoices.single(
            //   items: dienTich,
            //   value: selectedValue,
            //   hint: "Diện tích",
            //   searchHint: "Diện tích",
            //   onChanged: (value) {
            //     setState(() {
            //       selectedValue = value;
            //     });
            //   },
            //   isExpanded: true,
            // ),
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
                print(value.toString());
                if(value!=null)
                {
                  selectedList = jsonDecode(value);
                }
                else{
                  selectedList.clear();
                }
              },
            ),
            16.height,
            GestureDetector(
              onTap: () {
                // finish(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: boxDecoration(bgColor: Colors.indigo, radius: 10),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Center(
                  child: TextIcon(text: "Tìm kiếm", textStyle: boldTextStyle(color: white)),
                ),
              ),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
