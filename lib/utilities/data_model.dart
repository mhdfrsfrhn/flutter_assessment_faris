import 'package:intl/intl.dart';
import 'package:sd1_flutter_assessment/imports.dart';

List<ContactData> ContactFromJson(String str) => List<ContactData>.from(
    json.decode(str).map((x) => ContactData.fromJson(x)));

String ContactToJson(List<ContactData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

reformatDateToSave(data){
  var inputFormat = DateFormat('d MMM y hh:mm a');
  var inputDate = inputFormat.parse(data.toString());

  var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var outputDate = outputFormat.format(inputDate);

  return outputDate;
}

getNewDateFormat(data) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var inputDate = inputFormat.parse(data.toString()); // <-- dd/MM 24H format

  var outputFormat = DateFormat('d MMM y hh:mm a');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

class ContactData {
  ContactData({
    required this.userName,
    required this.phoneNumber,
    required this.checkInTime,
  });

  String userName;
  String phoneNumber;
  String checkInTime;

  factory ContactData.fromJson(Map<dynamic, dynamic> json) => ContactData(
        userName: json["user"],
        phoneNumber: json["phone"],
        checkInTime: getNewDateFormat(json["check-in"]),
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "phoneNumber": phoneNumber,
        "CheckInTime": checkInTime,
      };
}
