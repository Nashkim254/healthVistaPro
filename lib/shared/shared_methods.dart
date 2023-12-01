part of 'shared.dart';

// fungsi untuk mengambil gambar dari galery handphone
Future<File> getImage() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return File(image!.path);
}

Future<File> getImageCamera() async {
  var imageCam = await ImagePicker().pickImage(source: ImageSource.camera);
  return File(imageCam!.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  // Create a reference to the file in Firebase Storage
  Reference ref = FirebaseStorage.instance.ref().child(fileName);

  // Upload the file to Firebase Storage
  UploadTask task = ref.putFile(image);

  // Wait for the upload to complete
  TaskSnapshot snapshot = await task.whenComplete(() {});

  // Get the download URL of the uploaded file
  String downloadUrl = await snapshot.ref.getDownloadURL();

  // Return the download URL
  return downloadUrl;
}

void uploadImageMessage(
    {File? image,
    User? receiver,
    User? sender,
    ImageUploadProvider? imageUploadProvider}) async {
// set loading when user already pick image
  imageUploadProvider!.setToLoading();
  // get urlImage
  String imageMsgUrl = await uploadImage(image!);
  // hide loading
  imageUploadProvider.setToIdle();

  setImageMessage(imageMsgUrl, receiver, sender, imageUploadProvider);
}

void setImageMessage(String? imageMsgUrl, User? receiver, User? sender,
    ImageUploadProvider imageUploadProvider) async {
  CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');
  Message _message;
  _message = Message.imageMessage(
    message: "IMAGE",
    receiverId: receiver!.id!,
    senderName: sender!.fullName!,
    receiverName: receiver.fullName!,
    senderId: sender.id!,
    photoUrl: imageMsgUrl!,
    timeStamp: Timestamp.now(),
    type: "image",
  );

  var map = _message.toImageMap();

  // set the data to database
  await _messageCollection
      .doc(map.senderId)
      .collection(map.receiverId!)
      .add({
    'message': map.message,
    'senderId': map.senderId,
    'receiverId': map.receiverId,
    'senderName': map.senderName,
    'receiverName': map.receiverName,
    'timeStamp': map.timeStamp,
    'type': map.type,
    'photoUrl': map.photoUrl,
  });

  await _messageCollection
      .doc(map.receiverId)
      .collection(map.senderId!)
      .add({
    'message': map.message,
    'senderId': map.senderId,
    'receiverId': map.receiverId,
    'senderName': map.senderName,
    'receiverName': map.receiverName,
    'timeStamp': map.timeStamp,
    'type': map.type,
    'photoUrl': map.photoUrl,
  });
}

// Future<String> selectDate(BuildContext context, DateTime dateTime) async {
//   var date = DateTime.now().toString();
//   var dateParse = DateTime.parse(date);
//   var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

//   return formattedDate;
// }

// Future<String> selectTime(BuildContext context, TimeOfDay time) async{
//   TimeOfDay picked = await
// }
