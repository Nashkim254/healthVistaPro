part of 'pages.dart';

class PatientListMedicalRecordPage extends StatefulWidget {
  final m.User user;

  PatientListMedicalRecordPage({required this.user});
  @override
  _PatientListMedicalRecordPageState createState() =>
      _PatientListMedicalRecordPageState();
}

class _PatientListMedicalRecordPageState
    extends State<PatientListMedicalRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocalizationService.of(context).translate("medical_records")!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: HistoryPatientServices.getPatientDataTest(
              doctorId: widget.user.id,
            ),
            builder: (_, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
              if (dataSnapshot.hasData) {
                var doc = dataSnapshot.data!.docs;
                return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PatientMedRecordView(
                                  doc: doc[index].id,
                                  currentUser: widget.user,
                                  patientName: doc[index]['patientName'],
                                );
                              },
                            ));
                          },
                          child: Container(
                            height: 50,
                            child: Card(
                              child: Center(
                                  child: Text(
                                doc[index]['patientName'],
                                style: blackTextFont.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                            ),
                          ),
                        ));
                  },
                );
              } else {
                return const SpinKitFadingCircle(color: accentColor2, size: 100);
              }
            }),
      ),
    );
  }
}

class PatientMedRecordView extends StatefulWidget {
  final doc;
  final patientName;
  final m.User? currentUser;
  PatientMedRecordView({this.doc, this.currentUser, this.patientName});
  @override
  _PatientMedRecordViewState createState() => _PatientMedRecordViewState();
}

class _PatientMedRecordViewState extends State<PatientMedRecordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocalizationService.of(context).translate("medical_records_view")!),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    widget.patientName,
                    style: blackTextFont.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: HistoryPatientServices.getPatientData(
                    doctorId: widget.currentUser!.id,
                    patientContactId: widget.doc),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var doc = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: doc.length,
                      itemBuilder: (context, index) {
                        DateTime date = (doc[index]['timeAddedConsultation'] as Timestamp).toDate();

                        String formatDate =
                            DateFormat.yMMMMEEEEd().add_jms().format(date);
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  String documentIdIndex =
                                      doc[index].id;
                                  return PatientMedRecordDetailPage(
                                    doc: widget.doc,
                                    user: widget.currentUser!,
                                    documentId: documentIdIndex,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              height: 80,
                              child: Card(
                                elevation: 5,
                                child: Center(
                                  child: Wrap(
                                    children: [
                                      Text(
                                        formatDate,
                                        style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    );
                  } else {
                    return const SpinKitFadingCircle(color: accentColor2, size: 100);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientMedRecordDetailPage extends StatefulWidget {
  final doc;
  final String? documentId;
  final m.User? user;
  PatientMedRecordDetailPage({this.doc, this.user, this.documentId});
  @override
  _PatientMedRecordDetailPageState createState() =>
      _PatientMedRecordDetailPageState();
}

class _PatientMedRecordDetailPageState
    extends State<PatientMedRecordDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocalizationService.of(context).translate("medical_records_detail")!),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: HistoryPatientServices.getPatientData(
            doctorId: widget.user!.id, patientContactId: widget.doc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data!.docs;
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
               m.PatientMedRecord patientMedRecord =
    m.PatientMedRecord.fromMap(doc[index].data() as Map<String, dynamic>);
                return Column(
                  children: [
                    MedicalRecordCard(
                      patientMedRecordDataName: patientMedRecord.doctorName!,
                      title: LocalizationService.of(context).translate("doctor_name")!,
                    ),
                    MedicalRecordCard(
                        patientMedRecordDataName: patientMedRecord.patientName!,
                        title: LocalizationService.of(context).translate("patient_name")!),
                    MedicalRecordCard(
                      patientMedRecordDataName: patientMedRecord.patientAge!,
                      title: LocalizationService.of(context).translate("patient_age")!,
                    ),
                    MedicalRecordCard(
                        patientMedRecordDataName:
                            patientMedRecord.patientStatus!,
                        title: LocalizationService.of(context).translate("patient_status")!),
                    MedicalRecordCard(
                        patientMedRecordDataName:
                            patientMedRecord.patientDiagnose!,
                        title:  LocalizationService.of(context).translate("patient_diagnose")!),
                  ],
                );
              },
            );
          } else {
            return const SpinKitFadingCircle(color: accentColor2, size: 100);
          }
        },
      ),
    );
  }
}

class MedicalRecordCard extends StatelessWidget {
  const MedicalRecordCard({
    Key? key,
    required this.patientMedRecordDataName,
    required this.title,
  }) : super(key: key);

  final String patientMedRecordDataName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title : ",
                style: blackTextFont.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            (patientMedRecordDataName == "")
                ? Text(
                    LocalizationService.of(context).translate("nodata")!,
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                    ),
                  )
                : Text(
                    patientMedRecordDataName,
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

// class MedicalRecordCardTile extends StatelessWidget {
//   const MedicalRecordCardTile({
//     Key key,
//     @required this.patientMedRecordDataName,
//   }) : super(key: key);

//   final String patientMedRecordDataName;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Doctor Name : ",
//               style: blackTextFont.copyWith(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               )),
//           Text(
//             patientMedRecord,
//             style: blackTextFont.copyWith(
//               fontSize: 16,
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }
