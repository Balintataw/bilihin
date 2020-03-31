class ExpenseType {
  String name;

  ExpenseType(this.name);

  static List<ExpenseType> getTypes() {
    return <ExpenseType>[
      ExpenseType('Food'),
      ExpenseType('Clothing'),
      ExpenseType('Entertainment'),
      ExpenseType('Utilities'),
      ExpenseType('Other'),
    ];
  }
}