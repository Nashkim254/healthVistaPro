part of 'services.dart';

class HistoryPatientServices {
  // call reference document
  static CollectionReference _historyPatientCollection =
      FirebaseFirestore.instance.collection('historyPatient');

  static CollectionReference _historyDoctorPatientCollection =
      FirebaseFirestore.instance.collection('historyDoctorPatient');

  // to save patient medical record
  static Future<void> addHistoryToDb({m.HistoryPatient? historyPatient}) async {
    await _historyPatientCollection
        .doc(historyPatient!.patientId)
        .collection(historyPatient.doctorId!)
        .add({
      'patientId': historyPatient.patientId,
      'patientName': historyPatient.patientName,
      'patientAge': historyPatient.patientAge ?? "",
      'patientDiagnose': historyPatient.patientDiagnose ?? "",
      'patientStatus': historyPatient.patientStatus ?? "",
      'doctorId': historyPatient.doctorId,
      'doctorName': historyPatient.doctorName,
      'timeAddedConsultation': historyPatient.timestamp ?? Timestamp.now(),
    });
  }

  // to save patient medical record list for doctor access
  static Future addHistoryPatientDoctorToDb(
      {m.HistoryPatient? historyPatient}) async {
    // String historyPatientName = historyPatient.patientName;
    await _historyDoctorPatientCollection
        .doc("doctors")
        .collection(historyPatient!.doctorId!)
        .doc(historyPatient.patientId)
        .collection("medrecord")
        .doc()
        .set({
      'patientId': historyPatient.patientId,
      'patientName': historyPatient.patientName,
      'patientAge': historyPatient.patientAge ?? "",
      'patientDiagnose': historyPatient.patientDiagnose ?? "",
      'patientStatus': historyPatient.patientStatus ?? "",
      'doctorId': historyPatient.doctorId,
      'doctorName': historyPatient.doctorName,
      'timeAddedConsultation': historyPatient.timestamp ?? Timestamp.now(),
    });

    await _historyDoctorPatientCollection
        .doc("doctors")
        .collection(historyPatient.doctorId!)
        .doc(historyPatient.patientId)
        .set({
      'patientName': historyPatient.patientName,
    });
  }

  static Stream<QuerySnapshot> getPatientDataTest(
      {String? doctorId, String? patientContactId}) {
    return _historyDoctorPatientCollection
        .doc("doctors")
        .collection(doctorId!)
        .snapshots();
  }

  static Stream<QuerySnapshot> getPatientData(
      {String? doctorId, String? patientContactId}) {
    return _historyDoctorPatientCollection
        .doc("doctors")
        .collection(doctorId!)
        .doc(patientContactId)
        .collection("medrecord")
        .snapshots();
  }
  // static Future<List<PatientMedRecord>> getAllMedRecord(
  //     String doctorId, String patientId) async {
  //   List<PatientMedRecord> userList = List<PatientMedRecord>();
  //   QuerySnapshot querySnapshot = await _historyDoctorPatientCollection
  //       .document(doctorId)
  //       .collection(patientId)
  //       .getDocuments();
  //   for (var i = 0; i < querySnapshot.documents.length; i++) {
  //     userList.add(PatientMedRecord.fromMap(querySnapshot.documents[i].data));
  //   }
  //   return userList;
  // }
}
