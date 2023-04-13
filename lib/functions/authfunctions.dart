import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

signUp(String email, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    Fluttertoast.showToast(
      msg: "Account Created",
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Fluttertoast.showToast(
        msg: "The password provided is too weak !",
      );
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(
        msg: "The account already exists for that email !",
      );
    }
  }
}
