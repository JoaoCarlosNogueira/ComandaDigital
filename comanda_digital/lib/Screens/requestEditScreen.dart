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
  }) : super(key: key);
  final Request request;

  @override
  State<RequestEditScreen> createState() => _RequestEditScreenState();
}

class _RequestEditScreenState extends State<RequestEditScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var quantityController = TextEditingController();
  var subtotalController = TextEditingController();
  var itemController = TextEditingController();

  @override
  void initState() {
    subtotalController.text = widget.request.subtotal.toString();
    quantityController.text = widget.request.quantity.toString();
    itemController.text = widget.request.item.toString();
  }

  final _formKey = GlobalKey<FormState>();
  RestaurantCommand command = RestaurantCommand(
    id: '',
    table: 1,
    date: '',
    total: 0,
    condition: '',
    clientName: '',
    employee: [],
    requests: [],
  );
  Request request = Request(
      item: Item(
          id: '',
          name: '',
          value: 0,
          category: '',
          description: '',
          disponibility: ''),
      quantity: 0,
      subtotal: 0);

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
                          controller: quantityController,
                          onSaved: (value) =>
                              request.quantity = int.parse(value!),
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
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print(request.id);
                              print(command.id);
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
                              print(request.id);
                              print(command.id);
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
