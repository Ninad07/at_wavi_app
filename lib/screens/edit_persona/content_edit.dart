import 'package:at_wavi_app/common_components/content_edit_field_card.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';

class CotentEdit extends StatefulWidget {
  @override
  _CotentEditState createState() => _CotentEditState();
}

class _CotentEditState extends State<CotentEdit> {
  var contentHeadings = [
    {
      'heading': 'Profile picture',
      'category': AtCategory.IMAGE,
      'route': '',
    },
    {
      'heading': 'Basic Details',
      'category': AtCategory.DETAILS,
      'route': '',
    },
    {
      'heading': 'Additional Details',
      'category': AtCategory.ADDITIONAL_DETAILS,
      'route': '',
    },
    {
      'heading': 'Location',
      'category': AtCategory.LOCATION,
      'route': Routes.LOCATION_WIDGET,
    },
    {
      'heading': 'Social Channels',
      'category': AtCategory.SOCIAL,
      'route': '',
    },
    {
      'heading': 'Game Channels',
      'category': AtCategory.GAMER,
      'route': '',
    },
  ];
  AtCategory? selectedcategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: contentHeadings.map((contentHeading) {
                return editContentCardHeading(
                  contentHeading['heading'] as String,
                  contentHeading['category'] as AtCategory,
                  contentHeading['route'] as String,
                );
              }).toList(),
            ),
          )),
    );
  }

  Widget editContentCardHeading(
      String title, AtCategory category, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedcategory = category;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, style: TextStyles.black18bold),
                InkWell(
                  onTap: () {
                    if (route != '') {
                      SetupRoutes.push(
                          NavService.navKey.currentContext!, route);
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        CommonFunctions().isFieldsPresentForCategory(category)
                            ? 'Edit'
                            : 'Add',
                        style: TextStyles.lightText(ColorConstants.black),
                      ),
                      SizedBox(width: 7),
                      CommonFunctions().isFieldsPresentForCategory(category)
                          ? Icon(
                              (Icons.edit),
                              size: 20,
                            )
                          : Icon(
                              Icons.add,
                              // size: 20,
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(height: 25),
          selectedcategory == category
              ? Column(
                  children: contentFields(),
                )
              : SizedBox()
        ],
      ),
    );
  }

  List<Widget> contentFields() {
    return [...getDefinedFieldsCard(), ...getCustomFieldsCard()];
  }

  List<Widget> getDefinedFieldsCard() {
    if (selectedcategory == null) {
      return [SizedBox()];
    }
    var definedFieldsWidgets = <Widget>[];
    var userMap = User.toJson(UserProvider().user!);
    List<String> fields = FieldNames().getFieldList(selectedcategory!);

    for (var field in userMap.entries) {
      if (field.key != null &&
          fields.contains(field.key) &&
          field.value != null &&
          field.value.value != null) {
        var widget = Column(
          children: [
            ContentEditFieldCard(
              title: field.key,
              subtitle: field.value.value,
            ),
            SizedBox(height: 25)
          ],
        );

        definedFieldsWidgets.add(widget);
      }
    }
    return definedFieldsWidgets;
  }

  List<Widget> getCustomFieldsCard() {
    if (selectedcategory == null) {
      return [SizedBox()];
    }
    var customFieldsWidgets = <Widget>[];

    /// getting custom fields for [selectedcategory]
    List<BasicData>? customFields =
        UserProvider().user!.customFields[selectedcategory!.name];

    if (customFields != null) {
      for (var basicData in customFields) {
        if (basicData.accountName != null && basicData.value != null) {
          var widget = Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: checkForCustomContentType(basicData)),
              SizedBox(height: 25)
            ],
          );
          customFieldsWidgets.add(
            widget,
          );
        }
      }
    }

    return customFieldsWidgets;
  }

  Widget checkForCustomContentType(BasicData basicData) {
    Widget fieldCard = SizedBox();
    if (basicData.type == CustomContentType.Text.name ||
        basicData.type == CustomContentType.Number.name ||
        basicData.type == CustomContentType.Link.name) {
      fieldCard = SizedBox(
        width: double.infinity,
        child: ContentEditFieldCard(
          title: basicData.accountName!,
          subtitle: basicData.value,
        ),
      );
    }

    return fieldCard;
  }
}
