import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Screens/adicionarPedido.dart';

import 'package:flutter/material.dart';

import '../Model/units/restaurante_command_service.dart';

class RequestAddScreen extends StatefulWidget {
  final RestaurantCommand command;

  const RequestAddScreen({Key? key, required RestaurantCommand this.command})
      : super(key: key);

  @override
  State<RequestAddScreen> createState() => _RequestAddScreenState();
}

class _RequestAddScreenState extends State<RequestAddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RestaurantCommand command = RestaurantCommand(
    id: '',
    table: '',
    date: '',
    total: '',
    condition: '',
    clientName: '',
    employee: [],
    requests: [],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Comanda'),
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
                onSaved: (value) => widget.command.table = value!,
                obscureText: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Numero da mesa '),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onSaved: (value) => widget.command.clientName = value!,
                obscureText: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nome do Cliente'),
                validator: (value) {
                  if (value!.length > 30) {
                    return 'Limete de caracteres excedido';
                  } else if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onSaved: (value) => widget.command.date = value!,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Data'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onSaved: (value) => widget.command.total = value!,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Total'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onSaved: (value) => widget.command.condition = value!,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Condicao'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdicionarPedido(
                        command: widget.command,
                      ),
                    ),
                  );
                },
                child: const Text('Realizar pedido'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
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
                    RestaurantCommandService restaurantService =
                        RestaurantCommandService();
                    restaurantService.add(
                      widget.command,
                    );
                  }
                },
                child: const Text(
                  'Adicionar Comanda',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
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
                  }
                },
                child: const Text(
                  'Remover Comanda',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
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
                    RestaurantCommandService restaurantService =
                        RestaurantCommandService();
                    restaurantService.updateRestaurantCommand(command);
                  }
                },
                child: const Text(
                  'Atualizar comanda',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
