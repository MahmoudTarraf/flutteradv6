import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_Us": {"hello": "Hello There!"},
        "ar_SA": {"hello": "مرحباً!"},
      };
}
