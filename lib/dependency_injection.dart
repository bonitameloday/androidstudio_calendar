import 'package:calendar/network_controller.dart';
import 'package:get/get.dart';

class DependencyInjectuon{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}