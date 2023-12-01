part of 'extensions.dart';

extension FirebaseUserExtension on User {
  m.User convertToUser(
          {String fullName = "No Name",
          String job = "No Job",
          String noSIP = "No NoSIP",
          String status = "",
          int state = 1,
          double ratingNum = 0,
          String alumnus = "",
          String tempatPraktek = ""}) =>
      m.User(
        this.uid,
        this.email,
        fullName: fullName,
        job: job,
        noSIP: noSIP,
        status: status,
        state: state,
        ratingNum: ratingNum,
        alumnus: alumnus,
        tempatPraktek: tempatPraktek,
      );

  Future<m.User> fromFireStore() async => await UserServices.getUser(this.uid);
}
