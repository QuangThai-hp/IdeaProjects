import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFAccountFragment.dart';
import 'package:room_finder_flutter/fragment/RFChatGPTFragment.dart';
import 'package:room_finder_flutter/fragment/RFHeThongFragment.dart';
import 'package:room_finder_flutter/fragment/RFMoiGioiFragment.dart';
import 'package:room_finder_flutter/fragment/RFHomeFragment.dart';
import 'package:room_finder_flutter/fragment/RFKhachHangFragment.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';


class RFHomeScreen extends StatefulWidget {
  static const routeName = '/home';

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }

  late bool showDialog = false;
  String contentAlert = '';
  Timer? timer;

  @override
  _RFHomeScreenState createState() => _RFHomeScreenState();
}

class _RFHomeScreenState extends State<RFHomeScreen> {

  var _pages = [
    RFHomeFragment(),
    RFKhachHangFragment(),
    RFMoiGioiFragment(),
    RFChatGPTFragment(),
    RFHeThongFragment(),
  ];
//

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: widget._selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 12),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: rf_primaryColor,
      type: BottomNavigationBarType.fixed,
      //
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Ionicons.business_outline, size: 22),
          label: 'Nhu cầu',
          activeIcon: Icon(Ionicons.business, color: rf_primaryColor, size: 22),
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.people_circle_outline, size: 22), //rf_search.iconImage(),
          label: 'Khách hàng',
          activeIcon: Icon(Ionicons.people_circle, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.git_branch_outline, size: 22), //rf_search.iconImage(),
          label: 'Kết nối',
          activeIcon: Icon(Ionicons.git_branch, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.chatbubble_ellipses_outline, size: 22), //rf_search.iconImage(),
          label: 'Nhắn tin',
          activeIcon: Icon(Ionicons.chatbubble_ellipses, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.apps_outline, size: 22), //rf_search.iconImage(),
          label: 'Thêm',
          activeIcon: Icon(Icons.apps, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: Center(child: _pages.elementAt(widget._selectedIndex)),
    );
  }
}
