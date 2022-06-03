import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:flutter/material.dart';

class ItemEditScreens extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Item item = Item(
    id: 'id',
    name: 'name',
    category: 'category',
    description: 'desciption',
    value: 0,
    disponibility: '',
  );

  ItemEditScreens({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Edição de Itens'),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Código'),
                          validator: (id) {
                            if (id!.isEmpty) {
                              return 'Campo obrigatorio!!!';
                            }
                            return null;
                          },
                          onSaved: (id) => item.id = id!,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Nome'),
                          validator: (name) {
                            if (name!.isEmpty) {
                              return 'Campo obrigatorio';
                            } else if (name.trim().split('').length <= 1) {
                              return 'Preencha seu nome Completo';
                            }

                            return null;
                          },
                          onSaved: (name) => item.name = name!,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Categoria'),
                          obscureText: false,
                          validator: (category) {
                            if (category!.isEmpty) {
                              return 'Campo obrigatório!!!';
                            } else if (category.length > 10) {
                              return 'Limite de caracteres excedido';
                            }
                            return null;
                          },
                          onSaved: (category) => item.category = category!,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descricão'),
                          keyboardType: TextInputType.text,
                          validator: (description) {
                            if (description!.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (description.length > 55) {
                              return ' O limite de caracteres foi excedido';
                            }
                            return null;
                          },
                          onSaved: (description) =>
                              item.description = description!,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Valor'),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatorio!!!';
                            }
                            return null;
                          },
                          onSaved: (value) => item.value = value! as double,
                        ),
                        const SizedBox(
                          height: 16,
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
                              ItemService itemService = ItemService();
                              itemService.updateItem(
                                item,
                              );
                            }
                          },
                          child: const Text(
                            'Atualizar Item',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )))));
  }
}
