import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFHomeFragment.dart';
import 'package:room_finder_flutter/providers/KhachHangs.dart';
import 'package:room_finder_flutter/providers/auth.dart';
import 'package:room_finder_flutter/providers/SanPhams.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/screens/RFHomeScreen.dart';
import 'package:room_finder_flutter/screens/RFSignUpScreen.dart';
import 'package:room_finder_flutter/screens/RFSplashScreen.dart';
import 'package:room_finder_flutter/store/AppStore.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFConstant.dart';
import 'package:provider/provider.dart';

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
        ),
        ChangeNotifierProxyProvider<Auth, KhachHangs>(
          create: (_) => KhachHangs('', '', []),
          update: (_, auth, previousKhachHangs) {
            return KhachHangs(
              auth.token,
              auth.userId,
              previousKhachHangs == null ? [] : previousKhachHangs.items,
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
          },
        ),
      ),
    );
  }
}
