import 'dart:io';
import 'dart:typed_data';

import 'package:at_wavi_app/common_components/provider_callback.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import '../../../services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:flutter/material.dart';

class DesktopProfilePicturePage extends StatefulWidget {
  DesktopProfilePicturePage({Key? key}) : super(key: key);

  @override
  _DesktopProfilePicturePageState createState() =>
      _DesktopProfilePicturePageState();
}

class _DesktopProfilePicturePageState extends State<DesktopProfilePicturePage> {
  bool _isPrivate = false;

  @override
  void initState() {
    super.initState();
  }

  void _onSelectMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
    );
    if (result?.files.single.path != null) {
      var _file = File(result!.files.single.path!);
      final data = await _file.readAsBytes();
      // _currentUser?.image.value = data;

      Provider.of<UserPreview>(context, listen: false).user()!.image =
          BasicData(
        value: data,
      );
      setState(() {});
      Provider.of<UserPreview>(context).notify();
    }
  }

  void _handleSaveAndNext(BuildContext context) async {
    await providerCallback<UserProvider>(
      context,
      task: (provider) async {
        await provider.saveUserData(
            Provider.of<UserPreview>(context, listen: false).user()!);
      },
      onError: (provider) {},
      showDialog: false,
      text: 'Saving user data',
      taskName: (provider) => provider.UPDATE_USER,
      onSuccess: (provider) async {
        Navigator.pop(context, 'saved');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: DesktopDimens.paddingLarge,
          ),
          Text(
            'Edit image',
            style: appTheme.textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: DesktopDimens.paddingSmall,
          ),
          Text(
            'All info is public unless set to Private',
            style: appTheme.textTheme.bodyText2,
          ),
          const SizedBox(
            height: DesktopDimens.paddingNormal,
          ),
          Text(
            'Update your profile Image',
            style: appTheme.textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: DesktopDimens.paddingNormal,
          ),
          Expanded(
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _buildAvatarWidget(),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: DesktopIconButton(
                  onPressed: _onSelectMedia,
                  iconData: Icons.edit,
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: DesktopDimens.paddingNormal,
          ),
          Container(
            width: 300,
            child: SwitchListTile(
              activeColor: appTheme.primaryColor,
              title: Text(
                'Set image to private',
                style: appTheme.textTheme.bodyText2,
              ),
              value: _isPrivate,
              onChanged: (bool value) {
                setState(() {
                  _isPrivate = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: DesktopDimens.paddingLarge,
              bottom: DesktopDimens.paddingLarge,
            ),
            child: Row(
              children: [
                Spacer(),
                DesktopButton(
                  title: 'Save & Next',
                  onPressed: () => _handleSaveAndNext(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAvatarWidget() {
    return Consumer<UserPreview>(builder: (context, provider, child) {
      dynamic data = provider.user()?.image.value;
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          child: data is Uint8List
              ? Image.memory(
                  data,
                  fit: BoxFit.cover,
                )
              : Container(),
        ),
      );
    });
  }
}