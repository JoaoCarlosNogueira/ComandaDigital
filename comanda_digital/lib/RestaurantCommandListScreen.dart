import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:comanda_digital/Screens/adicionarPedido.dart';

import 'package:flutter/material.dart';

class CommandListScreen extends StatefulWidget {
  const CommandListScreen({Key? key}) : super(key: key);

  @override
  State<CommandListScreen> createState() => _CommandListScreenState();
}

class _CommandListScreenState extends State<CommandListScreen> {
  @override
  Widget build(BuildContext context) {
    RestaurantCommandService commandService = RestaurantCommandService();
    RequestService requestService = RequestService();
    ItemService itemService = ItemService();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: commandService.getRestaurantCommand(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                var command = RestaurantCommand(
                    clientName: (docSnap[index].get('clientName')),
                    condition: (docSnap[index].get('condition')),
                    date: (docSnap[index].get('date')),
                    employee: [],
                    requests: [],
                    table: (docSnap[index].get('table')),
                    total: (docSnap[index].get('total')),
                    id: (docSnap[index].id));
                return GestureDetector(
                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(command.table),
                          Text(command.date),
                          Text(command.total),
                          Text(command.condition),
                          Text(command.clientName),
                          SizedBox(
                            height: 300,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: requestService.getRequest(command),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<DocumentSnapshot> docSnap =
                                        snapshot.data!.docs;
                                    return ListView.separated(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FutureBuilder<DocumentSnapshot>(
                                          future: (itemService
                                              .getItem((docSnap[index].id))),
                                          builder:
                                              (BuildContext context, snapshot) {
                                            var item = Item(
                                                id: snapshot.data!.get('id'),
                                                name:
                                                    snapshot.data!.get('name'),
                                                category: snapshot.data!
                                                    .get('category'),
                                                description: snapshot.data!
                                                    .get('description'),
                                                value:
                                                    snapshot.data!.get('value'),
                                                disponibility: snapshot.data!
                                                    .get('disponibility'));
                                            var request = Request(
                                                quantity: (docSnap[index]
                                                    .get('quantity')),
                                                subtotal: (docSnap[index]
                                                    .get('subtotal')),
                                                item: item);

                                            return Card(
                                                child: Column(
                                              children: [
                                                Text('Código do Produto' +
                                                    item.id),
                                                Text('Produto' + item.name),
                                                Text('Categoria' +
                                                    item.category),
                                                Text('Valor' + item.value),
                                                Text('Disponibilidade' +
                                                    item.disponibility),
                                                Text('Quantity' +
                                                    request.quantity),
                                                Text('Subtotal' +
                                                    request.subtotal)
                                              ],
                                            ));
                                          },
                                        );
                                      },
                                      itemCount: docSnap.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return ListView(
                                      children: const [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child:
                                              Text("Não há dados disponíveis"),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AdicionarPedido(command: command),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: docSnap.length,
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
