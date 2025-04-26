import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:get/get.dart';


class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  String selectedCategory = '';

  void _selectCategory() async {
    final result = await Get.to(() => CategorySelectionScreen());
    if (result != null) {
      setState(() {
        selectedCategory = result;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ourBackButton(context)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ourText(
                  color: blackColor,
                  title: donationDetails,
                  textSize: 15),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: _selectCategory,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: yellowColor),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCategory.isEmpty ? donationCategories : selectedCategory,
                        style: const TextStyle(color: textColor),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ourTextField(hint: amountP,title: enterAmount,isPass: false),


              const SizedBox(height: 20),

              ourText(color: blackColor, title: paymentMethod, textSize: 16),

              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: yellowColor, // Background color
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                width: double.infinity,
                alignment: Alignment.center,
                child: ourText(
                  color: whiteColor,
                  title: paymentWithStripe,
                  textSize: 16,
                ),
              ),


              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: yellowColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child:  ourText(
                      color: blackColor,
                      title: creditCard,
                      textSize: 16,
                    ),

                   ),
                    const SizedBox(height: 10),

                    ourTextField(title: cardNumber,hint: enterCardNumber),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(


                          child:
                          ourTextField(title: MMYY,hint: MMYY),

                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child:
                          ourTextField(title: CVC,hint: CVC),


                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: ourButton(
                    onPress: (){},
                    color: yellowColor,
                    textColor: whiteColor,
                    title: donateNow),
              ),
              const SizedBox(height: 10),
              Center(
                child: ourButton(
                    onPress: (){
                    },
                    color: yellowColor,
                    textColor: whiteColor,
                    title: cancel),
              ),




            ],
          ),
        ),
      ),
    );
  }
}

class CategorySelectionScreen extends StatelessWidget {

  final List<String> categories = [
    qurban,
    zakat,
    sadaqah,
    generalDonation,
    fitrana,
    fidya,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          ourText(color: blackColor, title: selectCategory, textSize: 20),

          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index], textAlign: TextAlign.center),
                  onTap: () {

                    Navigator.pop(context, categories[index]);
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
