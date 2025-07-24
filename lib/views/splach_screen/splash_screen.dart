import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../consts/firebase_const.dart';
import '../authentication/login_screen.dart';
import '../home/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    // This runs only once after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        final user = auth.currentUser;
        if (user == null) {
          Get.offAll(() => const LoginScreen());
        } else {
          Get.offAll(() => const Home());
        }
      });
    });





    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [

          Image.asset(
           splashImg,
            fit: BoxFit.cover,
          ),


          Align(
            alignment: const Alignment(0, -0.05),
            child: ourText(
                color: yellowColor,
                title: charity,
                textSize: 90),

          ),
        ],
      ),
    );
  }





}
