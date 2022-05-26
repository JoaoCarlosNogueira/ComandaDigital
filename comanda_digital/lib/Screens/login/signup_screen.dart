import 'package:comanda_digital/Model/units/User/employee.dart';
import 'package:comanda_digital/Model/units/User/employee_service.dart';
import 'package:comanda_digital/Screens/helpers/validators.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Employee userLocal = Employee();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta de Usúario'),
        centerTitle: true,
      ),
      body: Center(
          child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nome completo'),
                validator: (name) {
                  if (name!.isEmpty) {
                    return 'Campo obrigatorio';
                  } else if (name.trim().split('').length < 10) {
                    return 'Preencha seu nome Completo';
                  }

                  return null;
                },
                onSaved: (name) => userLocal.name = name,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (!emailValidator(email)) {
                    return 'E-mail invalido!!!';
                  }
                  return null;
                },
                onSaved: (email) => userLocal.email = email,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Telefone'),
                validator: (telefone) {
                  if (telefone!.isEmpty) {
                    return 'Campo obrigatório!!!';
                  } else if (telefone.length < 9 && telefone.length > 11) {
                    return 'Telefone invalido';
                  }
                  return null;
                },
                onSaved: (password) => userLocal.password = password,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Senha'),
                obscureText: true,
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Campo obrigatório!!!';
                  } else if (password.length < 6) {
                    return ' Senha deve ter ao menos 6 caracteres!!!';
                  }
                  return null;
                },
                onSaved: (password) => userLocal.password = password,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Repita a senha'),
                obscureText: true,
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Campo obrigatorio!!!';
                  } else if (password.length < 6) {
                    return ' Senha deve ter ao menos 6 caracteres!!!';
                  }
                  return null;
                },
                onSaved: (password) => userLocal.confirmPassword = password,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tipo de Funcionario'),
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Campo obrigatório!!!';
                  } else if (password.length > 30) {
                    return ' Numero de caracteres excedido';
                  }
                  return null;
                },
                onSaved: (password) => userLocal.password = password,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (userLocal.password != userLocal.confirmPassword) {
                      const ScaffoldMessenger(
                        child: SnackBar(
                          content: Text(
                            'Senhas não coincidem!!!',
                            style: TextStyle(fontSize: 11),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    UserService userService = UserService();
                    userService.signUp(
                      userLocal,
                      onSucess: () {
                        Navigator.of(context).pop();
                      },
                      onFail: (e) {
                        ScaffoldMessenger(
                          child: SnackBar(
                            content: Text(
                              'Falha ao registrar usuário: $e',
                              style: const TextStyle(fontSize: 11),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
