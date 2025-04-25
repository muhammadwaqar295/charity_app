import 'package:charity_app/consts/consts.dart';
import '../../../reusable_widgets/our_text.dart';

class HistoryItem extends StatelessWidget {
  final String name;
  final String time;
  final String amount;
  final String status;

  const HistoryItem({
    super.key,
    required this.name,
    required this.time,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == successful ? greenColor : redColor;
    Color statusBackground = status == successful ? greenColorShade : redShade100;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: lightgreyColor, width: 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ourText(
                  title: name,
                  color: blackColor,
                  textSize: 16,
                ),
                const SizedBox(height: 5),
                ourText(
                  title: time,
                  color: lightgreyColor,
                  textSize: 13,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ourText(
                  title: status,
                  color: statusColor,
                  textSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              ourText(
                title: amount,
                color: yellowColor,
                textSize: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
