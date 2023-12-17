part of 'pages.dart';

class PickUpScreen extends StatefulWidget {
  final m.Call call;
  final m.User? caller;
  final m.User? receiver;
  PickUpScreen({required this.call, this.caller, this.receiver});

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  // bool isStop = true;
  // int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocalizationService.of(context).translate("incoming_calls")!,
              style: blackTextFont.copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            CachedImage(
              widget.call.callerPhoto!,
              height: 200,
              width: 200,
              isRounded: true,
              radius: 180,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.call.callerName!,
                style: blackTextFont.copyWith(
                  fontSize: 20,
                )),
            const SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () async {
                    var permission = await Permission.camera.request();
                            var mic = await Permission.microphone.request();
                      if (permission.isGranted &&mic.isGranted) {
                        context.read<PageBloc>().add(GoToCallScreenPage(
                            call: widget.call,
                            sender: widget.caller,
                            receiver: widget.receiver));
                      }
                    }),
                const SizedBox(
                  width: 25,
                ),
                IconButton(
                    icon: const Icon(Icons.call_end, color: Colors.red),
                    onPressed: () async {
                      await CallServices.endCall(call: widget.call);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
