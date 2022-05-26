import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:comanda_digital/Model/units/request.dart';

class RestaurantCommand {
  late String id;
  late String table;
  late List<Request> requests;
  late String date;
  late String total;
  late List<Employee> employee;
  late String condition;
  late String clientName;

  RestaurantCommand(
      {required this.id,
      required this.table,
      required this.requests,
      required this.date,
      required this.total,
      required this.employee,
      required this.condition,
      required this.clientName});

  RestaurantCommand.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        table = map['table'],
        requests = map['requestid'],
        date = map['date'],
        total = map['total'],
        employee = map['employeeid'],
        condition = map['condition'],
        clientName = map['clientName'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table': table,
      'request': requests,
      'date': date,
      'total': total,
      'employeid': employee,
      'condition': condition,
      'clientName': clientName
    };
  }
}
