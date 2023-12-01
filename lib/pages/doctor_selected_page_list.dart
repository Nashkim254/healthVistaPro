part of 'pages.dart';

class DoctorSelectedPageList extends StatefulWidget {
  final m.DoctorType doctorType;

  DoctorSelectedPageList(this.doctorType);

  @override
  _DoctorSelectedPageListState createState() => _DoctorSelectedPageListState();
}

class _DoctorSelectedPageListState extends State<DoctorSelectedPageList> {
  @override
  Widget build(BuildContext context) {
    // set Theme
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.read<PageBloc>().add(GoToMainPage());
              }),
          title: Text("Pilih ${widget.doctorType.speciality}"),
          centerTitle: true,
        ),
        body: ChatListPage(widget.doctorType.speciality),
      ),
    );
  }
}
