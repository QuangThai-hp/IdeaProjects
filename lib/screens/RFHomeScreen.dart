import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFAccountFragment.dart';
import 'package:room_finder_flutter/fragment/RFHomeFragment.dart';
import 'package:room_finder_flutter/fragment/RFSearchFragment.dart';
import 'package:room_finder_flutter/fragment/RFSettingsFragment.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFHomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _RFHomeScreenState createState() => _RFHomeScreenState();
}

class _RFHomeScreenState extends State<RFHomeScreen> {
  int _selectedIndex = 0;

  var _pages = [
    RFHomeFragment(),
    RFSearchFragment(),
    RFSettingsFragment(),
    RFAccountFragment(),
    RFAccountFragment(),
  ];

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 14),
      selectedFontSize: 14,
      unselectedFontSize: 14,
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
          icon: Icon(Icons.backup_table, size: 22), //rf_search.iconImage(),
          label: 'Sản phẩm',
          activeIcon: Icon(Icons.backup_table_outlined, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_exchange, size: 22), //rf_search.iconImage(),
          label: 'Giao dịch',
          activeIcon: Icon(Icons.currency_exchange_outlined, color: rf_primaryColor, size: 22,)// rf_search.iconImage(iconColor: rf_primaryColor),
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
      _selectedIndex = index;
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
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
