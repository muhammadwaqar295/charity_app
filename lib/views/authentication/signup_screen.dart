import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_button2.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:charity_app/views/authentication/login_screen.dart';
import 'package:charity_app/admin/signup_requester.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../reusable_widgets/user_type_selector.dart .dart';
import '../home/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedUserType;
  bool? isCheck = false;

  final controller = Get.put(AuthController());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Charity Text
                ourText(
                  color: yellowColor,
                  title: charity,
                  textSize: 40,
                ),

                // Sign Up Text
                ourText(
                  color: blackColor,
                  title: signup,
                  textSize: 22,
                ),

                const SizedBox(height: 20),

                // Stack for Signup Card
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
                          // User Type Selector
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             /* ourText(
                                color: textColor,
                                title: type,
                                textSize: 12,
                              ),*/
                              SizedBox(height: 8),
                           /*   UserTypeSelector(
                                selectedUserType: selectedUserType,
                                onSelectionChanged: (type) {
                                  setState(() {
                                    selectedUserType = type;
                                  });

                                  if (type == requester) {
                                    Get.to(() => const SignupRequester());
                                  }
                                },
                              ),*/
                            ],
                          ),

                          const SizedBox(height: 15),

                          // Name Field
                          ourTextField(
                            controller: nameController,
                            title: name,
                            hint: nameHint,
                            isPass: false,
                          ),

                          const SizedBox(height: 15),

                          // Password Field
                          ourTextField(
                            controller: passwordController,
                            title: password,
                            hint: passwordHint,
                            isPass: true,
                          ),

                          const SizedBox(height: 20),

                          // Email Field
                          ourTextField(
                            controller: emailController,
                            title: email,
                            hint: emailHint,
                            isPass: false,
                          ),

                          const SizedBox(height: 15),

                          // Phone Field
                          ourTextField(
                            controller: phoneController,
                            title: phone,
                            hint: phoneHint,
                            isPass: false,
                          ),

                          const SizedBox(height: 20),

                          // Signup Button
                          Obx(() => controller.isloading.value
                              ? const CircularProgressIndicator()
                              : ourButton(
                            onPress: () async {
                              controller.isloading(true);

                              if (nameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  phoneController.text.isEmpty ||
                                  selectedUserType == null) {
                                Fluttertoast.showToast(
                                  msg: please_fill_all_fields,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                                controller.isloading(false);
                                return;
                              }

                              try {
                                UserCredential? value =
                                await controller.signupMethod(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password:
                                  passwordController.text.trim(),
                                );

                                if (value != null &&
                                    value.user != null) {
                                  await controller.storeUserData(
                                    nameController.text,
                                    passwordController.text,
                                    emailController.text,
                                  );

                                  Fluttertoast.showToast(
                                    msg: signup_successful,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                  );

                                  controller.isloading(false);
                                  Get.offAll(() => const Home());
                                } else {
                                  Fluttertoast.showToast(
                                    msg: signup_failed_User_is_null,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                  controller.isloading(false);
                                }
                              } catch (e) {
                                controller.isloading(false);
                                Fluttertoast.showToast(
                                  msg: e.toString(),
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            color: yellowColor,
                            textColor: whiteColor,
                            title: signup,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Sign In Button
                ourButton2(
                  onPress: () {
                    Get.off(const LoginScreen());
                  },
                  title: signin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
