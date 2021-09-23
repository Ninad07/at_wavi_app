import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopSocialAccountPage extends StatefulWidget {
  const DesktopSocialAccountPage({Key? key}) : super(key: key);

  @override
  _DesktopSocialAccountPageState createState() =>
      _DesktopSocialAccountPageState();
}

class _DesktopSocialAccountPageState extends State<DesktopSocialAccountPage>
    with AutomaticKeepAliveClientMixin<DesktopSocialAccountPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorConstants.LIGHT_GREY,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_facebook,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        'https://i.picsum.photos/id/39/300/300.jpg?hmac=HoD3iHGTRG4yexpPUPH8iFp_qzgST0rFI5X7u0JxGOw',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Lauren',
                            style: TextStyle(
                                fontSize: 14,
                                color: appTheme.primaryTextColor,
                                fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'I tell story to entertain',
                            style: TextStyle(
                                fontSize: 12,
                                color: appTheme.secondaryTextColor,
                                fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'www.facebook.com/lauren',
                            style: TextStyle(
                                fontSize: 12,
                                color: appTheme.primaryColor,
                                fontFamily: 'Inter'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_instagram,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        'https://i.picsum.photos/id/39/300/300.jpg?hmac=HoD3iHGTRG4yexpPUPH8iFp_qzgST0rFI5X7u0JxGOw',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Lauren',
                            style: TextStyle(
                                fontSize: 14,
                                color: appTheme.primaryTextColor,
                                fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'I tell story to entertain',
                            style: TextStyle(
                                fontSize: 12,
                                color: appTheme.secondaryTextColor,
                                fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '345 Followers, 645 Following',
                            style: TextStyle(
                                fontSize: 14,
                                color: appTheme.primaryTextColor,
                                fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'www.instagram.com/lauren',
                            style: TextStyle(
                                fontSize: 12,
                                color: appTheme.primaryColor,
                                fontFamily: 'Inter'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_twitter,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'www.twitter.com/lauren',
                        style: TextStyle(
                            fontSize: 14,
                            color: appTheme.primaryColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}