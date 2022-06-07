import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:flutter/material.dart';

class RequestEditScreen extends StatefulWidget {
  const RequestEditScreen({
    Key? key,
    required this.request,
    required this.command,
    required this.item,
  }) : super(key: key);
  final Request request;
  final RestaurantCommand command;
  final Item item;

  @override
  State<RequestEditScreen> createState() => _RequestEditScreenState();
}

class _RequestEditScreenState extends State<RequestEditScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    /*
    widget.request.subtotal.toString();
    widget.request.quantity.toString();

    widget.item.id;
    widget.item.name;
    widget.item.category;
    widget.item.description;
    widget.item.disponibility;
    widget.item.value;

    widget.command.id!;
    widget.command.table.toString();
    widget.command.date;
    widget.command.total.toString();
    widget.command.condition;
    widget.command.clientName;
    widget.command.employee.toString();
    widget.command.requests.toString();
    */
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _formKey,
        appBar: AppBar(
          title: const Text('Edição de pedidos'),
          centerTitle: true,
        ),
        body: Center(
            child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                    key: formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      children: <Widget>[
                        const Text(
                          'Quantidade',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, entre com o nome';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onSaved: (value) =>
                              widget.request.quantity = int.parse(value!),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              RestaurantCommand command = RestaurantCommand(
                                id: widget.command.id,
                                table: widget.command.table,
                                date: widget.command.date,
                                total: widget.command.total,
                                condition: widget.command.condition,
                                clientName: widget.command.clientName,
                                paymentForm: widget.command.paymentForm,
                                employee: widget.command.employee,
                                requests: widget.command.requests,
                              );
                              Request request = Request(
                                  item: Item(
                                      id: widget.item.id,
                                      name: widget.item.name,
                                      category: widget.item.category,
                                      description: widget.item.description,
                                      disponibility: widget.item.disponibility,
                                      value: widget.item.value),
                                  quantity: widget.request.quantity,
                                  subtotal: widget.request.subtotal);

                              if (formKey.currentState!.validate() == false) {
                                const ScaffoldMessenger(
                                  child: SnackBar(
                                    content: Text(
                                      'Verifique os dados e tende novamente!!!',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              RequestService service = RequestService();
                              service.updateRequest(request, command);
                            }
                          },
                          child: const Text(
                            'Atualizar  Quantidade',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )))));
  }
}
