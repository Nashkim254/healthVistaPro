part of 'services.dart';

// Class for User services, to store user data and get user data
class UserServices {
  static CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  // create and update user
  static Future<void> updateUser(m.User user) async {
    print("================================================================");
    print(user);
    await _userCollection.doc(user.id).set({
      'uid': user.id,
      'email': user.email,
      'fullName': user.fullName,
      'job': user.job,
      'profileImage': user.profileImage ?? "no_pic",
      'noSIP': user.noSIP ?? "",
      'status': user.status ?? "",
      'state': user.state ?? 1,
      'ratingNum': user.ratingNum ?? 0.0,
      'alumnus': user.alumnus ?? "",
      'tempatPraktek': user.tempatPraktek ?? "",
    });
  }

  static Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = AuthServices._auth.currentUser!;
    return currentUser;
  }

  static Future<m.User> getUserDetails() async {
    User currentUser = await getCurrentUser();
    DocumentSnapshot documentSnapshot = await _userCollection.doc(currentUser.uid).get();
    print("before getting user map§§");
    print(documentSnapshot.data());
    var user = m.User.fromMap(documentSnapshot.data());
    print("user details=====§");
    print(user);
    return user;
  }

  // check and get user from firestore
  static Future<m.User> getUser(String id) async {
    print("-------§--------");
    print(id);
    try {
      DocumentSnapshot snapshot = await _userCollection.doc(id).get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        return m.User(
          id,
          data?['email'] ?? '',
          fullName: data?['fullName'] ?? '',
          profileImage: data?['profileImage'] ?? '',
          job: data?['job'] ?? '',
          noSIP: data?['noSIP'] ?? '',
          status: data?['status'] ?? '',
          ratingNum: data?['ratingNum'] ?? 0,
          state: data?['state'] ?? '',
          alumnus: data?['alumnus'] ?? '',
          tempatPraktek: data?['tempatPraktek'] ?? '',
        );
      } else {
        print("User with ID $id does not exist");
        throw Exception("User with ID $id does not exist");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      throw Exception("Error fetching user data: $e");
    }
  }

  static Future<List<m.User>> getAllUser() async {
    List<m.User> userList = <m.User>[];
    QuerySnapshot querySnapshot = await _userCollection.get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      userList.add(m.User.fromMap(doc.data() as Map<String, dynamic>));
    }

    return userList;
  }

  static Future<List<m.User>> getAllContact(String doctorId) async {
    List<m.User> userList = <m.User>[];

    try {
      DocumentSnapshot documentSnapshot = await _userCollection.doc(doctorId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

        // Iterate over the map keys (user IDs) and add users to the list
        data.forEach((key, value) {
          userList.add(m.User.fromMap(value));
        });
      }
    } catch (e) {
      print("Error fetching user contacts: $e");
    }

    return userList;
  }

  // static Future<List<User>> getAllUser() async {
  //   List<User> userList = List<User>();
  //   QuerySnapshot querySnapshot = await _userCollection.getDocuments();
  //   for (var i = 0; i < querySnapshot.documents.length; i++) {
  //     userList.add(User.fromMap(querySnapshot.documents[i].data));
  //   }
  //   return userList;
  // }

  //   static Future<List<User>> getAllUserDoctor(String job) async {
  //   List<User> userList = List<User>();
  //   QuerySnapshot querySnapshot = await _userCollection.getDocuments();
  //   for (var i = 0; i < querySnapshot.documents.length; i++) {
  //     userList.add(User.fromMap(querySnapshot.documents[i].data));
  //   }
  //   return userList;
  // }

  static Future<void> setUserState(
      {required String userId, required UserStates? userStates}) async {
    int stateNum = CallUtils.stateToNum(userStates!);

    await _userCollection.doc(userId).update({
      'state': stateNum,
    });
  }

  // for rating
  static Future<void> setDoctorRating(String userId, double newRatingNum) async {
    DocumentSnapshot snapshot = await _userCollection.doc(userId).get();
    double ratingNum = snapshot['ratingNum'];
    if (ratingNum <= 0) {
      ratingNum = ratingNum + newRatingNum;
    } else {
      ratingNum = ((ratingNum + newRatingNum) / 2).toDouble();
    }
    // ratingNum = newRatingNum;

    await _userCollection.doc(userId).update({
      'ratingNum': ratingNum,
    });
  }

  static Stream<DocumentSnapshot> getUserStream({required String? uid}) =>
      _userCollection.doc(uid).snapshots();

  static Future<List<m.User>> fetchLastRatingDoctor() async {
    QuerySnapshot qshot =
        await _userCollection.orderBy('timestampField', descending: true).limit(10).get();

    return qshot.docs
        .map((value) => m.User(
              (value.data() as Map<String, dynamic>)['uid'] ?? '',
              (value.data() as Map<String, dynamic>)['email'] ?? '',
              fullName: (value.data() as Map<String, dynamic>)['fullName'] ?? '',
              job: (value.data() as Map<String, dynamic>)['job'] ?? '',
              profileImage: (value.data() as Map<String, dynamic>)['profileImage'] ?? '',
              noSIP: (value.data() as Map<String, dynamic>)['noSIP'] ?? '',
              status: (value.data() as Map<String, dynamic>)['status'] ?? '',
              ratingNum: (value.data() as Map<String, dynamic>)['ratingNum'] ?? '',
              state: (value.data() as Map<String, dynamic>)['state'] ?? '',
              alumnus: (value.data() as Map<String, dynamic>)['alumnus'] ?? '',
              tempatPraktek: (value.data() as Map<String, dynamic>)['tempatPraktek'] ?? '',
            ))
        .toList();
  }

  // static Stream<List<User>> fetchLastRatingDoctor() {
  //   Stream<QuerySnapshot> stream = _userCollection.snapshots();
  //   return stream.map((queryDoctor) => queryDoctor.documents
  //       .map((doc) => User(
  //             doc.data['id'],
  //             doc.data['email'],
  //             fullName: doc.data['fullName'],
  //             job: doc.data['job'],
  //             profileImage: doc.data['profileImage'],
  //             noSIP: doc.data['noSIP'],
  //             status: doc.data['status'],
  //             ratingNum: doc.data['ratingNum'],
  //             state: doc.data['state'],
  //             alumnus: doc.data['alumnus'],
  //             tempatPraktek: doc.data['tempatPraktek'],
  //           ))
  //       .toList());
  // }
}
