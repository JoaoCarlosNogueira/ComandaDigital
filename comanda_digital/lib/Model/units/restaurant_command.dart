import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:comanda_digital/Model/units/request.dart';

class RestaurantCommand {
  String? id;
  late String table;
  late List<Request>? requests;
  late String date;
  late String total;
  List<Employee>? employee;
  late String condition;
  late String clientName;

  RestaurantCommand(
      {required this.id,
      required this.table,
      required this.requests,
      required this.date,
      required this.total,
      this.employee,
      required this.condition,
      required this.clientName});

  RestaurantCommand.fromMap(Map<String, dynamic> map)
      : table = map['table'],
        date = map['date'],
        total = map['total'],
        condition = map['condition'],
        clientName = map['clientName'];
  Map<String, dynamic> toMap() {
    return {
      'table': table,
      'date': date,
      'total': total,
      'condition': condition,
      'clientName': clientName
    };
  }
}
