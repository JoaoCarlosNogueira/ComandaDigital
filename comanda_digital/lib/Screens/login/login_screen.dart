import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:comanda_digital/Model/units/User/employee_service.dart';
import 'package:comanda_digital/Screens/login/signup_screen.dart';
import 'package:comanda_digital/home/home_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Employee userLocal = Employee();
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(80.0),
          child: Image(
              width: 980,
              height: 215,
              image: AssetImage('assets/images/test.jpg')),
        ),
        /*const Text(
          "Comanda Digital",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        */
        Card(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) => userLocal.email = value,
                        initialValue: userLocal.email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor insira um email valido';
                          } else if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        initialValue: userLocal.password,
                        onSaved: (value) => userLocal.password = value,
                        obscureText: false,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Senha'),
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor insira a senha valida';
                          } else if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        UserService _userServices = UserService();
                        _userServices.signIn(userLocal, onSucess: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }, onFail: (e) {
                          Text('$e');
                        });
                      }
                    },
                    child: const Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text('Registrar-se'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
