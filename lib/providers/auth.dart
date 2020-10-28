import 'package:everis_poc/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Sign in Annonym using FireBase Auth
  Future signInAnnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register a new user using FireBase Auth
  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      throw e;
    }
  }

  //Forgot password
  Future<bool> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Change email
  Future changeEmail(String email) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await user.updateEmail(email);
    } catch (e) {
      print(e);
      return false;
    }
  }

  
  //Change email
  Future deleteUser() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await user.delete();
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Login a new user using FireBase Auth
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      throw e;
    }
  }

  //Sign out using FireBase Auth
  Future singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
