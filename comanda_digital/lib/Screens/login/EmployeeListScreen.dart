import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/User/employee_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserService ownerServices = UserService();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: ownerServices.getEmployees(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(children: [
                    Text(docSnap[index].get('id')),
                    Text(docSnap[index].get('name')),
                    Text(docSnap[index].get('email')),
                    Text(docSnap[index].get('phone')),
                    Text(docSnap[index].get('passworsd')),
                    Text(docSnap[index].get('confirmpassworsd')),
                    Text(docSnap[index].get('type')),
                    Text(docSnap[index].get('cpf')),
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
