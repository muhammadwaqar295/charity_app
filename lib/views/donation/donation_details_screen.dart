import 'dart:convert';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/profile_circle_avatar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../../reusable_widgets/our_text.dart';
import '../home_screens/home_screen.dart';


class DonationDetailsScreen extends StatefulWidget {
  final DonationCampaignModel campaign;

  const DonationDetailsScreen({super.key, required this.campaign});

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar
              Row(
                children: [
                  ourBackButton(context),
                  Expanded(
                    child: Center(
                      child: ourText(color: blackColor, title: compin, textSize: 22),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 12),

              // Main Image / Avatar
              ourCircleAvatar(
                radius: 60,
                image: widget.campaign.imageUrls.isNotEmpty ? widget.campaign.imageUrls[0] : '',
                fallbackIcon: Icons.person,
              ),

              const SizedBox(height: 16),

              // Name
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: "Name: ${widget.campaign.needyName}",
                  textSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              // Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ourText(color: blackColor, title: "Details:", textSize: 16),
                    const SizedBox(height: 8),
                    ourText(
                      color: textColor,
                      title: widget.campaign.fullDescription,
                      textSize: 14,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Donation Summary
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    ourText(color: blackColor, title: "Need Amount:", textSize: 14),
                    const SizedBox(width: 4),
                    ourText(color: textColor, title: "${widget.campaign.needAmount} PKR", textSize: 13),
                    const Spacer(),
                    const Icon(Icons.access_time_rounded, size: 16),
                    const SizedBox(width: 6),
                    ourText(color: textColor, title: "${widget.campaign.daysLeft} days left", textSize: 13),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Image Gallery
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.campaign.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.campaign.imageUrls[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Donate Now Button
              ourButton(
                onPress: () async{
                  await makePayment();

                },
                color: yellowColor,
                textColor: blackColor,
                title: donateNow,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');

      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            merchantDisplayName: 'Charity App',
            style: ThemeMode.light,
          ),
        );

        await displayPaymentSheet();
      }
    } catch (e) {
      print('Exception in makePayment: $e');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment successful!")),
      );

      print("✅ Payment ID: ${paymentIntentData!['id']}");
      print("✅ Amount: ${paymentIntentData!['amount']}");
      print("✅ Status: ${paymentIntentData!['status']}");

      paymentIntentData = null;
    } on StripeException catch (e) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Payment cancelled."),
        ),
      );
    } catch (e) {
      print("Exception in displayPaymentSheet: $e");
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer secret key',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('✅ PaymentIntent Created: ${response.body}');
      return jsonDecode(response.body);
    } catch (err) {
      print('❌ Error creating PaymentIntent: $err');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final price = (int.parse(amount)) * 100;
    return price.toString();
  }

}
/*
   Stripe Method in flutter
   1.main activity
   2.add proguard-rules
   3.changes in style,
   4.add code in main
   5.add dependencies
   6.code in donationScreen for payment




*/
