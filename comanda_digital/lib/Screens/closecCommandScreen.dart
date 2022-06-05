import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CloseCommandScreen extends StatefulWidget {
  final RestaurantCommand command;
  const CloseCommandScreen({
    required this.command,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CloseCommandScreen();
}

RestaurantCommand command = RestaurantCommand(
  id: '',
  table: '',
  date: '',
  total: 0,
  condition: 'Paga',
  clientName: '',
  paymentForm: '',
  employee: [],
  requests: [],
);

class _CloseCommandScreen extends State<CloseCommandScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  var tableController = TextEditingController();
  var dateController = TextEditingController();
  var totalController = TextEditingController();
  var conditionController = TextEditingController();
  var clientNameController = TextEditingController();
  var paymentFormController = TextEditingController();
  var employeeController = TextEditingController();
  var requestsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    idController.text = widget.command.id!;
    tableController.text = widget.command.table;
    dateController.text = widget.command.date;
    totalController.text = widget.command.total.toString();
    conditionController.text = widget.command.condition;
    clientNameController.text = widget.command.clientName;
    employeeController.text = widget.command.employee.toString();
    requestsController.text = widget.command.requests.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fechamento de Comandas"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "ID: ${widget.command.id}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Table: ${widget.command.table}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Data: ${widget.command.date}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Cliente: ${widget.command.clientName}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Garçom: ${widget.command.employee}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Pedidos: ${widget.command.requests}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Total: ${widget.command.total}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Forma de Pagamento',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: paymentFormController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Insira a Forma de Pagamento';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onSaved: (value) => widget.command.paymentForm = value!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      RestaurantCommandService commandService =
                          RestaurantCommandService();
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

                      commandService.updateRestaurantCommand(command);

                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Comanda fechada com sucesso!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0x55111100),
                      );
                    }
                  },
                  child: const Text("Fechar Comanda"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
