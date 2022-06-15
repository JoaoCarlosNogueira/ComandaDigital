import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';

import 'package:comanda_digital/Screens/closeCommandScreen.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClosedCommandListScreen extends StatefulWidget {
  const ClosedCommandListScreen({Key? key}) : super(key: key);

  @override
  State<ClosedCommandListScreen> createState() =>
      _ClosedCommandListScreenState();
}

class _ClosedCommandListScreenState extends State<ClosedCommandListScreen> {
  @override
  Widget build(BuildContext context) {
    RestaurantCommandService commandService = RestaurantCommandService();
    RequestService requestService = RequestService();
    ItemService itemService = ItemService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comandas Fechadas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: commandService.getRestaurantCommandsClosed(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            var result = commandService.getRestaurantCommand();

            return Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var command = RestaurantCommand(
                      clientName: (docSnap[index].get('clientName')),
                      condition: (docSnap[index].get('condition')),
                      date: (docSnap[index].get('date')),
                      paymentForm: (docSnap[index].get('paymentform')),
                      employee: [],
                      requests: [],
                      table: (docSnap[index].get('table')),
                      total: (docSnap[index].get('total')),
                      id: (docSnap[index].id));

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          color: Colors.orange[200],
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, right: 120, left: 120, bottom: 30),
                            child: Column(
                              children: [
                                Text('Mesa: ' + command.table.toString()),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Data: ' + command.date),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Total:" + command.total.toString()),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Condição: ' + command.condition),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Cliente: ' + command.clientName),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 60),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CloseCommandScreen(
                                            command: command,
                                          )));
                                },
                                child: const Text(
                                  'Fechar Comanda',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                alignment: Alignment.centerRight,
                                // ignore: avoid_returning_null_for_void
                                onPressed: () {
                                  if (command.requests!.isEmpty) {
                                    commandService.deleteRestaurantCommand(
                                        (docSnap[index].id));
                                    Fluttertoast.showToast(
                                      msg: "Comanda cancelada com Sucesso!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: const Color(0x55000000),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Falha ao cancelar a comanda!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: const Color(0x55000000),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        */
                        StreamBuilder<QuerySnapshot>(
                          stream: requestService.getRequest(command),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot> docSnap =
                                  snapshot.data!.docs;
                              return SizedBox(
                                height: 300,
                                child: ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FutureBuilder<DocumentSnapshot>(
                                      future: itemService.getItem(
                                          docSnap[index].get('itemid')),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.hasData) {
                                          var item = Item(
                                            id: snapshot.data!.id,
                                            name: snapshot.data!.get('name'),
                                            category:
                                                snapshot.data!.get('category'),
                                            description: snapshot.data!
                                                .get('description'),
                                            value: snapshot.data!.get('value'),
                                            disponibility: snapshot.data!
                                                .get('disponibility'),
                                          );

                                          var request = Request(
                                            quantity:
                                                docSnap[index].get('quantity'),
                                            subtotal:
                                                docSnap[index].get('subtotal'),
                                            item: item,
                                          );

                                          return Card(
                                            color: Colors.orange[300],
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 15.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Código do Pedido: ' +
                                                      item.id.toString()),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Pedido: ' + item.name),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Categoria: ' +
                                                      item.category),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Disponibilidade: ' +
                                                      item.disponibility),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Valor Unitário: ' +
                                                      item.value.toString()),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Quantity: ' +
                                                      request.quantity
                                                          .toString()),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Subtotal: ' +
                                                      request.subtotal
                                                          .toString()),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Text('k');
                                        }
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
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
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
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: docSnap.length,
              ),
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
