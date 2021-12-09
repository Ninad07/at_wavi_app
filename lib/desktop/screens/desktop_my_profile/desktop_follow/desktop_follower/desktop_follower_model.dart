import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopFollowerModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<User> _users = [];
  List<User> _searchUsers = [];
  List<String> _atsigns = [];

  List<User> get users => _users;
  List<User> get searchUsers => _searchUsers;
  List<String> get atsigns => _atsigns;

  late TextEditingController followerTextEditingController;

  DesktopFollowerModel({required this.userPreview}) {
    //  FieldOrderService().initCategoryFields(AtCategory.DETAILS);
    var followsProvider = Provider.of<FollowService>(
        NavService.navKey.currentContext!,
        listen: false);
    List<String> followersList = (followsProvider.followers.list ?? []) as List<String>;
    atsigns.addAll(followersList);
    followerTextEditingController = TextEditingController(
      text: '',
    );
    if (followsProvider.isFollowingFetched) {
      if (followersList != [] && followersList.length != 0) {
        for (int i = 0; i < followersList.length; i++) {
          _users.add(User(atsign: followersList[0].toString().split("@").last));
        }
      }
    }

    searchUser('');
  }

  void searchUser(String text) {
    _searchUsers.clear();
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].atsign.toLowerCase().contains(text)) {
        _searchUsers.add(_users[i]);
      }
    }
    notifyListeners();
  }
}
