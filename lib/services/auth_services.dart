part of 'services.dart';

// class for authentication user , sign in and sign up
class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseAuth get auth => _auth;

  // method signUp user
  static Future<SignInSignUpResult> signUp({
    String? fullName,
    String? job,
    String? emailAdress,
    String? password,
    String? noSIP,
    int? state,
    double? ratingNum,
    String? status,
    String? alumnus,
    String? tempatPraktek,
  }) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: emailAdress!,
        password: password!,
      );
      print("-------------------------------- 0");
      print(result.user);
      // convert firebase user ke user
      m.User user = m.User(
        result.user!.uid,
        result.user!.email,
        fullName: fullName,
        profileImage: "no_pic",
        job: job,
        noSIP: noSIP,
        status: status,
        state: state ?? 1,
        ratingNum: ratingNum ?? 1,
        alumnus: alumnus,
        tempatPraktek: tempatPraktek,
      );
      print("-------------------------------- 1");
      print(user,);
 
      // to store data to Firebase
      await UserServices.updateUser(user);
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  // sign in services
  static Future<SignInSignUpResult> signIn({String? email, String? password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email!, password: password!);
      // get data from firestore and sign to User
      m.User user = await result.user!.fromFireStore();
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  // sign out services
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // reset password services
  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // to receive if there's change in user sign in/sign out status
  static Stream<User?> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  // this method is for check if there are errors happen when user sign in or sign up
  final m.User? user;
  final String? message;

  SignInSignUpResult({this.user, this.message});
}
