part of 'pages.dart';

class ReminderHomePage extends StatefulWidget {
  const ReminderHomePage({super.key});

  @override
  State<ReminderHomePage> createState() => _ReminderHomePageState();
}

class _ReminderHomePageState extends State<ReminderHomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    getReminder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            _addRemindBar(),
            _addDateBar(),
            const SizedBox(
              height: 20,
            ),
            _showReminder(),
          ],
        ),
      ]),
    );
  }

  _showReminder() {
    return Expanded(
      child: 
        ListView.builder(
            itemCount: remindList.length,
            itemBuilder: (_, index) {
              m.Remind remind = remindList[index];
              if (remind.repeat == 'Daily') {
                DateTime date = DateFormat.jm().parse(remind.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]), remind);
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, remind);
                                },
                                child: RemindTile(remind))
                          ],
                        ),
                      ),
                    ));
              }
              if (remind.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, remind);
                                },
                                child: RemindTile(remind))
                          ],
                        ),
                      ),
                    ));
              } else {
                return Container();
              }
            })
    );
  }

  _showBottomSheet(BuildContext context, m.Remind remind) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 4),
            height: remind.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.24
                : MediaQuery.of(context).size.height * 0.32,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
                ),
                const Spacer(),
                remind.isCompleted == 1
                    ? Container()
                    : _bottmSheetButton(
                        label: LocalizationService.of(context).translate("complete_reminder")!,
                        onTap: () {
                          markRemindCompleted(remind.id!);
                          Navigator.pop(context);
                        },
                        clr: primaryColor,
                        context: context,
                      ),
                _bottmSheetButton(
                  label: LocalizationService.of(context).translate("delete_reminder")!,
                  onTap: () {
                    delete(remind);
                    Navigator.pop(context);
                  },
                  clr: redColor,
                  context: context,
                ),
                const SizedBox(
                  height: 20,
                ),
                _bottmSheetButton(
                  label: LocalizationService.of(context).translate("close")!,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  clr: Colors.white,
                  isClose: true,
                  context: context,
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        });
  }

  _bottmSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: isClose == true ? Colors.grey[300]! : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child:
              Text(label, style: isClose ? titleStyle : titleStyle.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: const Color(0xFFAAB6FB),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addRemindBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  LocalizationService.of(context).translate("today")!,
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: "+ " + LocalizationService.of(context).translate("add_reminder")!,
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddReminderPage()));
                getReminder();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
