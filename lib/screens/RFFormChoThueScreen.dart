import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';

import '../providers/CaNhan.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import '../widgets/cupertino_flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/CaNhan.dart';
import 'package:room_finder_flutter/providers/CaNhans.dart';
import 'package:room_finder_flutter/providers/thems.dart';
import 'package:room_finder_flutter/common/data.dart';
class RFFormChoThueScreen extends StatefulWidget {
  static const routeName = '/form-sp-cho-thue';

  @override
  _RFFormChoThueScreenState createState() => _RFFormChoThueScreenState();
}

class _RFFormChoThueScreenState extends State<RFFormChoThueScreen> {
  TextEditingController ngayNhapController = TextEditingController();
  TextEditingController hoTenKhachHangController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();
  TextEditingController soPhongNguController = TextEditingController();
  TextEditingController soPhongVeSinhController = TextEditingController();
  TextEditingController soTangController = TextEditingController();
  TextEditingController phapLyController = TextEditingController();
  TextEditingController tinhTrangNoiThatController = TextEditingController();
  TextEditingController giaController = TextEditingController();
  TextEditingController dienTichController = TextEditingController();
  TextEditingController dienTichSuDungController = TextEditingController();
  TextEditingController chieuDaiController = TextEditingController();
  TextEditingController chieuRongController = TextEditingController();
  TextEditingController tienDatCocController = TextEditingController();
  TextEditingController tieuDeSanPhamController = TextEditingController();


  CupertinoSuggestionsBoxController _suggestionsLoaiBatDongSanController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeLoaiBatDongSanController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsNguonKhachController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeNguonKhachController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsChiNhanhController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeChiNhanhController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsNhanSuController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeNhanSuController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsNhomSanPhamController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeNhomSanPhamController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsNhomNhuCauController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeNhomNhuCauController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsLoaiHinhController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeLoaiHinhController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsQuanHuyenController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeQuanHuyenController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsDonViTinhController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeDonViTinhController = TextEditingController();


  CupertinoSuggestionsBoxController _suggestionsLoaiHoaHongController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeLoaiHoaHongController = TextEditingController();


  String nguonKhachNhuCau='--Nguồn khách--';
  String huongNhuCau = '-- Hướng --';
  String nhomNhuCau = 'Cho thuê';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode ngayNhapFocusNode = FocusNode();
  FocusNode hoTenKhachHangFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();
  FocusNode soPhongNguFocusNode = FocusNode();
  FocusNode soPhongVeSinhFocusNode = FocusNode();
  FocusNode soTangFocusNode = FocusNode();
  FocusNode phapLyFocusNode = FocusNode();
  FocusNode tinhTrangNoiThatFocusNode = FocusNode();
  FocusNode giaFocusNode = FocusNode();
  FocusNode dienTichFocusNode = FocusNode();
  FocusNode dienTichSuDugFocusNode = FocusNode();
  FocusNode chieuDaiFocusNode = FocusNode();
  FocusNode chieuRongFocusNode = FocusNode();
  FocusNode tienDatCocFocusNode = FocusNode();
  FocusNode tieuDeSanPhamFocusNode = FocusNode();

  FocusNode f4 = FocusNode();

  DateTime? selectedDate;
  String buaAn = '';
  bool _isLoading = false;

