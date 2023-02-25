import 'dart:convert';

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
import 'package:room_finder_flutter/widgets/ImageVideoUpload.dart';
import '../common/data.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class RFFormNhuCauScreen extends StatefulWidget {
  final String? nhom;
  final String? previousPage;

  RFFormNhuCauScreen({this.nhom, this.previousPage});

  static const routeName = '/form-sp-cho-thue';

  @override
  _RFFormNhuCauScreenState createState() => _RFFormNhuCauScreenState();
}

class _RFFormNhuCauScreenState extends State<RFFormNhuCauScreen> {
  TextEditingController ngayNhapController = TextEditingController();
  TextEditingController hoTenKhachHangController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();
  TextEditingController soPhongNguController = TextEditingController();
  TextEditingController soPhongVeSinhController = TextEditingController();
  TextEditingController soTangController = TextEditingController();
  TextEditingController phapLyController = TextEditingController();
  TextEditingController tinhTrangNoiThatController = TextEditingController();
  TextEditingController giaController = TextEditingController();
  TextEditingController giaBangSoController = TextEditingController();
  TextEditingController dienTichController = TextEditingController();
  TextEditingController dienTichSuDungController = TextEditingController();
  TextEditingController chieuDaiController = TextEditingController();
  TextEditingController chieuRongController = TextEditingController();
  TextEditingController tienDatCocController = TextEditingController();
  TextEditingController tieuDeSanPhamController = TextEditingController();

  String huongNhuCau = '';
  String nhomNhuCau = '-- Loại hình --';
  String chonDonViTinh = '-- Chọn ĐVT --';
  String chonQuan = '-- Chọn Quận --';
  String chonPhuongXa = '-- Chọn Phường xã --';
  String tenForm = '';
  String doiTuong = '';

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
  FocusNode giaBangSoFocusNode = FocusNode();
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
  String selectedQuan = '';
  String selectedPhuongXa = '';

  String ngayNhapDefault = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  List<String> quanHuyen = [];
  List<String> phuongXa = [];

  @override
  void initState() {
    setState(() {
      ngayNhapController.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    });
    super.initState();
    init();
  }

