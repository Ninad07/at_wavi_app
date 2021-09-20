import 'package:at_wavi_app/app.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'widgets/desktop_theme_card.dart';

class DesktopThemeSettingPage extends StatefulWidget {
  const DesktopThemeSettingPage({Key? key}) : super(key: key);

  @override
  _DesktopThemeSettingPageState createState() =>
      _DesktopThemeSettingPageState();
}

class _DesktopThemeSettingPageState extends State<DesktopThemeSettingPage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 80, top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 166,
                child: DesktopThemeCard(
                  primaryColor: appTheme.primaryColor,
                  brightness: Brightness.light,
                  isSelected: appTheme.brightness == Brightness.light,
                  onPressed: () {
                    setState(() {
                      final newTheme = AppTheme.from(
                        primaryColor: appTheme.primaryColor,
                        brightness: Brightness.light,
                      );
                      appThemeController.sink.add(newTheme);
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 166,
                child: DesktopThemeCard(
                  primaryColor: appTheme.primaryColor,
                  brightness: Brightness.dark,
                  isSelected: appTheme.brightness == Brightness.dark,
                  onPressed: () {
                    setState(() {
                      final newTheme = AppTheme.from(
                        primaryColor: appTheme.primaryColor,
                        brightness: Brightness.dark,
                      );
                      appThemeController.sink.add(newTheme);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}