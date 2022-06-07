import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Screens/helpers/numberItemMask.dart';
import 'package:easy_mask/easy_mask.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemEditScreen extends StatefulWidget {
  final Item item;

  const ItemEditScreen({required this.item, Key? key}) : super(key: key);
  //@override
  @override
  State<ItemEditScreen> createState() => _itemEditScreen();
}

bool isChecked = false;
bool noChecked = true;

class _itemEditScreen extends State<ItemEditScreen> {
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var descriptionController = TextEditingController();
  var valueController = TextEditingController();
  var disponibilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = widget.item.id;

    nameController.text = widget.item.name;
    categoryController.text = widget.item.category;
    descriptionController.text = widget.item.description;
    valueController.text = widget.item.value.toString();
    disponibilityController.text = widget.item.disponibility;
  }

  final _formKey = GlobalKey<FormState>();

  Item item = Item(
    id: '',
    name: '',
    category: '',
    description: '',
    value: 0,
    disponibility: 'oi00000',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar itens"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "ID:",
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
                        controller: idController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o nome';
                          }
                          return null;
                        },
                        onSaved: (value) => item.id = (value!),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Nome',
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
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o nome';
                          }
                          return null;
                        },
                        onSaved: (value) => item.name = (value!),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Categoria',
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
                        controller: categoryController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, entre com a categoria';
                          }
                          return null;
                        },
                        onSaved: (value) => item.category = (value!),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Descricao',
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
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com a descrição';
                          }
                          return null;
                        },
                        onSaved: (value) => item.description = (value!),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Valor',
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
                        controller: valueController,
                        validator: (value) {
                          double.parse(value!);
                          if (value.isEmpty) {
                            return 'Por favor, entre com o valor';
                          }
                          return null;
                        },
                        onSaved: (value) => item.value = double.parse(value!),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ItemService service = ItemService();

                      service.updateItem(item);
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Dados alterados com sucesso!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0x55111100),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Verifique os dados e tente novamente",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0x55111100),
                      );
                    }
                  },
                  child: const Text("Editar Dados"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
