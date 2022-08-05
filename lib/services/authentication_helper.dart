import 'package:firebase_auth/firebase_auth.dart';
import '../Models/User.dart';
import 'AuthExceptionHandler.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.successful;
  bool isSignedIn() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var uer = auth.currentUser;
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
  Future<AuthStatus> signUp(
      {required String email,
      required String password,
      required String displayName /*required Student student*/}) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _auth.currentUser!.updateDisplayName(displayName);
      await sendVerificationMail(newUser);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  Future sendVerificationMail(UserCredential credential) async {
    await credential.user!.sendEmailVerification();
    return await signOut();
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

  Future<AuthStatus> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _auth.setPersistence(Persistence.SESSION);
      var x = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!x.user!.emailVerified && !isAdmin()) {
        await sendVerificationMail(x);
        return AuthStatus.emailVerifiedError;
      }
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }
  //SIGN OUT METHOD

  Future signOut() async {
    await _auth.signOut();
  }
}
