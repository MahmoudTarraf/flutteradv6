import 'package:flutteradv6/model/user_model.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  void setUser(UserModel user) {
    userModel.value = user;
  }

  UserModel? get currentUser => userModel.value;
}
