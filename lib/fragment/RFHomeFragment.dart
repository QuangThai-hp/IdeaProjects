import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/screens/RFFormNhuCau.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/widgets/BangNhuCauMuaList.dart';
import 'package:room_finder_flutter/widgets/FormTimKiemNhuCau.dart';

class RFHomeFragment extends StatefulWidget {
  @override
  _RFHomeFragmentState createState() => _RFHomeFragmentState();
}

class _RFHomeFragmentState extends State<RFHomeFragment> {
  var _isLoading = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  List<String> categoryData = [
    'Tất cả',
    'Cần mua',
    'Cần bán',
    'Cần thuê',
    'Cho thuê',
    'Hủy',
  ];
  int selectCategoryIndex = 0;
  bool locationWidth = true;
  Map<String, dynamic> thongTinTimKiem = {"timKiem": false};
  int start = 0;

  Widget appBarTitle = Text("Nhu cầu", style: boldTextStyle(color: appStore.textPrimaryColor));
  FocusNode focusNode = FocusNode();
  bool isSearching = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController hoTenKhachHangController = TextEditingController();
  TextEditingController QuanController = TextEditingController();
  TextEditingController PhuongController = TextEditingController();
  FocusNode hoTenKhachHangFocusNode = FocusNode();
  FocusNode QuanFocusNode = FocusNode();
  FocusNode PhuongFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // isSearching = false;
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: appBarTitle,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(actionIcon.icon, color: appStore.textPrimaryColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => FormTimKiemNhuCau(
                      callback: (value){
                        setState(() {
                          this.thongTinTimKiem = value;
                          _isLoading = true;
                        });
                    },),
                  ).then((value) => null);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: Column(
                    children: [
                      HorizontalList(
                        padding: EdgeInsets.only(right: 16, left: 16),
                        wrapAlignment: WrapAlignment.spaceEvenly,
                        itemCount: categoryData.length,
                        itemBuilder: (BuildContext context, int index) {
                          String data = categoryData[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectCategoryIndex = index;
                                _isLoading = true;
                                start = 0;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: appStore.isDarkModeOn
                                    ? scaffoldDarkColor
                                    : selectCategoryIndex == index
                                    ? rf_selectedCategoryBgColor
                                    : rf_categoryBgColor,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Text(
                                data.validate(),
                                style: boldTextStyle(color: selectCategoryIndex == index ? rf_primaryColor : gray),
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nhu cầu: ${categoryData[selectCategoryIndex]}', style: boldTextStyle()),
                        ],
                      ).paddingOnly(left: 8, right: 8, top: 16, bottom: 8),
                      BangNhuCauCanMuaList(
                        phanLoai: categoryData[selectCategoryIndex],
                        isLoading: this._isLoading,
                        start: this.start,
                        thongTinTimKiem: this.thongTinTimKiem
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            heroTag: '1',
            elevation: 5,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RFFormNhuCauScreen()),
              );
              // Navigator.of(context).pushNamedAndRemoveUntil('/form-nhu-cau', (route)=>false);
              // toasty(context, 'Default FAB Button');
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )
    );
  }
}
