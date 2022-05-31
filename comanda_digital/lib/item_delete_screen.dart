import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDeleteScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Item item = Item(
      id: '',
      name: '',
      category: '',
      description: '',
      disponibility: '',
      value: '');
  ItemDeleteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Remover Item'),
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
                    obscureText: false,
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
                        ItemService itemService = ItemService();
                        itemService.deleteItem(item.id);
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
