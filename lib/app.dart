import 'dart:io';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/deep_link_provider.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
// import 'package:at_wavi_app/services/follow_service.dart';
import 'package:at_wavi_app/screens/options.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()),
      ChangeNotifierProvider<FollowService>(
          create: (context) => FollowService()),
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ChangeNotifierProvider<UserPreview>(create: (context) => UserPreview()),
      ChangeNotifierProvider<SetPrivateState>(
          create: (context) => SetPrivateState()),
      ChangeNotifierProvider<DeepLinkProvider>(
          create: (context) => DeepLinkProvider()),
    ], child: MaterialAppClass());
  }
}

class MaterialAppClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        final data = MediaQuery.of(context);
        return GestureDetector(
          onVerticalDragDown: (__) {
            // When running in iOS, dismiss the keyboard when when user scrolls
            if (Platform.isIOS) hideKeyboard(context);
          },
          child: MediaQuery(
            data: data.copyWith(textScaleFactor: 1),
            child: child!,
          ),
        );
      },
      title: 'AtSign wavi',
      debugShowCheckedModeBanner: false,
      initialRoute: SetupRoutes.initialRoute,
      navigatorKey: NavService.navKey,
      theme: ((Provider.of<ThemeProvider>(context)
                  .currentAtsignThemeData
                  ?.scaffoldBackgroundColor ==
              ColorConstants.black)
          ? Themes.darkTheme(highlightColor: Colors.transparent)
          : Themes.lightTheme(highlightColor: Colors.transparent)),
      //  ?? Themes.lightTheme(highlightColor: Colors.transparent),
      // theme: Themes.lightTheme(highlightColor: Colors.transparent),
      routes: SetupRoutes.routes,
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
