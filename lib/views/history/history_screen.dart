import 'package:charity_app/consts/consts.dart';
import '../../reusable_widgets/our_text.dart';
import 'components/histroyitems.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: ourText(
                      color: blackColor,
                      title: history,
                      textSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  HistoryItem(
                    name: abbasTuri,
                    time: time,
                    amount: amount,
                    status: successful,
                  ),
                  HistoryItem(
                    name: lalAkbar,
                    time: time,
                    amount: amount,
                    status: successful,
                  ),
                  HistoryItem(
                    name: izaz,
                    time: time,
                    amount: amount,
                    status: failed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
