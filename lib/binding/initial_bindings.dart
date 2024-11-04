import 'package:flutteradv6/core/class/crud.dart';
import 'package:flutteradv6/core/service/network_connection.dart';
import 'package:flutteradv6/view/profile/controller/user_service.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(NetworkManager());
    Get.put(UserService());
  }
}
