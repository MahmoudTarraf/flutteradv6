import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 2;
  updateIndex(int num) {
    selectedIndex = num;
    update();
  }
}
