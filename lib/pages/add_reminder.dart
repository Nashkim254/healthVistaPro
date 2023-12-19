part of 'pages.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "09:15 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
  ];

  int _selectedColor = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getReminder();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(context),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Reminder",
                  style: headingStyle,
                ),
                MyInputField(
                  title: "Med Name",
                  hint: "Enter Med Name Here..",
                  controller: _titleController,
                ),
                MyInputField(
                  title: "Dose",
                  hint: "Enter Dose Here..",
                  controller: _doseController,
                ),
                MyInputField(
                  title: "Date",
                  hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today_outlined, color: Colors.grey[700]),
                    onPressed: () {
                      _getDate();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: "Start",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTime(isStartTime: true);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: "End",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTime(isStartTime: false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                MyInputField(
                  title: "Repeat",
                  hint: "$_selectedRepeat",
                  widget: DropdownButton(
                      // onChanged: (value){
                      // },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[700],
                      ),
                      iconSize: 30,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      items: repeatList.map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value!, style: const TextStyle(color: Colors.grey)));
                      }).toList()),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPalette(),
                    MyButton(label: "Create Reminder", onTap: () => _validateDate())
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _doseController.text.isNotEmpty) {
      _addRemindDb();
      Navigator.pop(context);
    } else if (_titleController.text.isEmpty || _doseController.text.isEmpty) {
      var messengar = ScaffoldMessenger.of(context);
      messengar.showSnackBar(
        const SnackBar(
          content: Text("Required, All fields must be filled!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  _addRemindDb() async {
    int value = await addRemind(
        remind: m.Remind(
      dose: _doseController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    ));
    print("id = " + "$value");
  }

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 6.0,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: index == 0
                      ? greenColor
                      : index == 1
                          ? bluishClr
                          : pinkClr,
                  child: _selectedColor == index
                      ? const Icon(Icons.done, color: Colors.white, size: 14)
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
        // Icon(Icons.person,
        // size: 20,),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2122));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Cant be empty, Try Again!");
    }
  }

  _getTime({required bool isStartTime}) async {
    var pickedTime = await _showTImePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time cancel");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTImePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
