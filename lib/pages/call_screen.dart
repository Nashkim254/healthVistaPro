part of 'pages.dart';

class CallScreen extends StatefulWidget {
  final m.Call call;
  final m.User? caller;
  final m.User? receiver;

  CallScreen({required this.call, this.caller, this.receiver});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  StreamSubscription? callStreamSubscription;
  UserProvider? userProvider;

  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool isCalling = true;
  DateTime? startTime;
  String elapsed = '00:00:00';
  late RtcEngine _engine;
   int? _remoteUid;
  bool _localUserJoined = false;
  // void startTimeCall() {
  //   startTime = DateTime.now();
  // }
  void startTimeCall() {
    swatch.start();
  }

  Stopwatch swatch = Stopwatch();

  String showTimeCallDuration() {
    return elapsed = swatch.elapsed.inHours.toString().padLeft(2, "0") +
        "h:" +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        "m:" +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
        "s";
  }

  @override
  void initState() {
    super.initState();
    addPostFrameCallback(this.context);
    initAgora();
    // time call start
    startTimeCall();
  }

  addPostFrameCallback(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);

      callStreamSubscription =
          CallServices.callStream(id: userProvider!.getUser.id)
              .listen((DocumentSnapshot ds) {
        // defining the logic
        switch (ds.data) {
          case null:
            // snapshot is null which means that call is hanged and documents are deleted
            // Navigator.pop(context);
            m.User caller = widget.caller!;
            m.User receiver = widget.receiver!;
            if (userProvider!.getUser.id == widget.call.callerId) {
              context
                  .read<PageBloc>()
                  .add(GoToChatScreenPage(sender: caller, receiver: receiver));
            } else {
              context
                  .read<PageBloc>()
                  .add(GoToChatScreenPage(sender: receiver, receiver: caller));
            }

            break;

          default:
            break;
        }
      });
    });
  }






  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: APP_ID,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }
  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
//  m.User receiver =
//                   await UserServices.getUser(widget.call.receiverId!);
//               m.User sender = await UserServices.getUser(widget.call.callerId!);
//               elapsed = showTimeCallDuration();
//               saveCall(receiver, sender);
//               CallServices.endCall(call: widget.call);
  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
   void saveCall(m.User receiver, m.User sender) {
    var text = (sender.status == "Doctor")
        ? "call by dr.${widget.call.callerName}"
        : "call by ${widget.call.callerName}";
    m.Message _message = m.Message(
        receiverId: widget.call.receiverId,
        senderId: widget.call.callerId,
        receiverName: widget.call.receiverName,
        senderName: widget.call.callerName,
        timeStamp: Timestamp.now(),
        message: text,
        callDuration: elapsed,
        type: "call");
    MessageServices.addMessageToDb(_message, sender, receiver);
  }
}


