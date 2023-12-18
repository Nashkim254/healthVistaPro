part of 'providers.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  void  setUser(User? user) {  
      this._user = user;  
   }  

  Future<User> refreshUser() async {
    User user = await UserServices.getUserDetails();
    _user = user;
    notifyListeners();
    return user;
  }
}
