class Employee {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  String? type;
  int? cpf;

  Employee({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.confirmPassword,
    this.type,
    this.cpf,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'confirmPassword': confirmPassword,
      'type': type,
      'cpf': cpf
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        password: map['password'],
        confirmPassword: map['confirmPassword'],
        type: map['type'],
        cpf: map['cpf']);
  }
}
