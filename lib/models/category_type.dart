class CategoryType {
  String name;
  String color;

  CategoryType(this.name, this.color);

  static List<CategoryType> getTypes() {
    return <CategoryType>[
      CategoryType('Food', 'red'),
      CategoryType('Clothing', 'blue'),
      CategoryType('Entertainment', 'green'),
      CategoryType('Utilities', 'orange'),
      CategoryType('Other', 'purple'),
    ];
  }
}