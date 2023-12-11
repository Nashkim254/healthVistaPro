part of 'models.dart';

class Remind {
  int? id;
  String? title;
  String? dose;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  String? repeat;

  Remind({
    this.id,
    this.title,
    this.dose,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.repeat,
  });
  
  Remind.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    dose = json['dose'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['dose'] = dose;
    data['isCompleted'] = isCompleted;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['repeat'] = repeat;
    return data;

 
 }

}