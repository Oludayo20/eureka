import 'package:get/state_manager.dart';
import '../Home_Page.dart';

class MenuController extends GetxController {
  RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;
  List<String> get menuItems => ["Home", "Team", "About Us"];

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
    streamControllerHome.add(index);
  }
}
