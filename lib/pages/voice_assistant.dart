part of 'pages.dart';

class NurseAssistant extends StatefulWidget {
  const NurseAssistant({super.key});

  @override
  State<NurseAssistant> createState() => _NurseAssistantState();
}

class _NurseAssistantState extends State<NurseAssistant> {
  _NurseAssistantState() {
    AlanVoice.addButton(
        "f65c0e88e8624942c3975d3367b66ed32e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan AI Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }
  void _handleCommand(Map<String, dynamic> command) {
    debugPrint("getting -------------->command");
    switch (command["command"]) {
      case "forward":
        debugPrint("forward -------------->command");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NurseAssistant()));
        break;
      case "back":
        debugPrint("Go back <---------------command");
        Navigator.pop(context);
        break;
      default:
        debugPrint("Unknown command");
    }
  }

  @override
  Widget build(BuildContext context) {
    getReminder();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       context.bloc<PageBloc>().add(GoToMainPage());
        //     }),
        title: Text(LocalizationService.of(context).translate("nurse_assistant")!,
            style: blackTextFont.copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/nurse.jpeg"),
            ],
          ),
        ),
      ),
    );
  }
}
