part of 'pages.dart';

class HistoryPatientPage extends StatefulWidget {
  final m.Call? call;
  HistoryPatientPage({this.call});
  @override
  _HistoryPatientPageState createState() => _HistoryPatientPageState();
}

class _HistoryPatientPageState extends State<HistoryPatientPage> {
  TextEditingController patientNameController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController currentCondition = TextEditingController();
  String patientStatus = "";

  Timestamp? dateTime;
  String formattedDate = "";

  @override
  void initState() {
    super.initState();
    patientNameController = TextEditingController(
        text: (widget.call!.callerStatus == "Doctor")
            ? widget.call!.receiverName
            : widget.call!.callerName);
    doctorNameController = TextEditingController(
        text: (widget.call!.callerStatus == "Doctor")
            ? widget.call!.callerName
            : widget.call!.receiverName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "History Patient Page",
            style: blackTextFont.copyWith(fontSize: 20),
          ),
        ),
        body: (widget.call!.callerStatus == "Doctor")
            ? ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Please filled up the patient ${widget.call!.receiverName} history",
                          style: blackTextFont.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: defaultMargin,
                        ),
                        TextField(
                          controller: patientNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Patient's name"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: doctorNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Doctor's name"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: ageController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Patient's Age"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: symptomController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Patient's Diagnosis"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Patient Status"),
                              RadioListTile(
                                  title: const Text("Outpatient Treatment"),
                                  value: "Outpatient Treatment",
                                  groupValue: patientStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      patientStatus = value!;
                                    });
                                  }),
                              RadioListTile(
                                  title: const Text("Internal Referral"),
                                  value: "Internal Referral",
                                  groupValue: patientStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      patientStatus = value!;
                                    });
                                  }),
                              RadioListTile(
                                  title: const Text("Further Referral"),
                                  value: "Further Referral",
                                  groupValue: patientStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      patientStatus = value!;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: TextEditingController(text: formattedDate),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Consultation Date",
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2030),
                                  ).then((date) {
                                    setState(() {
                                      formattedDate = DateFormat('dd-MM-yyyy').format(date!);
                                      dateTime = Timestamp.fromMillisecondsSinceEpoch(
                                          date.millisecondsSinceEpoch);
                                    });
                                  });
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 85,
                          width: 250,
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), backgroundColor: mainColor, disabledForegroundColor: accentColor3.withOpacity(0.38), disabledBackgroundColor: accentColor3.withOpacity(0.12),
                              textStyle: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              var namaPasien = patientNameController.text;
                              var umurPasien = ageController.text;
                              var diagnosaPasien = symptomController.text;

                              m.HistoryPatient historyPatient = m.HistoryPatient(
                                patientId: widget.call!.receiverId,
                                doctorId: widget.call!.callerId,
                                patientAge: umurPasien,
                                doctorName: widget.call!.callerName,
                                patientDiagnose: diagnosaPasien,
                                patientStatus: patientStatus,
                                patientName: namaPasien,
                                timestamp: Timestamp.now(),
                              );

                              HistoryPatientServices.addHistoryToDb(
                                historyPatient: historyPatient,
                              );

                              HistoryPatientServices.addHistoryPatientDoctorToDb(
                                historyPatient: historyPatient,
                              );

                              // if (receiver != null && sender != null) {
                              //   context.bloc<PageBloc>().add(GoToChatScreenPage(
                              //       receiver: receiver, sender: sender));
                              // }
                              context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
                            },
                            child: Text(
                              "Submit Patient ${widget.call!.receiverName} History",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Please filled up the patient ${widget.call!.callerName} history",
                          style: blackTextFont.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: defaultMargin,
                        ),
                        TextField(
                          controller: patientNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Nama Pasien"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: doctorNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Nama Dokter"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: ageController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Umur Pasien"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: symptomController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Diagnosa Pasien"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          child: Column(
                            children: [
                              const Text("Patient Status"),
                              RadioListTile(
                                  title: const Text("Berobat Jalan"),
                                  value: "Berobat Jalan",
                                  groupValue: patientStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      patientStatus = value!;
                                    });
                                  }),
                              RadioListTile(
                                  title: const Text("Rujuk Internal"),
                                  value: "Rujuk Internal",
                                  groupValue: patientStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      patientStatus = value!;
                                    });
                                  }),
                              RadioListTile(
                                  title: const Text("Rujuk Lanjut"),
                                  value: "Rujuk Lanjut",
                                  groupValue: patientStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      patientStatus = value!;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: TextEditingController(text: formattedDate),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Tanggal Konsultasi",
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2030),
                                  ).then((date) {
                                    setState(() {
                                      formattedDate = DateFormat('dd-MM-yyyy').format(date!);
                                      dateTime = Timestamp.fromMillisecondsSinceEpoch(
                                          date.millisecondsSinceEpoch);
                                    });
                                  });
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 85,
                          width: 250,
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), backgroundColor: mainColor, disabledForegroundColor: accentColor3.withOpacity(0.38), disabledBackgroundColor: accentColor3.withOpacity(0.12),
                              textStyle: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              var namaPasien = patientNameController.text;
                              var umurPasien = ageController.text;
                              var diagnosaPasien = symptomController.text;

                              m.HistoryPatient historyPatient = m.HistoryPatient(
                                patientId: widget.call!.callerId,
                                doctorId: widget.call!.receiverId,
                                patientAge: umurPasien,
                                doctorName: widget.call!.receiverName,
                                patientDiagnose: diagnosaPasien,
                                patientStatus: patientStatus,
                                patientName: namaPasien,
                                timestamp: Timestamp.now(),
                              );

                              HistoryPatientServices.addHistoryToDb(
                                historyPatient: historyPatient,
                              );
                              HistoryPatientServices.addHistoryPatientDoctorToDb(
                                historyPatient: historyPatient,
                              );

                              // if (receiver != null && sender != null) {
                              //   context.bloc<PageBloc>().add(GoToChatScreenPage(
                              //       receiver: receiver, sender: sender));
                              // }
                              context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
                            },
                            child: Text(
                              "Submit Patient ${widget.call!.callerName} History",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
