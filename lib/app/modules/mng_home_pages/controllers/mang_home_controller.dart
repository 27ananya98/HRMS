import 'package:get/get.dart';

import '../../../../utils/fun.dart';

class MangHomeController extends GetxController {
  RxInt iCurrentPage = 0.obs;

  void updateValue(value) {
    iCurrentPage.value = value;
  }

  RxList<int> permissionsList = [1000].obs;

  @override
  void onInit() {
    super.onInit();
    setPermissionList();
  }

  setPermissionList() async {
    permissionsList.clear();
    permissionsList.value = await  Fun.getPermissionList();
    print(permissionsList);
  }
}
