import 'package:daniknews/auth/select_category_page.dart';
import 'package:daniknews/services/firebase_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../login_error.dart';

class UserAgreement extends StatefulWidget {
  const UserAgreement({super.key});

  @override
  _UserAgreementState createState() => _UserAgreementState();
}

class _UserAgreementState extends State<UserAgreement> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.red;
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Terms and Conditions",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "News uploaded by you is visible to everyone, Danik News neither use and never store the personal details of their users. "
              "Users may get rewards for uploading news",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: " By continuing, you are agree to our  ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms of Service',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrlString('https://daniknews.com/#/');
                      },
                  ),
                  const TextSpan(
                    text: "  and  ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrlString('https://daniknews.com/#/');
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "I agree to terms and conditions",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                )
              ],
            ),
            const SizedBox(height: 14),
            Center(
              child: SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  onPressed: isChecked
                      ? () async {
                          await signInWithGoogle().then((user) {
                            if (user != null) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SelectCategories(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginError(),
                                ),
                              );
                            }
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red, backgroundColor: Colors.white,
                    padding: const EdgeInsets.only(right: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/google.png'),
                        backgroundColor: Colors.white,
                      ),
                      Text(
                        "Login to continue",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // buildSnackBar(BuildContext context) {
  //   final SnackBar snackBar = SnackBar(
  //     backgroundColor: Colors.red,
  //     padding: const EdgeInsets.all(8.0),
  //     content: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: const [
  //         CircularProgressIndicator(),
  //         SizedBox(width: 30),
  //         Text("Signing In")
  //       ],
  //     ),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  //   );
  //
  //   if (isSigningIn == true) {
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else {
  //     null;
  //   }
  // }
}
