import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:comanda_digital/Screens/RequestAddScreen.dart';
import 'package:flutter/material.dart';

class CommandListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RestaurantCommandService commandService = RestaurantCommandService();
    RequestService requestService = RequestService();
    var item = Item(
        id: '',
        name: '',
        category: '',
        description: '',
        value: '',
        disponibility: '');
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: commandService.getRestaurantCommand(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                var command = RestaurantCommand(
                    id: (docSnap[index].id),
                    clientName: (docSnap[index].get('clientName')),
                    condition: (docSnap[index].get('condition')),
                    date: (docSnap[index].get('date')),
                    employee: [],
                    requests: [],
                    table: (docSnap[index].get('table')),
                    total: (docSnap[index].get('total')));
                return GestureDetector(
                  child: Card(
                    child: Column(
                      children: [
                        Text(command.id),
                        Text(command.table),
                        Text(command.date),
                        Text(command.total),
                        Text(command.condition),
                        Text(command.clientName),
                        StreamBuilder<QuerySnapshot>(
                            stream: requestService.getRequest(command),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DocumentSnapshot> docSnapp =
                                    snapshot.data!.docs;
                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    var request = Request(
                                      quantity:
                                          (docSnapp[index].get('quantity')),
                                      subtotal:
                                          (docSnapp[index].get('subtotal')),
                                      item: item,
                                    );

                                    return Card(
                                      child: Column(
                                        children: [
                                          Text(item.id),
                                          Text(request.quantity),
                                          Text(request.subtotal),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: docSnapp.length,
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
                            }),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            RequestAddScreen(command: command),
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
