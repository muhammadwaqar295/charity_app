import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_button2.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedUserType;

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

        
                // Charity Text (Yellow)
                ourText(
                    color: yellowColor,
                    title:  "Charity",
                    textSize: 40),

        
                // Sign Up Text (Black)
                ourText(
                    color: blackColor,
                    title: "Sign Up",
                    textSize: 22),



        const SizedBox(height: 20,),
                // Stack for Side Lines & Signup Card
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Signup Card
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
                          // User Type Selection
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "type",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ChoiceChip(
                                      label: const Text("Donars"),
                                      selected: selectedUserType == "Donars",
                                      onSelected: (bool selected) {
                                        setState(() {
                                          selectedUserType = selected ? "Donars" : null;
                                        });
                                      },
                                      backgroundColor: Colors.grey[200],
                                      selectedColor: Colors.amber[700],
                                      labelStyle: TextStyle(
                                        color: selectedUserType == "Donars"
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ChoiceChip(
                                      label: const Text("Requester"),
                                      selected: selectedUserType == "Requester",
                                    /*  onSelected: (bool selected) {
                                        setState(() {
                                          selectedUserType = selected ? "Requester" : null;
                                        });
                                      },*/
                                      // In SignUpPage's Requester ChoiceChip:
                                      onSelected: (bool selected) {
                                        setState(() {
                                          selectedUserType = selected ? "Requester" : null;
                                        });
                                        if (selected) {
                                       /*   Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const BecomeRequesterPage()),
                                          );*/
                                        }
                                      },

                                      backgroundColor: Colors.grey[200],
                                      selectedColor: Colors.amber[700],
                                      labelStyle: TextStyle(
                                        color: selectedUserType == "Requester"
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
        
                          const SizedBox(height: 15),

                          // Full Name TextField
                          ourTextField(
                              title: "Full Name",
                              hint: "Enter Full Name",
                              isPass: false

                          ),

        
                          const SizedBox(height: 15),
        
                          // Password TextField
                          ourTextField(
                            title: "Password",
                            hint: "Enter Password",
                            isPass: true
                          ),

        
                          const SizedBox(height: 20),
        
                          // Email TextField
                          ourTextField(
                              title: "Email Address",
                              hint: "Enter email Address",
                              isPass: false
                          ),

        
                          const SizedBox(height: 15),
        
                          // Phone TextField
                          ourTextField(
                              title: "Phone No.",
                              hint: "Enter Phone No.",
                              isPass: false
                          ),

                          const SizedBox(height: 20),

                          // Sign Up Button
                          ourButton(
                              onPress: (){},
                              color: yellowColor,
                              textColor: whiteColor,
                              title: "SIGN UP"),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),
        
                // Sign In Button
                ourButton2(
                    onPress: (){
                      Navigator.pop(context);
                    },
                    title: "SIGN IN"),


              ],
            ),
          ),
        ),
      ),
    );
  }
}