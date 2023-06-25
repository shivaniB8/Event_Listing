

import 'package:all_events_task/common/colors.dart';
import 'package:all_events_task/common/style.dart';
import 'package:all_events_task/register_login/login_page.dart';
import 'package:all_events_task/register_login/model/user_details.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 260,
                  margin: EdgeInsets.zero,
                  child: Lottie.network(
                      'https://assets4.lottiefiles.com/private_files/lf30_m6j5igxb.json'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Register Now',
                    style: text_style_title1,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration:  InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        errorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                      hintText: "Full Name"
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<UserDetails>().fullName = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        errorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Email"),
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please a Enter';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value ?? 'shivanibagal88@gmail.com')) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<UserDetails>().email =
                          value;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        errorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "Phone Number"),
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please enter phone no ';
                      }
                      if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                          .hasMatch(value ?? 'shivanibagal88@gmail.com')) {
                        return 'Please a valid Phone Number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<UserDetails>().phone = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        errorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Password"),
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please a Enter Password';
                      }
                      return null;
                    },
                    onChanged: (password) {
                      context.read<UserDetails>().password = password;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: confirmPassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      errorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Theme
                          .of(context)
                          .primaryColor
                          .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Confirm Password"),

                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please enter password';
                      }
                      if (password.text != confirmPassword.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                    value: context.read<UserDetails>(),
                                  ),
                                ],
                                child: const LoginPage(),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text("Log In"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Route createFormScreenRoute(Widget formScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => formScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(
        CurveTween(curve: Curves.easeInOutCubic),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
