import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxreturn/module/user.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signInAnon() async{
    try{
     AuthResult result =  await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;

    }


  }

  
  //sign in anynomusly
  


  // sign in with email and password
  Future signINWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
     catch(e){
      print(e.toString());
      // error = e.toString();
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
//    create a new doc for the user with uid
  //    await DataBaseService(uid: user.uid).createUserData(' ');
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
     // error = e.toString();
      return null;
    }
  }

  // sign out 
 Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }

 }

}