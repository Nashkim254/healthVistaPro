part of 'services.dart';

class MessageServices {
  static CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');

  static Future addMessageToDb(
      m.Message message, m.User sender, m.User receiver) async {
    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId!)
        .add({
      'message': message.message,
      'senderId': message.senderId,
      'senderName': sender.fullName,
      'receiverName': receiver.fullName,
      'receiverId': message.receiverId,
      'timeStamp': message.timeStamp,
      'type': message.type,
      'callDuration': message.callDuration ?? "",
    });

    addToContact(senderId: message.senderId, receiverId: message.receiverId);

    return await _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId!)
        .add({
      'message': message.message,
      'senderId': message.senderId,
      'senderName': sender.fullName,
      'receiverName': receiver.fullName,
      'receiverId': message.receiverId,
      'timeStamp': message.timeStamp,
      'type': message.type,
      'callDuration': message.callDuration ?? "",
    });
  }

  static DocumentReference getContactsDocument({String? of, String? forContact}) {
    return UserServices._userCollection
        .doc(of)
        .collection("contacts")
        .doc(forContact);
  }

  static void addToContact({String? senderId, String? receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId!, receiverId!, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  static Future<void> addToSenderContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();
    if (!senderSnapshot.exists) {
      // tidak ada data
      m.Contact receiverContact = m.Contact(id: receiverId, addedOn: currentTime);

      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(of: senderId, forContact: receiverId)
          .set(receiverMap);
    }
  }

  static Future<void> addToReceiverContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();
    if (!receiverSnapshot.exists) {
      // tidak ada data
      m.Contact senderContact = m.Contact(id: senderId, addedOn: currentTime);

      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .set(senderMap);
    }
  }

  static Stream<QuerySnapshot> fetchContacts({String? userId}) {
    return UserServices._userCollection
        .doc(userId)
        .collection("contacts")
        .snapshots();
  }

  static Stream<QuerySnapshot> fetchLastMessageBetween({
    required String senderId,
    required String receiverId,
  }) {
    return _messageCollection
        .doc(senderId)
        .collection(receiverId)
        .orderBy("timeStamp")
        .snapshots();
  }
}
