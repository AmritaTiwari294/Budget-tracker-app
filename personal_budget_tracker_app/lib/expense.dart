class Expense {
  final String name;
  final double amount;
  final String category;

  Expense({
    required this.name,
    required this.amount,
    required this.category,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      name: json['name'],
      amount: json['amount'].toDouble(),
      category: json['category'],
    );
  }

  get id => null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'category': category,
    };
  }
}