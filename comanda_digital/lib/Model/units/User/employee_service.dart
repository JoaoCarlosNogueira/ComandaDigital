import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserService {
  Employee? employee;
  Future<void> signIn(Employee employee,
      {Function? onSucess, Function? onFail}) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: employee.email!, password: employee.password!))
          .user;
      this.employee = employee;
      this.employee!.id = user!.uid;
      onSucess!();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      onFail!(debugPrint(e.toString()));
    }
  }

  Future signUp(Employee employee,
      {Function? onSucess, Function? onFail}) async {
    {
      try {
        User? user = (await _auth.createUserWithEmailAndPassword(
                email: employee.email!, password: employee.password!))
            .user;
        this.employee = employee;
        this.employee!.id = user!.uid;
        var employeeMap = employee.toMap();
        _firestore.collection("funcionarios").doc(user.uid).set(employeeMap);
        onSucess!();
      } catch (e) {
        debugPrint(e.toString());
        onFail!(e);
      }
    }
  }

  getEmployees() {
    var employeeCollection = _firestore.collection("funcionario");
    return employeeCollection.snapshots();
  }

  deleteEmployee(String id) {
    DocumentReference docRef = _firestore.collection('funcionario').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  updateOwner(Employee employee) {
    DocumentReference docRef =
        _firestore.collection('funcionario').doc(employee.id!);
    docRef
        .update(employee.toMap())
        .whenComplete(
            () => debugPrint("Dados do ${employee.id} deletado com sucesso!!"))
        .catchError((erro) =>
            debugPrint("Erro ao deletar o ${employee.id} -> $erro!!"));
  }
}
