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
  TextEditingController soCanController = TextEditingController();
  TextEditingController phapLyController = TextEditingController();
  TextEditingController tinhTrangNoiThatController = TextEditingController();
  TextEditingController giaController = TextEditingController();
  TextEditingController dienTichController = TextEditingController();
  TextEditingController dienTichSuDungController = TextEditingController();
  TextEditingController chieuDaiController = TextEditingController();
  TextEditingController chieuRongController = TextEditingController();
  TextEditingController tienDatCocController = TextEditingController();
  TextEditingController tieuDeSanPhamController = TextEditingController();
  TextEditingController duongPhoController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController duongNgoTruocNhaController = TextEditingController();
  TextEditingController hoaHongController = TextEditingController();
  TextEditingController ghiChuController = TextEditingController();
  TextEditingController LoaiBatDongSanController = TextEditingController();
   TextEditingController NguonKhachController = TextEditingController();
  TextEditingController ChiNhanhController = TextEditingController();
   TextEditingController NhanSuController = TextEditingController();
   TextEditingController NhomSanPhamController = TextEditingController();
   TextEditingController NhomNhuCauController = TextEditingController();
   TextEditingController LoaiHinhController = TextEditingController();
   TextEditingController QuanHuyenController = TextEditingController();
   TextEditingController PhuongXaController = TextEditingController();
   TextEditingController DonViTinhController = TextEditingController();
   TextEditingController LoaiHoaHongController = TextEditingController();
   TextEditingController HuongController = TextEditingController();


  CupertinoSuggestionsBoxController _suggestionsLoaiBatDongSanController =
  CupertinoSuggestionsBoxController();


  CupertinoSuggestionsBoxController _suggestionsNguonKhachController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsChiNhanhController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsNhanSuController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsNhomSanPhamController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsNhomNhuCauController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsLoaiHinhController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsQuanHuyenController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsPhuongXaController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsDonViTinhController =
  CupertinoSuggestionsBoxController();


  CupertinoSuggestionsBoxController _suggestionsLoaiHoaHongController =
  CupertinoSuggestionsBoxController();

  CupertinoSuggestionsBoxController _suggestionsHuongController =
  CupertinoSuggestionsBoxController();


  String nguonKhachNhuCau='--Nguồn khách--';
  String huongNhuCau = '-- Hướng --';
  String nhomNhuCau = 'Cho thuê';

  late CaNhan selectedcanhan;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode ngayNhapFocusNode = FocusNode();
  FocusNode hoTenKhachHangFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();
  FocusNode soPhongNguFocusNode = FocusNode();
  FocusNode soPhongVeSinhFocusNode = FocusNode();
  FocusNode soTangFocusNode = FocusNode();
  FocusNode soCanFocusNode = FocusNode();
  FocusNode phapLyFocusNode = FocusNode();
  FocusNode tinhTrangNoiThatFocusNode = FocusNode();
  FocusNode giaFocusNode = FocusNode();
  FocusNode dienTichFocusNode = FocusNode();
  FocusNode dienTichSuDugFocusNode = FocusNode();
  FocusNode chieuDaiFocusNode = FocusNode();
  FocusNode chieuRongFocusNode = FocusNode();
  FocusNode tienDatCocFocusNode = FocusNode();
  FocusNode tieuDeSanPhamFocusNode = FocusNode();
  FocusNode duongPhoFocusNode = FocusNode();
  FocusNode diaChiFocusNode = FocusNode();
  FocusNode duongNgoTruocNhaFocusNode = FocusNode();
  FocusNode hoaHongFocusNode = FocusNode();
  FocusNode ghiChuFocusNode = FocusNode();
  FocusNode nguonKhachFocusNode=FocusNode();


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

          hoTenKhachHangController.text,
          dienThoaiController.text,
          tieuDeSanPhamController.text,
        '84',
        '3',
        '56',
        '841',
        NhomSanPhamController.text,
       NhomNhuCauController.text,
        LoaiHinhController.text,

        '116',
          '165',
        duongPhoController.text,
        diaChiController.text,
        '31',
        phapLyController.text,
        tinhTrangNoiThatController.text,

        chieuDaiController.text,
        chieuRongController.text,
        dienTichController.text,
        dienTichSuDungController.text,
        soTangController.text,
        soCanController.text,
        duongNgoTruocNhaController.text,
        soPhongNguController.text,
        soPhongVeSinhController.text,
        tienDatCocController.text,
        DonViTinhController.text,
        LoaiHoaHongController.text,
        ghiChuController.text,
        'link',
        hoaHongController.text,
        giaController.text,
        context,








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
                    8.height,
                    //thong tin so dien thoai
                    AppTextField(
                      controller: dienThoaiController,
                      focus: dienThoaiFocusNode,
                      nextFocus: nguonKhachFocusNode,
                      textFieldType: TextFieldType.PHONE,
                      decoration: rfInputDecoration(
                        lableText: "Điện thoại cá nhân",
                        showLableText: true,
                      ),
                    ),
                    8.height,
                    //thong tin nguon khach
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,

                      suggestionsBoxController: _suggestionsNguonKhachController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: NguonKhachController,

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
                        NguonKhachController.text = suggestion;

                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn nguồn khách hàng' : null,
                    ),
                    8.height,
                    //thong tin chi nhanh
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsChiNhanhController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: ChiNhanhController,
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
                        ChiNhanhController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn Chi Nhánh' : null,
                    ),
                    8.height,


                    //thong tin nhan su

                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsNhanSuController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: NhanSuController,
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
                        NhanSuController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn Nhân Sự' : null,
                    ),
                    8.height,
                    // thong tin san pham
                    Container(
                      alignment: Alignment.centerLeft,
                     child: Text("Thông tin sản phẩm", style: boldTextStyle(size: 18)),
                    ),
                    8.height,


                    //thong tin loai bat dong san
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,

                      suggestionsBoxController: _suggestionsLoaiBatDongSanController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: LoaiBatDongSanController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Loại Bất Động Sản",
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
                                color: Colors.black,
                              
                                
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        LoaiBatDongSanController.text = suggestion;
                      },

                      validator: (value) =>

                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    8.height,
                    //thong tin nhom san pham
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsNhomSanPhamController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: NhomSanPhamController,
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
                        NhomSanPhamController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    8.height,
                    //thong tin phan loai
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsNhomNhuCauController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: NhomNhuCauController,
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
                        NhomNhuCauController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    8.height,
                    //thong tin loai hinh
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsLoaiHinhController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: LoaiHinhController,
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
                        LoaiHinhController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    8.height,
                    //Quan huyen xa
                    Row(
                      children: <Widget>[
                        Expanded(child: CupertinoTypeAheadFormField(
                          getImmediateSuggestions: true,
                          suggestionsBoxController: _suggestionsQuanHuyenController,
                          textFieldConfiguration: CupertinoTextFieldConfiguration(
                              controller: QuanHuyenController,
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
                            QuanHuyenController.text = suggestion;
                          },
                          validator: (value) =>
                          value!.isEmpty ? 'Chọn loại bất động sản' : null,
                        ),),
                        8.width,
                        Expanded(child: CupertinoTypeAheadFormField(
                          getImmediateSuggestions: true,
                          suggestionsBoxController: _suggestionsPhuongXaController,
                          textFieldConfiguration: CupertinoTextFieldConfiguration(
                              controller: PhuongXaController,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              placeholder: "Phường Xã",
                              padding: EdgeInsets.all(14)
                          ),
                          suggestionsCallback: (pattern) {
                            CitiesService citis = new CitiesService();
                            citis.getPhuongXa(pattern, context);
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
                            PhuongXaController.text = suggestion;
                          },
                          validator: (value) =>
                          value!.isEmpty ? 'Chọn Phường Xã' : null,
                        ),
                        )
                      ],
                    ),
                    //Đường Phố
                    8.height,
                    AppTextField(
                      controller: duongPhoController,
                      focus: duongPhoFocusNode,
                      nextFocus: diaChiFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Đường Phố",
                        showLableText: true,
                      ),
                    ),
                    8.height,
                    //dia chi
                    AppTextField(
                      controller: diaChiController,
                      focus: diaChiFocusNode,
                      nextFocus: tieuDeSanPhamFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Địa chỉ",
                        showLableText: true,
                      ),
                    ),
                    8.height,
                    //tieu de san pham
                    AppTextField(
                      controller: tieuDeSanPhamController,
                      focus: tieuDeSanPhamFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Tiêu đề sản phẩm",
                        showLableText: true,
                      ),
                    ),
                    8.height,
                    //huong
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsHuongController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: HuongController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          placeholder: "Hướng",
                          padding: EdgeInsets.all(14)
                      ),
                      suggestionsCallback: (pattern) {
                        CitiesService citis = new CitiesService();
                        citis.getHuong(pattern, context);
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
                        HuongController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    8.height,
                    //Pháp Lí

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
                    8.height,
                    //tình trạng nội thất
                    AppTextField(
                      controller: tinhTrangNoiThatController,
                      focus: tinhTrangNoiThatFocusNode,
                      nextFocus: chieuDaiFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Tình trạng nội thất",
                        showLableText: true,
                      ),
                      minLines: 3,
                      maxLines: 100,
                    ),
                    //chiều dài chiều rộng
                    8.height,
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
                          nextFocus: dienTichFocusNode,
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
                    //diện tích đất+ diện tich sử dụng
                    8.height,
                    Row(
                      children: [
                        Expanded(child: AppTextField(
                          controller: dienTichController,
                          focus: dienTichFocusNode,
                          nextFocus: dienTichSuDugFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Diện tích đất',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        ),),
                        8.width,
                        Expanded(child: AppTextField(
                          controller: dienTichSuDungController,
                          focus: dienTichSuDugFocusNode,
                          nextFocus: soTangFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Diện tích sử dụng',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        ),)
                      ],
                    ),
                    //Số tầng Số căn
                    8.height,
                    Row(
                      children: [
                        Expanded(child: AppTextField(
                          controller: soTangController,
                          focus: soTangFocusNode,
                          nextFocus: soCanFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Số tầng',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        ),),
                        8.width,
                        Expanded(child: AppTextField(
                          controller: soCanController,
                          focus: soCanFocusNode,
                          nextFocus: duongNgoTruocNhaFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Số căn',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        ),)
                      ],
                    ),


                    //Đường/Ngõ trước nhà
                    AppTextField(
                      controller: duongNgoTruocNhaController,
                      focus: duongNgoTruocNhaFocusNode,
                      nextFocus: soPhongNguFocusNode,
                      textFieldType: TextFieldType.NUMBER,
                      decoration: rfInputDecoration(
                        lableText: "Đường/Ngõ trước nhà",
                        showLableText: true,
                      ),
                    ),
                    //số phòng ngủ/số phòng vệ sinh
                    8.height,
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
                          nextFocus: giaFocusNode,
                          textFieldType: TextFieldType.PHONE,
                          decoration: rfInputDecoration(
                            lableText: "Số phòng vệ sinh",
                            showLableText: true,
                          ),
                        ),
                        )
                      ],
                    ),
                    //giá+tiền cọc
                    8.height,
                    Row(
                      children: <Widget>[
                        Expanded(child: AppTextField(
                          controller: giaController,
                          focus: giaFocusNode,
                          nextFocus: tienDatCocFocusNode,
                          decoration: rfInputDecoration(
                            showLableText: true,
                            lableText: 'Giá (triệu đồng)',
                          ),
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                          textFieldType: TextFieldType.NUMBER,
                        ),),
                        8.width,
                        Expanded(child: AppTextField(
                          controller: tienDatCocController,
                          focus: tienDatCocFocusNode,

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
                        )
                      ],
                    ),
                    //don vi tinh
                    8.height,
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsDonViTinhController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: DonViTinhController,
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
                        DonViTinhController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn đơn vị tính' : null,
                    ),
                    8.height,
                    //Loai Hoa hồng
                    CupertinoTypeAheadFormField(
                      getImmediateSuggestions: true,
                      suggestionsBoxController: _suggestionsLoaiHoaHongController,
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                          controller: LoaiHoaHongController,


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
                        LoaiHoaHongController.text = suggestion;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Chọn loại bất động sản' : null,
                    ),
                    8.height,

                    //Hoa hồng
                    AppTextField(
                      controller: hoaHongController,
                      focus: hoaHongFocusNode,
                      nextFocus: ghiChuFocusNode,
                      decoration: rfInputDecoration(
                        showLableText: true,
                        lableText: 'Hoa hồng',
                      ),
                      inputFormatters: [
                        ThousandsFormatter(allowFraction: true),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                      textFieldType: TextFieldType.NUMBER,
                    ),
                    //ghi chu
                    AppTextField(
                      controller: ghiChuController,
                      focus: ghiChuFocusNode,

                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Ghi chú",
                        showLableText: true,
                      ),
                      minLines: 3,
                      maxLines: 200,
                    ),
                    //Ngay Nhap
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
