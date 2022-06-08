import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CancelCommandScreen extends StatefulWidget {
  final RestaurantCommand command;
  @override
  const CancelCommandScreen({Key? key, required this.command})
      : super(key: key);

  @override
  State<CancelCommandScreen> createState() => _CancelCommandScreenState();
}

class _CancelCommandScreenState extends State<CancelCommandScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var requestidController = TextEditingController();
  var tableController = TextEditingController();
  var dateController = TextEditingController();
  var totalController = TextEditingController();
  var conditionController = TextEditingController();
  var clientNameController = TextEditingController();
  var paymentFormController = TextEditingController();
  var employeeController = TextEditingController();
  var requestsController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    /*
    idController.text = widget.command.id!;

    idController.text = widget.command.id!;
    tableController.text = widget.command.table.toString();
    dateController.text = widget.command.date;
    totalController.text = widget.command.total.toString();
    conditionController.text = widget.command.condition;
    clientNameController.text = widget.command.clientName;
    employeeController.text = widget.command.employee.toString();
    requestsController.text = widget.command.requests.toString();
    paymentFormController.text = widget.command.paymentForm!;
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Cancelar Comanda'),
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
                  TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Código do Produto'),
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor insira a senha valida';
                      } else if (value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // formKey.currentState!.save();
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
                      RequestService requestService = RequestService();

                      var getrequest =
                          await requestService.getRequests(command);
                      RestaurantCommandService commandService =
                          RestaurantCommandService();

                      if (getrequest.docs.isEmpty == true) {
                        commandService
                            .deleteRestaurantCommand(widget.command.id!);
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: "Comanda fechada com sucesso!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: const Color(0x55111100),
                        );
                      }

                      Fluttertoast.showToast(
                        msg: "Falha ao fechar a comanda!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0x55000000),
                      );
                    },
                    child: const Text("Fechar Comanda"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
