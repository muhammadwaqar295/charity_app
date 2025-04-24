import 'package:charity_app/consts/consts.dart';

Widget ourCircleAvatar({
  required double radius,
  double? size,
  String? image,         // Optional image path
  IconData? fallbackIcon , // Optional icon to show when image is missing
}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: yellowColor,
    backgroundImage: (image != null && image.isNotEmpty)
        ? AssetImage(image)
        : null,
    child: (image == null || image.isEmpty)
        ? Icon(fallbackIcon ?? Icons.image, size: size, color: Colors.white)
        : null,
  );
}
