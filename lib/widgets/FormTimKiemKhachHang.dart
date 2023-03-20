import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';

import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/KhachHang.dart';
import 'package:room_finder_flutter/widgets/BangKhachHangList.dart';
import '../main.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import '../utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class FormTimKiemKhachHang extends StatefulWidget {
  @override
  State<FormTimKiemKhachHang> createState() => _FormTimKiemKhachHangState();
}

class _FormTimKiemKhachHangState extends State<FormTimKiemKhachHang> {
  late List<KhachHang> khachHangs = [];
  late String isLoadedData = '';
  var _bangKhachHang = BangKhachHangList();
  int start = 0;
  int limit = 10;
  TextEditingController findNameController = TextEditingController();
  TextEditingController findPhoneController = TextEditingController();

  FocusNode findNameFocusNode = FocusNode();
  FocusNode findPhoneFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  // const FormTimKiemKhachHang({Key? key}) : super(key: key);
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
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  finish(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tìm kiếm khách hàng',
                        style: boldTextStyle(
                            color: appStore.textPrimaryColor, size: 20)),
                    Container(
                        padding: EdgeInsets.all(4),
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.close,
                            color: appStore.textPrimaryColor)),
                  ],
                )),
            16.height,
            AppTextField(
                controller: findNameController,
                focus: findNameFocusNode,
                textFieldType: TextFieldType.NAME,
                decoration: InputDecoration(
                    label: Text('Họ tên'),
                    prefixIcon: Icon(
                      Icons.perm_contact_cal_outlined,
                      color: Colors.black,
                    ))),
            16.height,
            AppTextField(
                controller: findPhoneController,
                focus: findPhoneFocusNode,
                textFieldType: TextFieldType.PHONE,
                decoration: InputDecoration(
                    label: Text('Số điên thoại'),
                    prefixIcon: Icon(
                      Icons.perm_contact_cal_outlined,
                      color: Colors.black,
                    ))),
            16.height,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text('Tìm Kiếm'),
                onPressed: () {
                  BangKhachHangList bang = BangKhachHangList(
                    name: findNameController.text,
                    phone: findPhoneController.text,
                  );
                  Navigator.of(context).pop(bang);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
