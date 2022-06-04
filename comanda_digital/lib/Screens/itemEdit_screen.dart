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
  late final TextInputMask _numberItemMask;
  @override
  void initState() {
    super.initState();
    idController.text = widget.item.id;

    nameController.text = widget.item.name;
    categoryController.text = widget.item.category;
    descriptionController.text = widget.item.description;
    valueController.text = widget.item.value.toString();
    disponibilityController.text = widget.item.disponibility;
    _numberItemMask = NumberItemMask();
  }

  final _formKey = GlobalKey<FormState>();

  Item item = Item(
    id: '',
    name: '',
    category: '',
    description: '',
    value: 0,
    disponibility: '',
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
                      Text(
                        "ID: ${widget.item.id}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
                            return 'Por favor, entre com a descrição';
                          }
                          return null;
                        },
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
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o valor';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text("Disponível"),
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            item.disponibility = 'Indisponível';
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Indísponível"),
                        checkColor: Colors.white,
                        value: noChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            noChecked = value!;
                            item.disponibility = 'Indisponível';
                          });
                        },
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
                    if (_formKey.currentState!.validate()) {
                      ItemService service = ItemService();
                      Item item = Item(
                        id: widget.item.id,
                        name: widget.item.name,
                        category: widget.item.category,
                        description: widget.item.description,
                        disponibility: widget.item.disponibility,
                        value: widget.item.value,
                      );

                      service.updateItem(item);
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Dados alterados com sucesso!",
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
