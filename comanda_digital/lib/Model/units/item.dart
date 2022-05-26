class Item {
  late String id;
  late String name;
  late String description;
  late String disponibility;
  late String category;
  late String value;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.disponibility,
    required this.value,
  });

  Item.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        disponibility = map['disponibility'],
        category = map['category'],
        value = map['value'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'disponibility': disponibility,
      'category': category,
      'value': value,
    };
  }
}
