part of 'pages.dart';

class ChatScreenPage extends StatefulWidget {
  final m.User? receiver;
  final m.User? sender;
  ChatScreenPage({this.receiver, this.sender});

  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  bool isConsultationDone = false;

  ImageUploadProvider? _imageUploadProvider;
  @override
  Widget build(BuildContext context) {
    // set Theme
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return WillPopScope(onWillPop: () async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Confirmation of consultation completion.",
              style: blackTextFont,
            ),
            content: Text(
              "Have you finished your consultation ?",
              style: greyTextFont,
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isConsultationDone = true;
                    Navigator.pop(context);

                    if (widget.sender!.status == "Patient") {
                      showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          String image = "";
                          widget.receiver!.profileImage == "no_pic"
                              ? image = "https://placehold.co/600x400"
                              : image = widget.receiver!.profileImage!;
                          return RatingDialog(
                            image: Image(
                              image: NetworkImage(image),
                              height: 100,
                            ),
                            title: const Text("Doctor Rating Consultation"),
                            message: Text(
                                "How was the consultation with dr. ${widget.receiver!.fullName!}"),
                            submitButtonText: "SUBMIT",
                            commentHint: "We are so happy to hear :)",
                            starColor: Colors.red,
                            onSubmitted: (RatingDialogResponse res) async {
                              await UserServices.setDoctorRating(
                                  widget.receiver!.id!, res.rating.toDouble());
                            },
                          );
                        },
                      );
                      context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
                    } else {
                      m.Call call = m.Call(
                        callerId: widget.sender!.id,
                        callerName: widget.sender!.fullName,
                        callerStatus: widget.sender!.status,
                        receiverId: widget.receiver!.id,
                        receiverName: widget.receiver!.fullName,
                        receiverStatus: widget.receiver!.status,
                      );
                      context.read<PageBloc>().add(GoToHistoryPatientPage(call));
                    }
                  });
                },
                child: Text(
                  "Yes",
                  style: blackTextFont,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: mainColor,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "No",
                  style: whiteTextFont,
                ),
              ),
            ],
            elevation: 24.0,
          );
        },
      );

      return true;
    }, child: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
      return PickupLayout(
        scaffold: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Confirmation of consultation completion.",
                          style: blackTextFont,
                        ),
                        content: Text(
                          "Have you finished your consultation ?",
                          style: greyTextFont,
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                isConsultationDone = true;
                                Navigator.pop(context);

                                if (widget.sender!.status == "Patient") {
                                  showDialog<String>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return RatingDialog(
                                        image: Image(
                                          image: NetworkImage("${widget.receiver!.profileImage}"),
                                          height: 100,
                                        ),
                                        title: const Text("Doctor Rating Consultation"),
                                        message: Text(
                                            "How was the consultation with dr. ${widget.receiver!.fullName}"),
                                        submitButtonText: "SUBMIT",
                                        commentHint: "We are so happy to hear :)",
                                        starColor: Colors.red,
                                        onSubmitted: (RatingDialogResponse res) async {
                                          print("onSubmitPressed: rating = ${res.rating}");
                                          await UserServices.setDoctorRating(
                                              widget.receiver!.id!, res.rating.toDouble());
                                        },
                                      );
                                    },
                                  );
                                  context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
                                } else {
                                  m.Call call = m.Call(
                                    callerId: widget.sender!.id,
                                    callerName: widget.sender!.fullName,
                                    callerStatus: widget.sender!.status,
                                    receiverId: widget.receiver!.id,
                                    receiverName: widget.receiver!.fullName,
                                    receiverStatus: widget.receiver!.status,
                                  );
                                  context.read<PageBloc>().add(GoToHistoryPatientPage(call));
                                }
                              });
                            },
                            child: Text(
                              "Yes",
                              style: blackTextFont,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: mainColor,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "No",
                              style: whiteTextFont,
                            ),
                          ),
                        ],
                        elevation: 24.0,
                      );
                    },
                  );
                },
              ),
              title: Column(
                children: [
                  Text(widget.receiver!.fullName!, style: whiteTextFont.copyWith(fontSize: 18)),
                  Text(
                    widget.receiver!.job!,
                    style: greyTextFont.copyWith(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Container(
                    width: 48,
                    child: Stack(
                      children: [
                        (widget.receiver!.profileImage == "no_pic")
                            ? const CircleAvatar(
                                radius: 30, backgroundImage: AssetImage("images/user_default.png"))
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  widget.receiver!.profileImage!,
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          left: 35,
                          child: OnlineDotIndicator(uid: widget.receiver!.id!),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Flexible(
                  child: ChatMessageScreen(
                receiver: widget.receiver!,
                sender: widget.sender!,
              )),
              _imageUploadProvider!.getViewState == ViewState.LOADING
                  ? Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: const CircularProgressIndicator(
                        backgroundColor: accentColor2,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              ChatBottomControl(
                receiver: widget.receiver!,
                sender: widget.sender!,
              ),
            ],
          ),
        ),
      );
    }));
  }
}

