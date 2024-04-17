class Expense {
  Expense(
      {this.id,
      required this.amount,
      required this.isIncome,
      required this.description,
      required this.createdAt,
      required this.updatedAt});

  final int? id;
  final int amount;
  final int isIncome;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
        id: map["id"],
        amount: map["amount"],
        isIncome: map["is_income"],
        description: map["description"],
        createdAt: DateTime.parse(map["created_at"]),
        updatedAt: DateTime.parse(map["updated_at"]),
      );

  Map<String, dynamic> toMapDB() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["amount"] = amount;
    map["is_income"] = isIncome;
    map["description"] = description;
    map["created_at"] = createdAt.toIso8601String();
    map["updated_at"] = updatedAt.toIso8601String();
    return map;
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["id"] = id;
    map["amount"] = amount;
    map["is_income"] = isIncome;
    map["description"] = description;
    map["created_at"] = createdAt.toIso8601String();
    map["updated_at"] = updatedAt.toIso8601String();
    return map;
  }
}
