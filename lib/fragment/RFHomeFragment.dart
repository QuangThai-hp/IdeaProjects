import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/screens/RFSearchDetailScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/widgets/BangNhuCauMuaList.dart';


import '../widgets/CusomerList.dart';

class RFHomeFragment extends StatefulWidget {
  @override
  _RFHomeFragmentState createState() => _RFHomeFragmentState();
}

class _RFHomeFragmentState extends State<RFHomeFragment> {
  var _isInit = true;
  var _isLoading = false;
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

  @override
  void initState() {
    super.initState();
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
            title: Text('Nhu cầu', style: boldTextStyle(color: appStore.textPrimaryColor)),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
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
                      ).paddingOnly(left: 16, right: 16, top: 16, bottom: 8),
                      _isLoading ? Center(
                        child: CircularProgressIndicator(),
                      ) : BangNhuCauCanMuaList(phanLoai: categoryData[selectCategoryIndex], reset: true,)

                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: '1',
            elevation: 5,
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/form-nhu-cau', (route)=>false);
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
