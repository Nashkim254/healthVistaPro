// vaccine_model.dart
part of 'models.dart';

class Vaccine {
  // int id = DateTime.now().toString().hashCode;
  static final List<Vaccine> allVaccinesSinceBirth = [
    Vaccine("Hepatitis B", DateTime.now(), false), // At Birth
    Vaccine("DTaP", DateTime.now().add(Duration(days: 60)), false), // At 2 Months
    Vaccine("IPV", DateTime.now().add(Duration(days: 60)), false), // At 2 Months
    Vaccine("Hib", DateTime.now().add(Duration(days: 60)), false), // At 2 Months
    Vaccine("PCV13", DateTime.now().add(Duration(days: 60)), false), // At 2 Months
    Vaccine("RV", DateTime.now().add(Duration(days: 60)), false), // At 2 Months
    Vaccine("DTaP", DateTime.now().add(Duration(days: 120)), false), // At 4 Months
    Vaccine("IPV", DateTime.now().add(Duration(days: 120)), false), // At 4 Months
    Vaccine("Hib", DateTime.now().add(Duration(days: 120)), false), // At 4 Months
    Vaccine("PCV13", DateTime.now().add(Duration(days: 120)), false), // At 4 Months
    Vaccine("RV", DateTime.now().add(Duration(days: 120)), false), // At 4 Months
    Vaccine("Hepatitis B", DateTime.now().add(Duration(days: 180)), false), // At 6 Months
    Vaccine("DTaP", DateTime.now().add(Duration(days: 180)), false), // At 6 Months
    Vaccine("IPV", DateTime.now().add(Duration(days: 180)), false), // At 6 Months
    Vaccine("Hib", DateTime.now().add(Duration(days: 180)), false), // At 6 Months
    Vaccine("PCV13", DateTime.now().add(Duration(days: 180)), false), // At 6 Months
    Vaccine("RV", DateTime.now().add(Duration(days: 180)), false), // At 6 Months
    Vaccine("Hib", DateTime.now().add(Duration(days: 450)), false), // At 15 Months
    Vaccine("MMR", DateTime.now().add(Duration(days: 450)), false), // At 15 Months
    Vaccine("VAR", DateTime.now().add(Duration(days: 450)), false), // At 15 Months
    Vaccine("Hepatitis A", DateTime.now().add(Duration(days: 450)), false), // At 15 Months
    Vaccine("DTaP", DateTime.now().add(Duration(days: 540)), false), // At 18 Months
    Vaccine("IPV", DateTime.now().add(Duration(days: 540)), false), // At 18 Months
    Vaccine("Hepatitis A", DateTime.now().add(Duration(days: 540)), false), // At 18 Months
    Vaccine("DTaP", DateTime.now().add(Duration(days: 2190)), false), // At 4-6 Years
    Vaccine("IPV", DateTime.now().add(Duration(days: 2190)), false), // At 4-6 Years
    Vaccine("MMR", DateTime.now().add(Duration(days: 2190)), false), // At 4-6 Years
    Vaccine("VAR", DateTime.now().add(Duration(days: 2190)), false), // At 4-6 Years
  ];

  final int? id;
  final String name;
  final DateTime scheduledDate;
  bool isCompleted;

  Vaccine( this.name, this.scheduledDate, this.isCompleted) : id = DateTime.now().toString().hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scheduledDate': scheduledDate.toUtc().toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      json['name'],
      DateTime.parse(json['scheduledDate']),
      json['isCompleted'],
    );
  }
}
