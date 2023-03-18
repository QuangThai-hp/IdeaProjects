import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/providers/DonViTinh.dart';
import 'package:room_finder_flutter/providers/KhuVuc.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/providers/donViTinhs.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';
import 'package:room_finder_flutter/widgets/ImageVideoUpload.dart';
import '../components/RFCongratulatedDialog.dart';
import '../providers/SanPham.dart';
import '../providers/khuVucs.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart' as RFWidget;
import 'package:intl/intl.dart' as intl;

class RFFormNhuCauScreen extends StatefulWidget {
  final int? nid;
  final String? nhom;
  final String? previousPage;
  final String? hoten;

  RFFormNhuCauScreen({this.nid, this.nhom, this.previousPage,this.hoten});

  static const routeName = '/form-nhu-cau';

  @override
  _RFFormNhuCauScreenState createState() => _RFFormNhuCauScreenState();
}

class _RFFormNhuCauScreenState extends State<RFFormNhuCauScreen> {
  bool initForm = true;

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
  TextEditingController ghiChuController = TextEditingController();

  String? huongNhuCau = null;
  String? nhomNhuCau = null;
  String? chonDonViTinh = null;
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
  FocusNode donViTinhFocusNode = FocusNode();
  FocusNode giaBangSoFocusNode = FocusNode();
  FocusNode dienTichFocusNode = FocusNode();
  FocusNode dienTichSuDugFocusNode = FocusNode();
  FocusNode chieuDaiFocusNode = FocusNode();
  FocusNode chieuRongFocusNode = FocusNode();
  FocusNode tienDatCocFocusNode = FocusNode();
  FocusNode tieuDeSanPhamFocusNode = FocusNode();
  FocusNode ghiChuFocusNode = FocusNode();

  FocusNode f4 = FocusNode();
  DateTime? selectedDate;

  bool _isLoading = false;
  KhuVuc? selectedQuan;
  KhuVuc? selectedPhuongXa;
  DonViTinh? selectedDonViTinh;

  bool quanLoaded = false;
  bool phuongXaLoaded = true;
  bool donViTinhLoaded = false;
  bool nhuCauLoaded = false;

  String ngayNhapDefault = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  List<KhuVuc> quanHuyen = [];
  List<KhuVuc> phuongXa = [];
  List<DonViTinh> donViTinh = [];
  List<String> hinhAnhs = [];

  Future<void> _loadKhuVuc(String type, int? parentId, int? phuongXaTidSelected) async{
    setState(() {
      phuongXa = [];
      selectedPhuongXa = null;
    });

    if(!quanLoaded || !phuongXaLoaded)
    // try
    {
      KhuVucs khuVucs = await Provider.of<KhuVucs>(context, listen: false);
      khuVucs.getListKhuVuc(
          type,
          parentId,
        context
      ).then((value){
        if(type == 'Quận huyện')
          setState(() {
            quanHuyen = khuVucs.items;
            quanLoaded = true;
          });
        else { // Phường xã
          setState(() {
            phuongXa = khuVucs.items;
            phuongXaLoaded = true;
            if(phuongXaTidSelected != null)
              phuongXa.forEach((element) {
                if(element.tid == phuongXaTidSelected)
                  selectedPhuongXa = element;
              });
          });
        }
      });
    }
    // on HttpException catch(error){
    //   RFWidget.showErrorDialog(error.message, context);
    // } catch (error){
    //   print(error);
    //   showInDialog(context, barrierDismissible: true, builder: (context) {
    //     return RFCongratulatedDialog();
    //   });
    //   RFWidget.showErrorDialog('Kiểm tra lại kết nối và đường truyền Internet', context);
    // }
  }

  Future<void> _loadDVT() async{
    if(!donViTinhLoaded)
    // try
    {
      DonViTinhs donViTinhs = await Provider.of<DonViTinhs>(context, listen: false);
      donViTinhs.getListDonViTinh().then((value){
        setState(() {
          donViTinh = donViTinhs.items;
          donViTinhLoaded = true;
        });
      });
    }
    // on HttpException catch(error){
    //   RFWidget.showErrorDialog(error.message, context);
    // } catch (error){
    //   print(error);
      // RFWidget.showErrorDialog('Kiểm tra lại kết nối và đường truyền Internet', context);
    // }
  }

