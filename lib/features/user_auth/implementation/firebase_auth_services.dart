import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartspark/helpers/null_helpers.dart';
import 'package:smartspark/helpers/ui_helpers.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Error list: https://firebase.google.com/docs/reference/js/auth#autherrorcodes

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseException catch (e) {
      if (e.code == "email-already-in-use") {
        showToast(message: "This email is already in use.");
      } else {
        showToast(
            message: nullableStringWithDefault(
                e.message, "An error occured: ${e.code}"));
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        showToast(message: "Invalid email or password.");
      } else {
        showToast(
            message: nullableStringWithDefault(
                e.message, "An error occured: ${e.code}"));
      }
    }
    return null;
  }
}
