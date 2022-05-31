import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:comanda_digital/RestaurantCommandListScreen.dart';
import 'package:comanda_digital/Screens/adicionarPedido.dart';
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
    table: '',
    date: '',
    total: '',
    condition: '',
    clientName: '',
    employee: [],
    requests: [],
  );
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
                onSaved: (value) => command.table = value!,
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
                onSaved: (value) => command.total = value!,
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
                      await restaurantService.add(
                        command,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AdicionarPedido(command: command),
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
                      builder: (context) => CommandListScreen()));
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
            ],
          ),
        ),
      )),
    );
  }
}
