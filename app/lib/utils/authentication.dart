import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp({required String email, required String password}) async {
    print('log ::: Authentication.signUp');
    try {
      UserCredential newAccount = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print('log ::: Authentication.signUp / success');
      return newAccount;
    } on FirebaseAuthException catch (error) {
      print('log ::: Authentication.signUp / $error');
      return false;
    }
  }

  static Future<dynamic> signInByEmail({required String email, required String password}) async {
    print('log ::: Authentication.signInByEmail');
    try {
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('log ::: Authentication.signInByEmail / success');
      currentFirebaseUser = _result.user;
      return _result;
    } on FirebaseAuthException catch (error) {
      print('error ::: Authentication.signInByEmail / $error');
      return false;
    }
  }

  static Future<dynamic> signInWithGoogle() async {
    print('log ::: Authentication.signInWithGoogle');
    try {
      final googleUser = await GoogleSignIn(scopes: ['email']).signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential _result = await _firebaseAuth.signInWithCredential(credential);
        currentFirebaseUser = _result.user;
        print('log ::: Authentication.signInWithGoogle / success');
        return _result;
      }
    } on FirebaseAuthException catch (error) {
      print('error ::: Authentication.signInWithGoogle / $error');
      return false;
    }
  }

  static Future<void> signOut() async {
    print('log ::: Authentication.signOut');
    await _firebaseAuth.signOut();
  }

  static Future<void> deleteAuth() async {
    await currentFirebaseUser!.delete();
  }
}
