import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<User> handleSignInEmail(String email, String password) async{
    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user;
    return user;
  }
  Future <User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = result.user;
    return user;
  }
  Future <void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  Future <User> handleAnonLogin() async {
    UserCredential result = await auth.signInAnonymously();
    final User user = result.user;
    print('Anon login successful');
    print(user.uid);
    return user;
  }
}