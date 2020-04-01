import 'package:flutter/material.dart';
import 'package:expenseTracker/models/category_type.dart';

class CategoryDropdown extends StatefulWidget {
  final Function onSelect;
  final CategoryType selectedItem;

  CategoryDropdown({this.onSelect, this.selectedItem});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  List<CategoryType> _expenseTypes = CategoryType.getTypes();
  List<DropdownMenuItem<CategoryType>> _dropdownMenuItems;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_expenseTypes);
    super.initState();
  }

  List<DropdownMenuItem<CategoryType>> buildDropdownMenuItems(expenseTypes) {
    List<DropdownMenuItem<CategoryType>> items = List();
    for(CategoryType ex in expenseTypes) {
      items.add(DropdownMenuItem(value: ex, child: Text(ex.name)));
    }
    return items;
  }

  handleDropdownMenuItemChange(item) {
    widget.onSelect(item);
  }
    

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Category'),
          DropdownButton(
            isExpanded: true,
            items: _dropdownMenuItems, 
            value: widget.selectedItem,
            onChanged: handleDropdownMenuItemChange,
          ),
        ],
      ),
    );
  }
}