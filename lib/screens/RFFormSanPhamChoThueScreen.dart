import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/http_exeption.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:intl/intl.dart';
import '../utils/RFString.dart';
import '../widgets/cupertino_flutter_typeahead.dart';

class RFFormSanPhamChoThueScreen extends StatefulWidget {
  static const routeName = '/form-them-sp-cho-thue';

  @override
  _RFFormSanPhamChoThueScreenState createState() => _RFFormSanPhamChoThueScreenState();
}

class _RFFormSanPhamChoThueScreenState extends State<RFFormSanPhamChoThueScreen> {
  TextEditingController ngayBuaAnController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController khoiLuongController = TextEditingController();
  TextEditingController tenBuaAnController = TextEditingController();

  CupertinoSuggestionsBoxController _suggestionsBoxController =
  CupertinoSuggestionsBoxController();
  final TextEditingController _typeAheadController = TextEditingController();
  String favoriteCity = 'Unavailable';

  FocusNode khoiLuongFocusNode = FocusNode();
  FocusNode ngayBuaAnFocusNode = FocusNode();
  FocusNode tenBuaAnFocusNode = FocusNode();
  FocusNode f4 = FocusNode();
  DateTime? selectedDate;
  String buaAn = '';
  bool _isLoading = false;


  @override
  void initState() {
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
        ngayBuaAnController.text = "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
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
        subTitle: "Thêm sản phẩm cho thuê",
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
                    TextFormField(
                      controller: ngayBuaAnController,
                      focusNode: ngayBuaAnFocusNode,
                      readOnly: true,
                      onTap: () {
                        selectDateAndTime(context);
                      },
                      onFieldSubmitted: (v) {
                        ngayBuaAnFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(f4);
                      },
                      decoration: inputDecoration(
                        context,
                        hintText: "Ngày nhập",
                        suffixIcon: Icon(Icons.calendar_month_rounded, size: 16, color: appStore.isDarkModeOn ? white : gray),
                      ),
                    ),
                    16.height,
                    AppTextField(
                      controller: tenBuaAnController,
                      focus: tenBuaAnFocusNode,
                      textFieldType: TextFieldType.NAME,
                      decoration: rfInputDecoration(
                        lableText: "Tên bữa ăn (Ăn sáng / Ăn trưa / Khác)",
                        showLableText: true,
                        suffixIcon: Container(
                          child: Icon(Icons.done, color: Colors.white, size: 14),
                        ),
                      ),
                    ),
                    8.height,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Chọn tên thực phẩm', textAlign: TextAlign.start,),
                    ),
                    4.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
