import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:comanda_digital/Model/units/request.dart';

class RestaurantCommand {
  String? id;
  int table;
  List<Request>? requests;
  String date;
  double total;
  List<Employee>? employee;
  String condition;
  String? paymentForm;
  String clientName;

  RestaurantCommand(
      {this.paymentForm,
      required this.id,
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
        paymentForm = map['paymentform'],
        clientName = map['clientName'];
  Map<String, dynamic> toMap() {
    return {
      'table': table,
      'date': date,
      'total': total,
      'condition': condition,
      'paymentform': paymentForm,
      'clientName': clientName
    };
  }
}
