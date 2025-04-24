


import '../../../consts/consts.dart';

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
      const Text("Donate",
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500)),
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