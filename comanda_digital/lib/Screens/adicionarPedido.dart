import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:flutter/material.dart';
import '../Model/units/item.dart';

class AdicionarPedido extends StatefulWidget {
  final RestaurantCommand command;
  const AdicionarPedido({Key? key, required this.command}) : super(key: key);
  @override
  State<AdicionarPedido> createState() => AdicionarPedidoState(command);
}

class AdicionarPedidoState extends State<AdicionarPedido> {
  final GlobalKey<ScaffoldState> Keyzinho = GlobalKey<ScaffoldState>();
  ItemService itemService = ItemService();
  RequestService requestService = RequestService();

  AdicionarPedidoState(RestaurantCommand command);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keyzinho,
      appBar: AppBar(
        title: const Text('Tela de pedidos'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemService.getItems(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                var item = Item(
                    id: (docSnap[index].id),
                    name: (docSnap[index].get('name')),
                    category: (docSnap[index].get('category')),
                    value: (docSnap[index].get('value')),
                    description: (docSnap[index].get('description')),
                    disponibility: '');

                final GlobalKey<FormState> formKey = GlobalKey<FormState>();
                Request request =
                    Request(quantity: '', subtotal: '', item: item);
                return Card(
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      Text(
                        item.id,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.start),
                      Text(item.name),
                      Text(item.category),
                      Text(item.description),
                      Text(item.value),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        onSaved: (quantity) => request.quantity = quantity!,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Quantidade de Pedido'),
                        validator: (value) {
                          if (value == null) {
                            return 'Digite um valor valor válido';
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
                        onSaved: (subtotal) => request.subtotal = subtotal!,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Quantidade de Pedido'),
                        validator: (value) {
                          if (value == null) {
                            return 'Digite um valor valor válido';
                          } else if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          formKey.currentState!.save();
                          requestService.addpedido(request, widget.command);
                        },
                        child: const Text(
                          'Adicionar Pedido',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: docSnap.length,
              shrinkWrap: true,
              reverse: true,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: const [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text("Não há dados disponíveis"),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
