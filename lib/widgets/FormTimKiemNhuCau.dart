import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:search_choices/search_choices.dart';

import '../main.dart';
import '../utils/RFWidget.dart';

class FormTimKiemNhuCau extends StatefulWidget {
  @override
  State<FormTimKiemNhuCau> createState() => _FormTimKiemNhuCauState();
}

class _FormTimKiemNhuCauState extends State<FormTimKiemNhuCau> {
  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<int>>();

  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  List<DropdownMenuItem> items = [];

  @override
  void initState() {
    // TODO: implement initState
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = "$word ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
          return (item.value == wordPair);
        }) ==
            -1) {
          items.add(DropdownMenuItem(
            value: wordPair,
            child: Text(wordPair),
          ));
        }
        wordPair = "";
      }
    });
    super.initState();
  }

  String selectedValue = '';
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
              items: items,
              value: selectedValue,
              hint: "Chọn nhu cầu",
              searchHint: "Nhu cầu",
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              isExpanded: true,
            ),
            SearchChoices.single(
              items: items,
              value: selectedValue,
              hint: "Nhập tên Quận",
              searchHint: "Tên Quận",
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              isExpanded: true,
            ),
            SearchChoices.single(
              items: items,
              value: selectedValue,
              hint: "Nhập tên Phường",
              searchHint: "Tên Phường",
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              isExpanded: true,
            ),
            SearchChoices.single(
              items: items,
              value: selectedValue,
              hint: "Mức giá",
              searchHint: "Mức giá",
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              isExpanded: true,
            ),
            SearchChoices.single(
              items: items,
              value: selectedValue,
              hint: "Diện tích",
              searchHint: "Diện tích",
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              isExpanded: true,
            ),
            30.height,
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
