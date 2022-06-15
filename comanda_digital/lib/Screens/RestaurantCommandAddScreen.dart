import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:comanda_digital/Screens/RestaurantCommandOpenedListScreen.dart';
import 'package:comanda_digital/Screens/closedCommandListScreen.dart';
import 'package:comanda_digital/Screens/requestAddScreen.dart';
import 'package:comanda_digital/Screens/helpers/dateInputMask.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

class RestaurantCommandAddScreen extends StatefulWidget {
  RestaurantCommandAddScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantCommandAddScreen> createState() =>
      _RestaurantCommandAddScreenState();
}

class _RestaurantCommandAddScreenState
    extends State<RestaurantCommandAddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RestaurantCommand command = RestaurantCommand(
      id: '',
      table: 0,
      date: '',
      total: 0,
      condition: 'Aberta',
      clientName: '',
      employee: [],
      requests: [],
      paymentForm: 'valores');
  Item item = Item(
      id: '',
      name: '',
      category: '',
      description: '',
      value: 0,
      disponibility: '');

  Request request = Request(
      item: Item(
          id: '',
          name: '',
          category: '',
          description: '',
          disponibility: '',
          value: 0),
      quantity: 0,
      subtotal: 0);

  late final TextInputMask _dateMask;

  @override
  void initState() {
    super.initState();
    _dateMask = DateInputMask();
  }

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
                onSaved: (value) => command.table = int.parse(value!),
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
                onSaved: (value) => command.clientName = value!,
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
                onSaved: (value) => command.date = value!,
                inputFormatters: [_dateMask],
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
                onSaved: (value) => command.condition = value!,
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
                height: 6,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final restaurantService = RestaurantCommandService();
                      command.total = 0;
                      await restaurantService.add(
                        command,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RequestAddScreen(command: command),
                        ),
                      );
                    } else {
                      const ScaffoldMessenger(
                        child: SnackBar(
                          content: Text(
                            'Verifique os dados e tende novamente!!!',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      );
                      return;
                    }
                  },
                  child: const Text(
                    'Adicionar Comanda',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 6,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CommandOpenedListScreen()));
                },
                child: const Text(
                  'Comandas Abertas',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ClosedCommandListScreen()));
                },
                child: const Text(
                  'Comandas Fechadas',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