  void init() async {
    //
  }
  Future<void> _submit() async{
    setState(() {
      _isLoading = true;
    });
    try
    {
      // await Provider.of<SanPhams>(context, listen: false).save(
      //     '',
      //   ngayNhapController.text,
      //   tenBuaAnController.text,
      //   nameChiTietThucPhamTrongNgay,
      //   soLuongChiTietThucPhamTrongNgay,
      //   context
      // );
      // setState(() {
      //   _isLoading = false;
      // });

      // Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route)=>false);
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

    if(widget.nhom == 'Khách hàng'){
      tenForm = 'Thêm khách và nhu cầu mua / thuê';
      doiTuong = 'Khách hàng';
    }
    else if(widget.nhom == 'Chủ nhà'){
      tenForm = 'Thêm chủ nhà và nhu cầu bán / thuê';
      doiTuong = 'Chủ nhà';
    }
    else if(widget.nhom == 'Mua'){
      tenForm = 'Thêm nhu cầu mua và thông tin KH';
      doiTuong = 'Khách hàng';
      nhomNhuCau = 'Mua';
    }
    else if(widget.nhom == 'Bán'){
      doiTuong = 'Chủ nhà';
      tenForm = 'Thêm nhu cầu bán và thông tin chủ nhà';
      nhomNhuCau = 'Bán';
    }
    else if(widget.nhom == 'Cho thuê'){
      doiTuong = 'Chủ nhà';
      tenForm = 'Thêm chủ nhà và nhu cầu cho thuê';
      nhomNhuCau = 'Cho thuê';
    }
    else{
      doiTuong = 'Khách hàng';
      tenForm = 'Thêm khách hàng và nhu cầu cần thuê';
      nhomNhuCau = 'Cần thuê';
    }

    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: tenForm,
        mainWidgetHeight: 150,
        subWidgetHeight: 115,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nhập đầy đủ thông tin có dấu *', style: primaryTextStyle(),)
          ],
        ),
        subWidget:
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(child: TextFormField(
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
                              )),
                              8.width,
                              Expanded(child: Container(
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
                                  items: <String>['-- Loại hình --', 'Mua', 'Bán', 'Cho thuê', 'Cần thuê'].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ))
                            ],
                          ),
                          16.height,
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Thông tin ${doiTuong}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
                          ),
                          16.height,
                          AppTextField(
                            controller: hoTenKhachHangController,
                            focus: hoTenKhachHangFocusNode,
                            nextFocus: dienThoaiFocusNode,
                            textFieldType: TextFieldType.NAME,
                            decoration: rfInputDecoration(
                              lableText: "Họ tên ${doiTuong} *",
                              showLableText: true,
                            ),
                          ),
                          16.height,
                          AppTextField(
                            controller: dienThoaiController,
                            focus: dienThoaiFocusNode,
                            nextFocus: soPhongNguFocusNode,
                            textFieldType: TextFieldType.PHONE,
                            decoration: rfInputDecoration(
                              lableText: "Điện thoại ${doiTuong} *",
                              showLableText: true,
                            ),
                          ),
                          16.height,
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Thông tin nhu cầu ${nhomNhuCau != '-- Loại hình --' ? nhomNhuCau : ''}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
                          ),
                          16.height,
                          AppTextField(
                            controller: tieuDeSanPhamController,
                            focus: tieuDeSanPhamFocusNode,
                            textFieldType: TextFieldType.NAME,
                            decoration: rfInputDecoration(
                              lableText: "Tiêu đề *",
                              showLableText: true,
                            ),
                            minLines: 3,
                            maxLines: 100,
                          ),
                          16.height,
                          Row(
                            children: [
                              Expanded(child: Container(
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                  backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                ),
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: DropdownButton<String>(
                                  value: null,
                                  elevation: 16,
                                  style: primaryTextStyle(),
                                  hint: Text('Quận', style: primaryTextStyle()),
                                  isExpanded: true,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedQuan = newValue.toString();
                                    });
                                  },
                                  items: quanHuyen.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )),
                              8.width,
                              Expanded(child: Container(
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                  backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                ),
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: DropdownButton<String>(
                                  value: null,
                                  elevation: 16,
                                  style: primaryTextStyle(),
                                  hint: Text('Phường xã', style: primaryTextStyle()),
                                  isExpanded: true,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedPhuongXa = newValue.toString();
                                    });
                                  },
                                  items: phuongXa.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )),
                            ],
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
                          Row(
                            children: [
                              Expanded(child: Container(
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                  backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                ),
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: DropdownButton<String>(
                                  value: null,
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
                                  items: <String>['','Đông', 'Tây', 'Nam','Bắc', 'Đông Nam', 'Đông Bắc', 'Tây Nam', 'Tây Bắc', 'Đông tứ trạch', 'Tây tứ trạch'].map<DropdownMenuItem<String>>((String value) {
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
                          Row(
                            children: [
                              Expanded(child: AppTextField(
                                controller: giaController,
                                focus: giaFocusNode,
                                nextFocus: dienTichFocusNode,
                                decoration: rfInputDecoration(
                                  showLableText: true,
                                  lableText: 'Giá',
                                ),
                                inputFormatters: [
                                  ThousandsFormatter(allowFraction: true),
                                ],
                                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                                textFieldType: TextFieldType.NUMBER,
                              )),
                              8.width,
                              Expanded(child: Container(
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                  backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                ),
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: DropdownButton<String>(
                                  value: chonDonViTinh,
                                  elevation: 16,
                                  style: primaryTextStyle(),
                                  hint: Text('Đơn vị tính', style: primaryTextStyle()),
                                  isExpanded: true,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      chonDonViTinh = newValue.toString();
                                    });
                                  },
                                  items: <String>['-- Chọn ĐVT --', 'Tr/tháng', 'Tr/năm', 'Triệu đồng', 'Tỉ đồng'].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ))
                            ],
                          ),
                          16.height,
                          AppTextField(
                            controller: giaController,
                            focus: giaFocusNode,
                            nextFocus: dienTichFocusNode,
                            decoration: rfInputDecoration(
                              showLableText: true,
                              lableText: 'Giá bằng số (1000000) *',
                            ),
                            inputFormatters: [
                              ThousandsFormatter(allowFraction: true),
                            ],
                            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                            textFieldType: TextFieldType.NUMBER,
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: AppTextField(
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
                              )),
                              8.width,
                              Expanded(child: AppTextField(
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
                              ))
                            ],
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
                          ImageVideoUpload()
                        ],
                      ),
                    ),
                  ),
                ),
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
                    if(widget.previousPage == 'home-tab-0'){
                      RFHomeScreen rf_home = new RFHomeScreen();
                      rf_home.selectedIndex = 0;
                      rf_home.launch(context);
                    }

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