  Future<void> _loadNhuCau() async{
    if(!nhuCauLoaded){
      print(widget.nid);
      NhuCaus nhuCaus = await Provider.of<NhuCaus>(context, listen: false);

      nhuCaus.getNhuCauByNid(widget.nid!).then((value){
        setState(() {
          nhuCauLoaded = true;
          huongNhuCau = nhuCaus.nhuCau.field_huong;
          nhomNhuCau = nhuCaus.nhuCau.nhuCau;
          ngayNhapController.text = nhuCaus.nhuCau.ngayNhap!;
          tieuDeSanPhamController.text = nhuCaus.nhuCau.title;
          hoTenKhachHangController.text = (nhuCaus.nhuCau.khachHangChuNha != null ? nhuCaus.nhuCau.khachHangChuNha!.hoTen : '');
          dienThoaiController.text = (nhuCaus.nhuCau.khachHangChuNha != null ? nhuCaus.nhuCau.khachHangChuNha!.dienThoai : '');
          soTangController.text = nhuCaus.nhuCau.soTang.toString();
          soPhongNguController.text = nhuCaus.nhuCau.soPhongNgu.toString();
          soPhongVeSinhController.text = nhuCaus.nhuCau.SoPhongVeSinh.toString();
          phapLyController.text = nhuCaus.nhuCau.thongTinPhapLy.toString();
          giaController.text = intl.NumberFormat.decimalPattern().format(nhuCaus.nhuCau.field_gia);//NumberFormat("###.0#", "vi_VN").format();//nhuCaus.nhuCau.field_gia.toString();
          dienTichController.text = nhuCaus.nhuCau.field_dien_tich.toString();
          tinhTrangNoiThatController.text = nhuCaus.nhuCau.tinhTrangNoiThat.toString();
          giaBangSoController.text = intl.NumberFormat.decimalPattern().format(nhuCaus.nhuCau.giaBangSo);//NumberFormat("###.0#", "vi_VN").format();
          tienDatCocController.text = intl.NumberFormat.decimalPattern().format(nhuCaus.nhuCau.soTienCoc);//NumberFormat("###.0#", "vi_VN").format(nhuCaus.nhuCau.soTienCoc);
          dienTichSuDungController.text = nhuCaus.nhuCau.dienTichSuDung.toString();
          chieuDaiController.text = nhuCaus.nhuCau.chieuDai.toString();
          chieuRongController.text = nhuCaus.nhuCau.chieuRong.toString();
          ghiChuController.text = nhuCaus.nhuCau.ghiChu.toString();
          hinhAnhs = nhuCaus.nhuCau.hinhAnhs;

          // Load dữ liệu quận huyện đã chọn
          quanHuyen.forEach((element) {
            if(nhuCaus.nhuCau.quanHuyen?.name == element.name){
              selectedQuan = element;
              final phuongXa = nhuCaus.nhuCau.phuongXa;
              if(phuongXa != null){
                phuongXaLoaded = false;
                _loadKhuVuc('Phường xã', selectedQuan?.tid, phuongXa.tid);
              }
            }
          });

          donViTinh.forEach((element) {
            if(nhuCaus.nhuCau.donViTinhGia?.name == element.name){
              selectedDonViTinh = element;
            }
          });
        });
      });
    }

  }
  @override
  void didChangeDependencies() {


    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {

    if(widget.nid != null){
      _loadNhuCau();
    }else{
      setState(() {
        ngayNhapController.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });
    }
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
      SanPham sanPham = Provider.of<SanPham>(context, listen: false);
      Map<String, dynamic> khachHangChuNha() => {
        "hoTen": hoTenKhachHangController.text,
        "dienThoai": dienThoaiController.text
      };
      Map<String, dynamic> quanSelected() => {
        "tid": selectedQuan?.tid,
        "type": selectedQuan?.type,
        "name": selectedQuan?.name
      };
      Map<String, dynamic> phuongSelected() => {
        "tid": selectedPhuongXa?.tid,
        "type": selectedPhuongXa?.type,
        "name": selectedPhuongXa?.name
      };
      Map<String, dynamic> donViTinhSelected() => {
        "tid": selectedDonViTinh?.tid,
        "name": selectedDonViTinh?.name
      };
      Map<String, dynamic> toJson() => {
        "nid": widget.nid,
        "field_ngay_nhap": ngayNhapController.text,
        "field_nhom_nhu_cau": nhomNhuCau,
        "khachHangChuNha": khachHangChuNha(),
        "title": tieuDeSanPhamController.text,
        "field_quan_huyen": quanSelected(),
        "field_phuong_xa": phuongSelected(),
        "field_so_phong_ngu": soPhongNguController.text,
        "field_so_phong_ve_sinh": soPhongVeSinhController.text,
        "field_so_tang": soTangController.text,
        "field_phap_ly": phapLyController.text,
        "field_tinh_trang_noi_that": tinhTrangNoiThatController.text,
        "field_gia": giaController.text,
        "field_don_vi_tinh": donViTinhSelected(),
        "field_huong": huongNhuCau,
        "field_gia_bang_so": giaBangSoController.text,
        "field_dien_tich": dienTichController.text,
        "field_dien_tich_su_dung": dienTichSuDungController.text,
        "field_chieu_dai": chieuDaiController.text,
        "field_chieu_rong": chieuRongController.text,
        "field_so_tien_coc": tienDatCocController.text,
        "field_ghi_chu": ghiChuController.text,
        "field_anh_san_pham": sanPham.field_anh_san_pham,
        "field_deleted_anh_san_pham": sanPham.field_deleted_anh_san_pham
      };
      print(toJson());
      await Provider.of<SanPhams>(context, listen: false).save(
          toJson(),
          '/home',
          context
      );
      setState(() {
        _isLoading = false;
      });

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

    Widget leadingWidget() {
      return BackButton(
        color: appStore.textPrimaryColor,
        onPressed: () {
          // toasty(context, 'Back button');
          RFHomeScreen rf_home = new RFHomeScreen();
          rf_home.selectedIndex = 0;
          rf_home.launch(context);
        },
      );
    }

    if(widget.nid == null){
      if(widget.nhom == 'Khách hàng'){
        tenForm = 'Thêm khách và nhu cầu mua / thuê';
        doiTuong = 'Khách hàng';
      }
      else if(widget.nhom == 'Chủ nhà'){
        tenForm = 'Thêm chủ nhà và nhu cầu bán / thuê';
        doiTuong = 'Chủ nhà';
      }
      else if(widget.nhom == 'Cần Mua'){
        tenForm = 'Thêm nhu cầu mua và thông tin KH';
        doiTuong = 'Khách hàng';
        nhomNhuCau = 'Cần mua';
      }
      else if(widget.nhom == 'Cần Bán'){
        doiTuong = 'Chủ nhà';
        tenForm = 'Thêm nhu cầu bán và thông tin chủ nhà';
        nhomNhuCau = 'Cần bán';
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
    }

    if(this.initForm){
      _loadKhuVuc('Quận huyện', null, null);
      _loadDVT();

      setState(() {
        this.initForm = false;
      });
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Cập nhật thông tin nhu cầu', style: boldTextStyle(color: appStore.textPrimaryColor)),
            backgroundColor: Colors.white,
            leading: leadingWidget(),
          ),
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
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
                                          nhomNhuCau = newValue;
                                        });
                                      },
                                      items: <String>['Cần mua', 'Cần bán', 'Cho thuê', 'Cần thuê'].map<DropdownMenuItem<String>>((String value) {
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
                                  Expanded(
                                      child: !quanLoaded ? Center(child: CircularProgressIndicator(),) : Container(
                                        decoration: boxDecorationWithRoundedCorners(
                                          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                        ),
                                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                        child: DropdownButton<KhuVuc>(
                                          value: selectedQuan,
                                          elevation: 16,
                                          style: primaryTextStyle(),
                                          hint: Text('Quận huyện', style: primaryTextStyle()),
                                          isExpanded: true,
                                          underline: Container(
                                            height: 0,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (KhuVuc? newValue) {
                                            setState(() {
                                              selectedQuan = newValue;
                                              phuongXaLoaded = false;
                                            });
                                            _loadKhuVuc('Phường xã', newValue?.tid, null);
                                          },
                                          items: quanHuyen.map<DropdownMenuItem<KhuVuc>>((KhuVuc value) {
                                            return DropdownMenuItem<KhuVuc>(
                                              value: value,
                                              child: Text(value.name == null ? '' : value.name),
                                            );
                                          }).toList(),
                                        ),
                                      )),
                                  8.width,
                                  Expanded(
                                      child: !phuongXaLoaded ? Center(child: CircularProgressIndicator(),) : Container(
                                        decoration: boxDecorationWithRoundedCorners(
                                          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                        ),
                                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                        child: DropdownButton<KhuVuc>(
                                          value: selectedPhuongXa,
                                          elevation: 16,
                                          style: primaryTextStyle(),
                                          hint: Text('Phường xã', style: primaryTextStyle()),
                                          isExpanded: true,
                                          underline: Container(
                                            height: 0,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (KhuVuc? newValue) {
                                            setState(() {
                                              selectedPhuongXa = newValue;
                                            });
                                          },
                                          items: phuongXa.map<DropdownMenuItem<KhuVuc>>((KhuVuc value) {
                                            return DropdownMenuItem<KhuVuc>(
                                              value: value,
                                              child: Text(value.name),
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
                                    textFieldType: TextFieldType.NUMBER,
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
                                    textFieldType: TextFieldType.NUMBER,
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
                                      items: <String>['Đông', 'Tây', 'Nam','Bắc', 'Đông Nam', 'Đông Bắc', 'Tây Nam', 'Tây Bắc', 'Đông Tứ Trạch', 'Tây Tứ Trạch'].map<DropdownMenuItem<String>>((String value) {
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
                                    nextFocus: donViTinhFocusNode,
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
                                  Expanded(
                                      child: !donViTinhLoaded ? Center(child: CircularProgressIndicator(),) : Container(
                                        decoration: boxDecorationWithRoundedCorners(
                                          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                        ),
                                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                        child: DropdownButton<DonViTinh>(
                                          value: selectedDonViTinh,
                                          elevation: 16,
                                          style: primaryTextStyle(),
                                          hint: Text('Đơn vị tính', style: primaryTextStyle()),
                                          isExpanded: true,
                                          underline: Container(
                                            height: 0,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (DonViTinh? newValue) {
                                            setState(() {
                                              selectedDonViTinh = newValue;
                                            });
                                          },
                                          items: donViTinh.map<DropdownMenuItem<DonViTinh>>((DonViTinh value) {
                                            return DropdownMenuItem<DonViTinh>(
                                              value: value,
                                              child: Text(value.name!),
                                            );
                                          }).toList(),
                                        ),
                                      )),
                                ],
                              ),
                              16.height,
                              AppTextField(
                                controller: giaBangSoController,
                                focus: giaBangSoFocusNode,
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
                                  )),
                                  8.width,
                                  Expanded(child: AppTextField(
                                    controller: dienTichSuDungController,
                                    focus: dienTichSuDugFocusNode,
                                    nextFocus: chieuDaiFocusNode,
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
                                    nextFocus: tienDatCocFocusNode,
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
                                nextFocus: ghiChuFocusNode,
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
                              AppTextField(
                                controller: ghiChuController,
                                focus: ghiChuFocusNode,
                                textFieldType: TextFieldType.NAME,
                                decoration: rfInputDecoration(
                                  lableText: "Ghi chú",
                                  showLableText: true,
                                ),
                                minLines: 3,
                                maxLines: 100,
                              ),
                              16.height,

                            ],
                          ),
                        ),
                      ),
                    ),
                    ImageVideoUpload(images: hinhAnhs),

                    if(_isLoading)
                      CircularProgressIndicator()
                    else
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 0),
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
                    rfCommonRichText(title: "Huỷ nhập dữ liệu. ", subTitle: "Quay lại").paddingAll(8).onTap(() {
                        RFHomeScreen rf_home = new RFHomeScreen();
                        rf_home.selectedIndex = 0;
                        rf_home.launch(context);
                      },
                    ),
                  ],
                )
              ]
            )
        ),
      )
    );
  }
}
