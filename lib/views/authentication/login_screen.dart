import 'package:charity_app/controllers/auth_controller.dart';
import 'package:charity_app/views/authentication/signup_screen.dart';
import 'package:charity_app/views/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../reusable_widgets/our_button.dart';
import '../../reusable_widgets/our_button2.dart';
import '../../reusable_widgets/our_text.dart';
import '../../reusable_widgets/our_textField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Charity Text (Yellow)
                ourText(color: yellowColor, title: charity, textSize: 40),

                // Sign In Text (Black)
                ourText(color: Colors.black, title: signin, textSize: 22),

                const SizedBox(height: 20),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          // Email
                          ourTextField(
                            controller: controller.emailController,
                            title: email,
                            hint: emailHint,
                            isPass: false,
                          ),

                          const SizedBox(height: 15),

                          // Password
                          ourTextField(
                            controller: controller.passwordController,
                            title: password,
                            hint: passwordHint,
                            isPass: true,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Forgot password logic
                              },
                              child: const Text(
                                forgetPassword,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // 🔐 Login Button
                          ourButton(
                            onPress: () async {
                              controller.isloading(true);

                              try {
                                final result = await controller.loginMethod(context: context);
                                controller.isloading(false);

                                if (result != null && result.user != null) {
                                  Fluttertoast.showToast(
                                    msg: "Login Successful ✅",
                                    backgroundColor: Colors.green,
                                  );
                                  Get.offAll(() => const Home());
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Login failed! User is null",
                                    backgroundColor: Colors.red,
                                  );
                                }
                              } catch (e) {
                                controller.isloading(false);
                                Fluttertoast.showToast(
                                  msg: "Login Error: $e",
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            color: yellowColor,
                            textColor: whiteColor,
                            title: signin,
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ➕ Sign Up
                ourButton2(
                  onPress: () {
                    Get.to(() => const SignupScreen());
                  },
                  title: signup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
