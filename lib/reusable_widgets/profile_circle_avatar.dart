import 'package:charity_app/consts/consts.dart';

Widget ourCircleAvatar({
  required double radius,
  double? size,
  String? image, // Can be network URL or asset path
  IconData? fallbackIcon,
}) {
  ImageProvider? backgroundImage;

  // Determine the image type (network or asset)
  if (image != null && image.isNotEmpty) {
    if (image.startsWith('http') || image.startsWith('https')) {
      backgroundImage = NetworkImage(image);
    } else {
      backgroundImage = AssetImage(image);
    }
  }

  return CircleAvatar(
    radius: radius,
    backgroundColor: yellowColor,
    backgroundImage: backgroundImage,
    child: backgroundImage == null
        ? Icon(
      fallbackIcon ?? Icons.image,
      size: size ?? radius * 0.8,
      color: Colors.white,
    )
        : null,
  );
}
