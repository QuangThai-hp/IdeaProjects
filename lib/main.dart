import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/providers/auth.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/customers.dart';
import 'package:room_finder_flutter/providers/donViTinhs.dart';
import 'package:room_finder_flutter/providers/khuVucs.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/screens/RFFormNhuCau.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/screens/RFSignUpScreen.dart';
import 'package:room_finder_flutter/screens/RFSplashScreen.dart';
import 'package:room_finder_flutter/store/AppStore.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFConstant.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/providers/NhuCaus.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) =>  Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, SanPhams>(
          create: (_) => SanPhams('', '', []),
          update: (_, auth, previousSanPhams) {
            return SanPhams(
              auth.token,
              auth.userId,
              previousSanPhams == null ? [] : previousSanPhams.items,
            );
          },
          // create: ,
        ),ChangeNotifierProxyProvider<Auth, NhuCaus>(
          create: (_) => NhuCaus('', '', []),
          update: (_, auth, previousNhuCaus) {
            return NhuCaus(
              auth.token,
              auth.userId,
              previousNhuCaus == null ? [] : previousNhuCaus.items,
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, SanPham>(
          create: (_) => SanPham(),
          update: (_, auth, previousSanPhams) {
            return SanPham(
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, Customers>(
          create: (_) => Customers('', 0,  []),
          update: (_, auth, previousSanPhams) {
            return Customers(
              auth.token,
              auth.userId.toInt(),
              previousSanPhams == null ? [] : previousSanPhams.items,
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, KhuVucs>(
          create: (_) => KhuVucs('', 0, []),
          update: (_, auth, previousSanPhams) {
            return KhuVucs(
              auth.token,
              auth.userId.toInt(),
              previousSanPhams == null ? [] : previousSanPhams.items,
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, DonViTinhs>(
          create: (_) => DonViTinhs('', 0, []),
          update: (_, auth, previousSanPhams) {
            return DonViTinhs(
              auth.token,
              auth.userId.toInt(),
              previousSanPhams == null ? [] : previousSanPhams.items,
            );
          },
          // create: ,
        ),

      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          scrollBehavior: SBehavior(),
          navigatorKey: navigatorKey,
          title: 'HappyHome',
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: auth.isAuth ? RFHomeScreen() :  RFSplashScreen(),
          routes: {
            RFHomeScreen.routeName: (ctx) => RFHomeScreen(),
            RFEmailSignInScreen.routeName: (ctx) => RFEmailSignInScreen(),
            RFSignUpScreen.routeName: (ctx) => RFSignUpScreen(),
            RFFormNhuCauScreen.routeName: (ctx) => RFFormNhuCauScreen(),
          },
        ),
      ),
    );
  }
}


//
