import 'package:firebase_auth/firebase_auth.dart';
import '../Models/User.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String emailVerifiedError = "An email has been sent, please go verify. Check your spam";
  bool isSignedIn() {
    var uer = _auth.currentUser;
    if (uer == null || !uer.emailVerified && !isAdmin()) return false;
    return true;
  }

  CurrentUser? getUser() {
    var uer = _auth.currentUser;
    if (uer == null) return null;
    return CurrentUser(
        uid: uer.uid,
        email: uer.email,
        isAnonymous: uer.isAnonymous,
        displayName: uer.displayName,
        emailVerified: uer.emailVerified);
  }

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String password,
      required String displayName /*required Student student*/}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(displayName);
      await userCredential.user!.sendEmailVerification();
      return emailVerifiedError;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  bool isAdmin() {
    try {
      var curr = getUser();

      if (curr == null) return false;
      if (curr.isAnonymous!) return false;
      if (curr.email == "admin@gmail.com") return true;
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      var x = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!x.user!.emailVerified && !isAdmin()) {
        await user.sendEmailVerification();
        return emailVerifiedError;
      }
      return x.user!.email;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }
}
