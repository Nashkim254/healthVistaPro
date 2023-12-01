part of 'services.dart';

class CallServices {
  static CollectionReference _callCollection =
      FirebaseFirestore.instance.collection('call');

  // static CollectionReference _callLogCollection =
  //     Firestore.instance.collection('callLogs');

  static Future<bool> makeCall({m.Call? call}) async {
    try {
      call!.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await _callCollection.doc(call.callerId).set(hasDialledMap);
      await _callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // static Future<void> saveCallLog({Call call}) async {
  //   return await _callLogCollection
  //       .document(call.callerId)
  //       .collection(call.receiverId)
  //       .add({'': call.ca});
  // }

  static Future<bool> endCall({m.Call? call}) async {
    try {
      await _callCollection.doc(call!.callerId).delete();
      await _callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Stream<DocumentSnapshot> callStream({String? id}) =>
      _callCollection.doc(id).snapshots();
}
