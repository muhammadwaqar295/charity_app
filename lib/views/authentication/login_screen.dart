import 'package:charity_app/views/authentication/signup_screen.dart';

import '../../consts/consts.dart';
import '../../reusable_widgets/our_button.dart';
import '../../reusable_widgets/our_button2.dart';
import '../../reusable_widgets/our_text.dart';
import '../../reusable_widgets/our_textField.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                ourText(
                    color: yellowColor,
                    title: "Charity",
                    textSize: 40),



                // Sign In Text (Black)
                ourText(
                    color: Colors.black,
                    title: "Sign In",
                    textSize: 22),


                const SizedBox(height: 20,),

                // Stack for Side Lines & Login Card
                Stack(
                  alignment: Alignment.center,
                  children: [

                    // Login Card
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

                          // Email TextField
                          ourTextField(
                            title: "Email Address",
                            hint: "Enter email Address",
                            isPass: false
                          ),

                          const SizedBox(height: 15),

                          // Password TextField
                  ourTextField(
                    title: "Password",
                    hint: "Enter Password",
                    isPass: true
                  ),



                          // Forget Password Right-Aligned
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Forgot Password Action
                              },
                              child: const Text(
                                "Forget password",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),

                          // Login Button
                  ourButton(
                onPress: (){
             },
           color: yellowColor,
           textColor: whiteColor,
           title: login)
                        ],
                      ),
                    ),
                  ],
                ),



                const SizedBox(height: 20),

                // Sign Up Button
                ourButton2(
                    onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                    title: "SIGN UP"),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