class ChatMessageScreen extends StatefulWidget {
  final m.User? sender;
  final m.User? receiver;

  ChatMessageScreen({this.sender, this.receiver});

  @override
  _ChatMessageScreenState createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    String _currentUserId = widget.sender!.id.toString();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("messages")
            .doc(_currentUserId)
            .collection(widget.receiver!.id!)
            .orderBy("timeStamp", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: SpinKitFadingCircle(
                color: accentColor2,
                size: 30,
              ),
            );
          }

          // return DashChat(messages: null, user: null, onSend: null);
          return ListView.builder(
              padding: const EdgeInsets.all(defaultMargin),
              itemCount: snapshot.data!.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                return ChatMessageItem(snapshot.data!.docs[index], _currentUserId);
              });
        });
  }
}

class ChatMessageItem extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String _currentUserId;
  ChatMessageItem(this.documentSnapshot, this._currentUserId);

  @override
  _ChatMessageItemState createState() => _ChatMessageItemState();
}

bool isShowDate = false;

class _ChatMessageItemState extends State<ChatMessageItem> {
  setShowDate(bool val) {
    setState(() {
      isShowDate = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    m.Message _message = m.Message.fromMap(widget.documentSnapshot.data() as Map<String, dynamic>);

    // var date = DateFormat.yMMMd().format(_message.timeStamp.toDate());
    // var dateNow = DateFormat.yMMMd().format(DateTime.now());
    // int check = 0;
    // if ((date == dateNow) && check > 0) {
    //   setShowDate(true);
    //   setState(() {
    //     check++;
    //   });
    // } else {
    //   setShowDate(false);
    // }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: (_message.senderId == widget._currentUserId)
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: (_message.senderId == widget._currentUserId)
            ? senderLayout(_message, context)
            : receiverLayout(_message, context),
      ),
    );
  }

  // to show the message from the sender
  Widget senderLayout(m.Message message, BuildContext context) {
    Radius messageRadius = const Radius.circular(5);
    String time = DateFormat.jm().add_MMMd().format(message.timeStamp!.toDate());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Center(
        //   child: Container(
        //     padding: EdgeInsets.all(3),
        //     decoration: BoxDecoration(
        //       color: Colors.grey[300],
        //       borderRadius: BorderRadius.circular(18),
        //     ),
        //     child: Text(date),
        //   ),
        // ),
        (message.type == "image")
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          // to see image in new page
                          builder: (context) => ViewImage(message)));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                      color: accentColor1,
                      borderRadius: BorderRadius.only(
                        bottomLeft: messageRadius,
                        topLeft: messageRadius,
                        bottomRight: messageRadius,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: getMessage(message, context),
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: accentColor1,
                    borderRadius: BorderRadius.only(
                      bottomLeft: messageRadius,
                      topLeft: messageRadius,
                      bottomRight: messageRadius,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: getMessage(message, context),
                ),
              ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            time,
            style: greyTextFont,
          ),
        ),
      ],
    );
  }

  // to show the message from the receiver
  Widget receiverLayout(m.Message message, BuildContext context) {
    Radius messageRadius = const Radius.circular(5);
    String time = DateFormat.jm().format(message.timeStamp!.toDate());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (message.type == "image")
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ViewImage(message)));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                      color: accentColor2,
                      borderRadius: BorderRadius.only(
                        bottomLeft: messageRadius,
                        topRight: messageRadius,
                        bottomRight: messageRadius,
                      )),
                  child: Padding(
                      padding: const EdgeInsets.all(5), child: getMessage(message, context)),
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: accentColor2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: messageRadius,
                      topRight: messageRadius,
                      bottomRight: messageRadius,
                    )),
                child:
                    Padding(padding: const EdgeInsets.all(5), child: getMessage(message, context)),
              ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            time,
            style: greyTextFont,
          ),
        ),
      ],
    );
  }

