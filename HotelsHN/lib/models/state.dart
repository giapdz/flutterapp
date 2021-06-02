import 'package:firebase_auth/firebase_auth.dart';
import 'package:HotelsHN/models/user.dart';
import 'package:HotelsHN/models/settings.dart';

class StateModel {
  bool isLoading;
  User firebaseUserAuth;
  UserModel user;
  SettingModels settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
  });
}
