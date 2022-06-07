import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:comanda_digital/Screens/closecCommandScreen.dart';
import 'package:flutter/material.dart';

import 'closecCommandScreen.dart';

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = widget.command.id!;
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
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
                        RestaurantCommandService service =
                            RestaurantCommandService();

                        service.deleteRestaurantCommand(widget.command.id!);
                      }
                    },
                    child: const Text(
                      'Remover Item',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