// Send Image
  getMessage(m.Message message, BuildContext context) {
    return (message.type == "image")
        ? (message.photoUrl != null)
            ? CachedImage(
                message.photoUrl!,
                height: 250,
                width: 250,
                radius: 10,
              )
            : const Text("no image url")
        : (message.type == "call")
            ? Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.call_end,
                      color: Colors.grey[300],
                      size: 38,
                    ),
                    Text(
                      message.callDuration!,
                      style: greyTextFont.copyWith(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              )
            : Text(
                message.message!,
                style: whiteTextFont.copyWith(fontSize: 16),
              );
  }
}

class ChatBottomControl extends StatefulWidget {
  final m.User? receiver;
  final m.User? sender;

  ChatBottomControl({this.receiver, this.sender});

  @override
  _ChatBottomControlState createState() => _ChatBottomControlState();
}

class _ChatBottomControlState extends State<ChatBottomControl> {
  TextEditingController textChatController = TextEditingController();

  bool isWriting = false;
  bool isStop = true;
  int counter = 0;
  bool showDate = false;

  setWritingTo(bool val) {
    setState(() {
      isWriting = val;
    });
  }

  ImageUploadProvider? _imageUploadProvider;

  @override
  Widget build(BuildContext context) {
    final String receiverName = widget.receiver!.fullName!;
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Container(
      // color: Colors.red,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 3.0,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, right: 8, top: 2),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 5,
                minLines: 1,
                controller: textChatController,
                style: blackTextFont,
                onChanged: (val) {
                  (val.length > 0 && val.trim() != "") ? setWritingTo(true) : setWritingTo(false);
                },
                decoration: InputDecoration(
                  hintText: (widget.receiver!.status == "Doctor")
                      ? "Write a message to  Dr.$receiverName ..."
                      : "Write a message to $receiverName ...",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
            ),
            // *image button
            (isWriting)
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(0),
                    width: 32,
                    child: IconButton(
                        icon: const Icon(
                          Icons.image,
                          size: 28,
                          color: mainColor,
                        ),
                        onPressed: () async {
                          File selectedImage = await getImage();
                          uploadImageMessage(
                              image: selectedImage,
                              receiver: widget.receiver,
                              sender: widget.sender,
                              imageUploadProvider: _imageUploadProvider);
                        })),
            // *camera button
            (isWriting)
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(0),
                    width: 32,
                    child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 28,
                          color: mainColor,
                        ),
                        onPressed: () async {
                          File selectedImage = await getImageCamera();
                          uploadImageMessage(
                              image: selectedImage,
                              receiver: widget.receiver,
                              sender: widget.sender,
                              imageUploadProvider: _imageUploadProvider);
                        })),
            // *vidcall button
            (isWriting)
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(0),
                    width: 38,
                    child: IconButton(
                        icon: const Icon(
                          Icons.video_call,
                          size: 32,
                          color: mainColor,
                        ),
                        onPressed: () async {
                          bool getPermission =
                              await Permissions.cameraAndMicrophonePermissionsGranted();
                          if (getPermission) {
                            await CallUtils.dial(
                              context: context,
                              userCaller: widget.sender,
                              userReceiver: widget.receiver,
                            );
                            bool hasCallMade = CallUtils.hasCallMade!;
                            if (hasCallMade == true) {
                              m.Call call = CallUtils.call!;
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CallScreen(
                              //         call: call,
                              //       ),
                              //     ));
                              context.read<PageBloc>().add(GoToCallScreenPage(
                                  call: call, sender: widget.sender, receiver: widget.receiver));
                            }
                          } else {}
                        }),
                  ),
            // *send button
            (isWriting)
                ? Container(
                    width: 38,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: mainColor),
                    child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          size: 18,
                          color: accentColor2,
                        ),
                        onPressed: () {
                          sendMessage();
                        }),
                  )
                : Container(),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    var text = textChatController.text;
    m.Message _message = m.Message(
      receiverId: widget.receiver!.id,
      senderId: widget.sender!.id!,
      message: text,
      timeStamp: Timestamp.now(),
      type: 'text',
      receiverName: widget.receiver!.fullName!,
      senderName: widget.sender!.fullName,
    );

    // when send message tap
    setState(() {
      isWriting = false;
      textChatController.text = "";
      showDate = false;
    });

    MessageServices.addMessageToDb(_message, widget.sender!, widget.receiver!);
  }
}
