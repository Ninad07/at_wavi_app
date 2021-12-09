import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopFollowingModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<User> _users = [];
  List<User> _searchUsers = [];
  List<String> _atsigns = [];

  List<User> get users => _users;
  List<User> get searchUsers => _searchUsers;
  List<String> get atsigns => _atsigns;

  late TextEditingController followingTextEditingController;

  DesktopFollowingModel({required this.userPreview}) {
    //  FieldOrderService().initCategoryFields(AtCategory.DETAILS);
    var followsProvider = Provider.of<FollowService>(
        NavService.navKey.currentContext!,
        listen: false);
    List<String> followingList = (followsProvider.followers.list ?? []) as List<String>;
    atsigns.addAll(followingList);
    followingTextEditingController = TextEditingController(
      text: '',
    );
    if (followsProvider.isFollowingFetched) {
      if (followingList != [] && followingList.length != 0) {
        for (int i = 0; i < followingList.length; i++) {
          _users.add(User(atsign: followingList[0].toString().split("@").last));
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
