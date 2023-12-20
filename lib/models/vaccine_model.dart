// vaccine_model.dart
part of 'models.dart';

class Vaccine {
  // int id = DateTime.now().toString().hashCode;
  static final List<Vaccine> allVaccinesSinceBirth = [
    Vaccine(DateTime.now().toString().hashCode,"Hepatitis B", DateFormat.yMd().format(DateTime.now()), 0), // At Birth
    Vaccine(DateTime.now().toString().hashCode,"DTaP", DateFormat.yMd().format(DateTime.now().add(Duration(days: 60))), 0), // At 2 Months
    Vaccine(DateTime.now().toString().hashCode,"IPV", DateFormat.yMd().format(DateTime.now().add(Duration(days: 60))), 0), // At 2 Months
    Vaccine(DateTime.now().toString().hashCode,"Hib",DateFormat.yMd().format( DateTime.now().add(Duration(days: 60))), 0), // At 2 Months
    Vaccine(DateTime.now().toString().hashCode,"PCV13",DateFormat.yMd().format( DateTime.now().add(Duration(days: 60))), 0), // At 2 Months
    Vaccine(DateTime.now().toString().hashCode,"RV", DateFormat.yMd().format(DateTime.now().add(Duration(days: 60))), 0), // At 2 Months
    Vaccine(DateTime.now().toString().hashCode,"DTaP", DateFormat.yMd().format(DateTime.now().add(Duration(days: 120))), 0), // At 4 Months
    Vaccine(DateTime.now().toString().hashCode,"IPV",DateFormat.yMd().format( DateTime.now().add(Duration(days: 120))), 0), // At 4 Months
    Vaccine(DateTime.now().toString().hashCode,"Hib", DateFormat.yMd().format(DateTime.now().add(Duration(days: 120))), 0), // At 4 Months
    Vaccine(DateTime.now().toString().hashCode,"PCV13", DateFormat.yMd().format(DateTime.now().add(Duration(days: 120))), 0), // At 4 Months
    Vaccine(DateTime.now().toString().hashCode,"RV", DateFormat.yMd().format(DateTime.now().add(Duration(days: 120))), 0), // At 4 Months
    Vaccine(DateTime.now().toString().hashCode,"Hepatitis B", DateFormat.yMd().format(DateTime.now().add(Duration(days: 180))), 0), // At 6 Months
    Vaccine(DateTime.now().toString().hashCode,"DTaP", DateFormat.yMd().format(DateTime.now().add(Duration(days: 180))), 0), // At 6 Months
    Vaccine(DateTime.now().toString().hashCode,"IPV",DateFormat.yMd().format( DateTime.now().add(Duration(days: 180))), 0), // At 6 Months
    Vaccine(DateTime.now().toString().hashCode,"Hib",DateFormat.yMd().format( DateTime.now().add(Duration(days: 180))), 0), // At 6 Months
    Vaccine(DateTime.now().toString().hashCode,"PCV13", DateFormat.yMd().format(DateTime.now().add(Duration(days: 180))), 0), // At 6 Months
    Vaccine(DateTime.now().toString().hashCode,"RV", DateFormat.yMd().format(DateTime.now().add(Duration(days: 180))), 0), // At 6 Months
    Vaccine(DateTime.now().toString().hashCode,"Hib", DateFormat.yMd().format(DateTime.now().add(Duration(days: 450))), 0), // At 15 Months
    Vaccine(DateTime.now().toString().hashCode,"MMR",DateFormat.yMd().format( DateTime.now().add(Duration(days: 450))), 0), // At 15 Months
    Vaccine(DateTime.now().toString().hashCode,"VAR",DateFormat.yMd().format( DateTime.now().add(Duration(days: 450))), 0), // At 15 Months
    Vaccine(DateTime.now().toString().hashCode,"Hepatitis A",DateFormat.yMd().format( DateTime.now().add(Duration(days: 450))), 0), // At 15 Months
    Vaccine(DateTime.now().toString().hashCode,"DTaP",DateFormat.yMd().format( DateTime.now().add(Duration(days: 540))), 0), // At 18 Months
    Vaccine(DateTime.now().toString().hashCode,"IPV", DateFormat.yMd().format(DateTime.now().add(Duration(days: 540))), 0), // At 18 Months
    Vaccine(DateTime.now().toString().hashCode,"Hepatitis A", DateFormat.yMd().format(DateTime.now().add(Duration(days: 540))), 0), // At 18 Months
    Vaccine(DateTime.now().toString().hashCode,"DTaP", DateFormat.yMd().format(DateTime.now().add(Duration(days: 2190))), 0), // At 4-6 Years
    Vaccine(DateTime.now().toString().hashCode,"IPV", DateFormat.yMd().format(DateTime.now().add(Duration(days: 2190))), 0), // At 4-6 Years
    Vaccine(DateTime.now().toString().hashCode,"MMR", DateFormat.yMd().format( DateTime.now().add(Duration(days: 2190))), 0), // At 4-6 Years
    Vaccine(DateTime.now().toString().hashCode,"VAR", DateFormat.yMd().format(DateTime.now().add(Duration(days: 2190))) , 0), // At 4-6 Years
  ];

  final int? id;
  final String name;
  final String scheduledDate;
  int isCompleted;

  Vaccine(this.id, this.name, this.scheduledDate, this.isCompleted);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scheduledDate': scheduledDate,
      'isCompleted': isCompleted,
    };
  }

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      json['id'],
      json['name'],
      json['scheduledDate'],
      json['isCompleted'],
    );
  }
}
