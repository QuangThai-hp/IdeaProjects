import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFAccountFragment.dart';
import 'package:room_finder_flutter/fragment/RFChoThueFragment.dart';
import 'package:room_finder_flutter/fragment/RFHomeFragment.dart';
import 'package:room_finder_flutter/fragment/RFKhachHangFragment.dart';
import 'package:room_finder_flutter/fragment/RFSearchFragment.dart';
import 'package:room_finder_flutter/fragment/RFSettingsFragment.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/fragment/RFMuaBanFragment.dart';
import 'package:room_finder_flutter/fragment/RFMuaBanFragment.dart';
import 'package:room_finder_flutter/fragment/RFMuaBanTestFragment.dart';

import 'package:room_finder_flutter/fragment/RFMuaBanFragment.dart';


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
    RFMuaBanFragment(),
    RFChoThueFragment(),
    RFAccountFragment(),
  ];

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: widget._selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 12),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: rf_primaryColor,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 22),
          label: 'Tổng quan',
          activeIcon: Icon(Icons.home_outlined, color: rf_primaryColor, size: 22),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 22), //rf_search.iconImage(),
          label: 'Khách',
          activeIcon: Icon(Icons.person, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send_and_archive_outlined, size: 22), //rf_search.iconImage(),
          label: 'Cần bán',
          activeIcon: Icon(Icons.send_and_archive, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.change_circle_outlined, size: 22), //rf_search.iconImage(),
          label: 'Cho thuê',
          activeIcon: Icon(Icons.change_circle, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined, size: 22), //rf_search.iconImage(),
          label: 'Cài đặt',
          activeIcon: Icon(Icons.settings, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
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
