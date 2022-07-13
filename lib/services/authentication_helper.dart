import 'package:firebase_auth/firebase_auth.dart';

import '../Models/User.dart';


class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CurrentUser? getUser() {
    var uer = _auth.currentUser;
    if(uer==null)
      return null;
    return CurrentUser(
        email: uer.email,
        isAnonymous: uer.isAnonymous,
        displayName: uer.displayName,
        emailVerified: uer.emailVerified);
  }

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      var x = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );

      return x.user!.email;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }
  bool isAdmin() {
    try {
      var curr = getUser();
      if(curr== null)
        return false;
      if(curr.isAnonymous!)
        return false;
      if(curr.email=="admin@gmail.com")
        return true;
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }
  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      var x = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
