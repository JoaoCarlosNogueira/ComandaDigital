import 'package:comanda_digital/Model/units/item.dart';

class Request {
  String? id;
  late Item item;
  late int quantity;
  double subtotal;

  Request(
      {this.id,
      required this.item,
      required this.quantity,
      required this.subtotal});

  Request.fromMap(Map<String, dynamic> map)
      : item = map['itemid'],
        quantity = map['quantity'],
        subtotal = map['subtotal'];

  Map<String, dynamic> toMap() {
    return {'itemid': item.id, 'quantity': quantity, 'subtotal': subtotal};
  }
}
