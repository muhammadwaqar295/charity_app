import 'package:charity_app/consts/consts.dart';
import 'package:get/get.dart';

Widget ourBackButton(BuildContext context, {Color iconColor = Colors.black}) {
  return IconButton(
    icon: Icon(Icons.arrow_back, color: iconColor),
    onPressed: () => Get.back,
  );
}
