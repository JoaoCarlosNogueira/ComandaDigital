import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Screens/helpers/numberItemMask.dart';
import 'package:comanda_digital/Screens/items_list_screen.dart';
import 'package:comanda_digital/item_delete_screen.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

class ItemAddScreen extends StatefulWidget {
  const ItemAddScreen({Key? key}) : super(key: key);

  @override
  State<ItemAddScreen> createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextInputMask _numberItemMask;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Item item = Item(
    id: '',
    name: '',
    category: '',
    description: '',
    value: 0,
    disponibility: 'Disponível',
  );

  @override
  void initState() {
    super.initState();
    _numberItemMask = NumberItemMask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Adicionar Item'),
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
                    border: OutlineInputBorder(), labelText: 'Código'),
                validator: (id) {
                  if (id!.isEmpty) {
                    return 'Campo obrigatorio!!!';
                  }
                  return null;
                },
                onSaved: (id) => item.id = id!,
                inputFormatters: [_numberItemMask],
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
                    return 'Preencha o nome do produto';
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
                    border: OutlineInputBorder(), labelText: 'Categoria'),
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
                    border: OutlineInputBorder(), labelText: 'Descrição'),
                keyboardType: TextInputType.text,
                validator: (description) {
                  if (description!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (description.length > 55) {
                    return ' O limite de caracteres foi excedido';
                  }
                  return null;
                },
                onSaved: (description) => item.description = description!,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Valor'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatorio!!!';
                  }
                  return null;
                },
                onSaved: (value) => item.value = double.parse(value!),
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
                    itemService.add(
                      item,
                    );
                  }
                },
                child: const Text(
                  'Adicionar Item',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemDeleteScreen()));
                },
                child: const Text(
                  'Deleção de Item',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ItemslistScreen()));
                },
                child: const Text(
                  'Ver Itens',
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
