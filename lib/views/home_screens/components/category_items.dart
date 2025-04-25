


import '../../../consts/consts.dart';
import '../../../reusable_widgets/our_text.dart';

Widget categoryItem(String path, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 2),
        ourText(color: textColor, title: donate, textSize: 9),

      Flexible(
        child: Text(label,
          style: const TextStyle(fontSize: 9),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}