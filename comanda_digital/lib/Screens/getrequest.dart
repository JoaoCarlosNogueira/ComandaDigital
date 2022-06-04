import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:flutter/material.dart';

import '../Model/units/item.dart';

class GetRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RequestService requestService = RequestService();
    RestaurantCommand command = RestaurantCommand(
      clientName: '',
      condition: '',
      date: '',
      employee: [],
      requests: [],
      table: '',
      total: 0,
      id: '',
    );
    var item = Item(
        id: '',
        name: '',
        category: '',
        description: '',
        disponibility: '',
        value: 0);
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: requestService.getRequest(command),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                var request = Request(
                  item: item,
                  quantity: (docSnap[index].get(0)),
                  subtotal: (docSnap[index].get('subtotal')),
                );
                return Card(
                  child: Column(children: [
                    Text(request.quantity.toString()),
                    Text(request.subtotal.toString()),
                  ]),
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