  String ngayNhapDefault = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';




  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //LoaiBatDongSan
  }
  Future<void> _submit() async{
    setState(() {
      _isLoading = true;
    });
    try
    {
      await Provider.of<ThemCaNhans>(context, listen: false).save(
        'Cần bán',
          hoTenKhachHangController.text,
          dienThoaiController.text,
          tieuDeSanPhamController.text,

          context
      );
    }
    on HttpException catch(error){
      showErrorDialog(error.message, context);
    }
    catch (error){
      print(error);
      showErrorDialog('Could not authentication you. Please again later', context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  String formatDate(String? dateTime, {String format = DATE_FORMAT_2, bool isFromMicrosecondsSinceEpoch = false}) {
    if (isFromMicrosecondsSinceEpoch) {
      return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000));
    } else {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    }
  }

  void selectDateAndTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn ? ThemeData.dark() : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        ngayNhapController.text = "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: "Thêm cá nhân",
        mainWidgetHeight: 150,
        subWidgetHeight: 115,

        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    //thong tin ca nhan
                    //thong tin ho ten
                    AppTextField(
                      controller: hoTenKhachHangController,
                      focus: hoTenKhachHangFocusNode,
                      nextFocus: dienThoaiFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Họ tên cá nhân",
                        showLableText: true,
                      ),
                    ),
                    6.height,
                    //thong tin so dien thoai
                    AppTextField(
                      controller: dienThoaiController,
                      focus: dienThoaiFocusNode,
                      nextFocus: soPhongNguFocusNode,
                      textFieldType: TextFieldType.PHONE,
                      decoration: rfInputDecoration(
                        lableText: "Điện thoại cá nhân",
                        showLableText: true,
                      ),
                    ),
                    6.height,
                    //thong tin nguon khach
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,

                      suggestionsBoxController: _suggestionsNguonKhachController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeNguonKhachController,
                          style: TextStyle(
                            fontSize: 16,

                          ),
                          placeholder:"Nguồn Khách" ,
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getNguonKhach(pattern, context);

                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },

                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(

                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeNguonKhachController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //thong tin chi nhanh
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsChiNhanhController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeChiNhanhController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Chi nhánh",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getChiNhanh(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeChiNhanhController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,


                    //thong tin nhan su

                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsNhanSuController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeNhanSuController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: ("Nhân sự"),

                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getNhanSu(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeNhanSuController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    16.height,
                    // thong tin san pham
                    Container(
                      alignment: Alignment.centerLeft,
                     child: Text("Thông tin sản phẩm", style: boldTextStyle(size: 18)),
                    ),
                    16.height,


                    //thong tin loai bat dong san
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,

                      suggestionsBoxController: _suggestionsLoaiBatDongSanController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeLoaiBatDongSanController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Loai Bat Dong San",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getSuggestions(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeLoaiBatDongSanController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //thong tin nhom san pham
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsNhomSanPhamController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeNhomSanPhamController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Nhóm sản phẩm",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getNhomSanPham(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );

                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),

                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeNhomSanPhamController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //thong tin phan loai
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsNhomNhuCauController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeNhomNhuCauController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Nhóm Nhu Cầu",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getNhomNhuCau(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeNhomNhuCauController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //thong tin loai hinh
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsLoaiHinhController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeLoaiHinhController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Loại Hình",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getLoaiHinh(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeLoaiHinhController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //Quan huyen xa
                    Row(
                      children: <Widget>[
                        Expanded(child: CupertinoTypeAheadFormField(
                          getImmediateSuggestions: true,
                          suggestionsBoxController: _suggestionsQuanHuyenController,
                          textFieldConfiguration: CupertinoTextFieldConfiguration(
                              controller: _typeQuanHuyenController,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              placeholder: "Quận Huyện",
                              padding: EdgeInsets.all(14)
                          ),
                          suggestionsCallback: (pattern) {
                            CitiesService citis = new CitiesService();
                            citis.getQuanHuyen(pattern, context);
                            return Future.delayed(
                                Duration(seconds: 1),
                                    () => citis.matches
                            );
                          },
                          itemBuilder: (context, String suggestion) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                suggestion,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    color: Colors.black
                                ),
                              ),
                            );
                          },
                          onSuggestionSelected: (String suggestion) {
                            _typeQuanHuyenController.text = suggestion;
                          },
                          validator: (value) =>
                          value!.isEmpty ? 'Chọn loại bất động sản' : null,
                        ),),
                        8.width,
                        Expanded(child: CupertinoTypeAheadFormField(
                          getImmediateSuggestions: true,
                          suggestionsBoxController: _suggestionsLoaiBatDongSanController,
                          textFieldConfiguration: CupertinoTextFieldConfiguration(
                              controller: _typeLoaiBatDongSanController,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              padding: EdgeInsets.all(14)
                          ),
                          suggestionsCallback: (pattern) {
                            CitiesService citis = new CitiesService();
                            citis.getSuggestions(pattern, context);
                            return Future.delayed(
                                Duration(seconds: 1),
                                    () => citis.matches
                            );
                          },
                          itemBuilder: (context, String suggestion) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                suggestion,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    color: Colors.black
                                ),
                              ),
                            );
                          },
                          onSuggestionSelected: (String suggestion) {
                            _typeLoaiBatDongSanController.text = suggestion;
                          },
                          validator: (value) =>
                          value!.isEmpty ? 'Chọn loại bất động sản' : null,
                        ),
                        )
                      ],
                    ),
                    //Don vi Tinh
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsDonViTinhController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeDonViTinhController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Đơn vị tính",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getDonViTinh(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeDonViTinhController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //Hoa hồng
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsLoaiHoaHongController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: _typeLoaiHoaHongController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Loại Hoa Hồng",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getLoaiHoaHong(pattern, context);
                        return Future.delayed(
                            Duration(seconds: 1),
                                () => citis.matches
                        );
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                color: Colors.black
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeLoaiHoaHongController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    6.height,
                    //thong tin duong pho


                    //thong tin dia chi
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                        backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                      ),
                      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: DropdownButton<String>(
                        value: nhomNhuCau,
                        elevation: 16,
                        style: primaryTextStyle(),
                        hint: Text('Nhóm nhu cầu', style: primaryTextStyle()),
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            nhomNhuCau = newValue.toString();
                          });
                        },
                        items: <String>[].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    AppTextField(
                      controller: tieuDeSanPhamController,
                      focus: tieuDeSanPhamFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Địa chỉ",
                        showLableText: true,
                      ),
                    ),
                    6.height,
                    AppTextField(
                      controller: tieuDeSanPhamController,
                      focus: tieuDeSanPhamFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Tiêu đề sản phẩm",
                        showLableText: true,
                      ),
                    ),
                    16.height,
                    Row(
                      children: <Widget>[
                        Expanded(child: AppTextField(
                          controller: soPhongNguController,
                          focus: soPhongNguFocusNode,
                          nextFocus: soPhongVeSinhFocusNode,
                          textFieldType: TextFieldType.PHONE,
                          decoration: rfInputDecoration(
                            lableText: "Số phòng ngủ",
                            showLableText: true,
                          ),
                        )),
                        8.width,
                        Expanded(child: AppTextField(
                          controller: soPhongVeSinhController,
                          focus: soPhongVeSinhFocusNode,
                          nextFocus: soTangFocusNode,
                          textFieldType: TextFieldType.PHONE,
                          decoration: rfInputDecoration(
                            lableText: "Số phòng vệ sinh",
                            showLableText: true,
                          ),
                        ),
                      )
                      ],
                    ),
                    16.height,
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                        backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                      ),
                      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: DropdownButton<String>(
                        value: nhomNhuCau,
                        elevation: 16,
                        style: primaryTextStyle(),
                        hint: Text('Nhóm nhu cầu', style: primaryTextStyle()),
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            nhomNhuCau = newValue.toString();
                          });
                        },
                        items: <String>[].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                            backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                          ),
                          padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: DropdownButton<String>(
                            value: huongNhuCau,
                            elevation: 16,
                            style: primaryTextStyle(),
                            hint: Text('Hướng', style: primaryTextStyle()),
                            isExpanded: true,
                            underline: Container(
                              height: 0,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                huongNhuCau = newValue.toString();
                              });
                            },
                            items: <String>['-- Hướng --', 'Đông', 'Tây', 'Nam','Bắc', 'Đông Nam', 'Đông Bắc', 'Tây Nam', 'Tây Bắc', 'Đông tứ trạch', 'Tây tứ trạch'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
                        8.width,
                        Expanded(child: AppTextField(
                          controller: soTangController,
                          focus: soTangFocusNode,
                          nextFocus: phapLyFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Số tầng',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        )),
                      ],
                    ),
                    16.height,
                    AppTextField(
                      controller: phapLyController,
                      focus: phapLyFocusNode,
                      nextFocus: tinhTrangNoiThatFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Thông tin pháp lý",
                        showLableText: true,
                      ),
                      minLines: 3,
                      maxLines: 100,
                    ),
                    16.height,
                    AppTextField(
                      controller: tinhTrangNoiThatController,
                      focus: tinhTrangNoiThatFocusNode,
                      nextFocus: giaFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Tình trạng nội thất",
                        showLableText: true,
                      ),
                      minLines: 3,
                      maxLines: 100,
                    ),
                    16.height,
                    AppTextField(
                      controller: giaController,
                      focus: giaFocusNode,
                      nextFocus: dienTichFocusNode,
                      decoration: rfInputDecoration(
                        showLableText: true,
                        lableText: 'Giá (triệu đồng)',
                      ),
                      inputFormatters: [
                        ThousandsFormatter(allowFraction: true),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                      textFieldType: TextFieldType.NUMBER,
                    ),
                    16.height,
                    AppTextField(
                      controller: dienTichController,
                      focus: dienTichFocusNode,
                      nextFocus: chieuDaiFocusNode,
                      decoration: rfInputDecoration(
                        showLableText: true,
                        lableText: 'Diện tích đất',
                      ),
                      inputFormatters: [
                        ThousandsFormatter(allowFraction: true),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                      textFieldType: TextFieldType.NUMBER,
                    ),
                    16.height,
                    Row(
                      children: [
                        Expanded(child: AppTextField(
                          controller: chieuDaiController,
                          focus: chieuDaiFocusNode,
                          nextFocus: chieuRongFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Chiều dài',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        )),
                        8.width,
                        Expanded(child: AppTextField(
                          controller: chieuRongController,
                          focus: chieuRongFocusNode,
                          nextFocus: dienTichSuDugFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Chiều rộng',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        ))
                      ],
                    ),
                    16.height,
                    AppTextField(
                      controller: dienTichSuDungController,
                      focus: dienTichSuDugFocusNode,
                      nextFocus: tienDatCocFocusNode,
                      decoration: rfInputDecoration(
                        showLableText: true,
                        lableText: 'Diện tích sử dụng',
                      ),
                      inputFormatters: [
                        ThousandsFormatter(allowFraction: true),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                      textFieldType: TextFieldType.NUMBER,
                    ),
                    16.height,
                    AppTextField(
                      controller: tienDatCocController,
                      focus: tienDatCocFocusNode,
                      nextFocus: tieuDeSanPhamFocusNode,
                      decoration: rfInputDecoration(
                        showLableText: true,
                        lableText: 'Số tiền cọc (triệu đồng)',
                      ),
                      inputFormatters: [
                        ThousandsFormatter(allowFraction: true),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                      textFieldType: TextFieldType.NUMBER,
                    ),
                    16.height,
                    TextFormField(
                      controller: ngayNhapController,
                      focusNode: ngayNhapFocusNode,
                      readOnly: true,
                      onTap: () {
                        selectDateAndTime(context);
                      },
                      onFieldSubmitted: (v) {
                        ngayNhapFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(f4);
                      },
                      decoration: inputDecoration(
                        context,
                        hintText: "Ngày nhập",
                        suffixIcon: Icon(Icons.calendar_month_rounded, size: 16, color: appStore.isDarkModeOn ? white : gray),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        subWidget:
            Column(
              children: [
                if(_isLoading)
                  CircularProgressIndicator()
                else
                  Container(
                    padding: EdgeInsets.all(20),
                    child: AppButton(
                      color: rf_primaryColor,
                      child: Text('Lưu lại', style: boldTextStyle(color: white)),
                      width: context.width(),
                      elevation: 0,
                      onTap: () {
                        _submit();
                        // RFHomeScreen().launch(context);
                      },
                    ),
                  ),
                8.height,
                rfCommonRichText(title: "Huỷ nhập dữ liệu. ", subTitle: "Quay lại").paddingAll(8).onTap(
                  () {
                        RFHomeScreen rf_home = new RFHomeScreen();
                        rf_home.selectedIndex = 3;
                        rf_home.launch(context);
                        // rf_search.
                    // Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route)=>false);
                  },
                ),
              ],
            )
        // subWidget: rfCommonRichText(title: "Bạn đã có tài khoản? ", subTitle: "Đăng nhập ngay").paddingAll(8).onTap(
        //   () {
        //     Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route)=>false);
        //   },
        // ),
      ),
    );
  }
}
