// schedule_appointment_screen.dart
part of 'pages.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  @override
  _ScheduleAppointmentScreenState createState() => _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  late DateTime _selectedDate;
  m.Vaccine? selectedVaccine;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule Vaccine Appointment")),
      body: Column(
        children: [
          DropdownButton<m.Vaccine>(
            value: selectedVaccine,
            items: m.Vaccine.allVaccinesSinceBirth.map((m.Vaccine vaccine) {
              return DropdownMenuItem<m.Vaccine>(
                value: vaccine,
                child: Text(vaccine.name),
              );
            }).toList(),
            onChanged: (m.Vaccine? newValue) {
              setState(() {
                selectedVaccine = newValue;
              });
            },
            hint: Text('Select a Vaccine'),
          ),
          SizedBox(height: 20),
          if (selectedVaccine != null) Text('Selected Vaccine: ${selectedVaccine!.name}'),
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2022),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
           
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
             print("day selected: " + selectedDay.toString());
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              // Add logic to schedule appointment
              m.Vaccine vaccine = m.Vaccine(selectedVaccine!.id, selectedVaccine!.name,
                  DateFormat.yMd().format(_selectedDate), selectedVaccine!.isCompleted);
              final vaccineBloc = context.read<VaccineCubit>();
              // Assuming you have a Vaccine model and you want to schedule a new
              vaccineBloc.addVaccine(vaccine);
              Navigator.pop(context);
            },
            child: Text("Schedule"),
          ),
        ],
      ),
    );
  }
}
