class MyModel {
  final String name;
  final int age;

  MyModel({
    required this.name,
    required this.age,
  });

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}