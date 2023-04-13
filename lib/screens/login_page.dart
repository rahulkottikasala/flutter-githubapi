import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_github/functions/authfunctions.dart';
import 'package:sample_github/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ...

// Initialize Firebase Authentication
FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "Login / Register",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  _email = text;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "Email Address",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  _password = text;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              RawMaterialButton(
                fillColor: Colors.amber,
                constraints: BoxConstraints.tight(const Size(140, 40)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                onPressed: () {
                  signUp(_email, _password);
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              RawMaterialButton(
                fillColor: Colors.amber,
                constraints: BoxConstraints.tight(const Size(140, 40)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, password: _password);

                    Fluttertoast.showToast(
                      msg: "Login Successfull",
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(
                        msg: "No user found for that email !",
                      );
                    } else if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(
                        msg: "Wrong password provided for that user !",
                      );
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
