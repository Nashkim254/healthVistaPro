// main.dart
// ... (Previous code remains unchanged)
part of 'pages.dart';

class VaccinePage extends StatefulWidget {
  @override
  State<VaccinePage> createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  @override
  void initState() {
    // This method is called only once when the widget is inserted into the tree.
    // You can perform one-time initialization tasks here.
    context.read<VaccineCubit>().getVaccines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vaccine Schedule")),
      body: BlocConsumer<VaccineCubit, VaccineState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is VaccineInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is VaccineLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VaccineLoaded) {
            return ListView.builder(
              itemCount: state.vaccines.length,
              itemBuilder: (context, index) {
                final vaccine = state.vaccines[index];
                return ListTile(
                  title: Text(vaccine.name),
                  subtitle:
                      Text("Scheduled on ${vaccine.scheduledDate.toLocal()}"),
                  trailing: vaccine.isCompleted
                      ? Icon(Icons.check, color: Colors.green)
                      : ElevatedButton(
                          onPressed: () async {
                            await context
                                .read<VaccineCubit>()
                                .markAsCompleted(vaccine);
                          },
                          child: Text("Mark as Complete"),
                        ),
                );
              },
            );
          } else {
            return Center(child: Text("Error occurred"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScheduleAppointmentScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
