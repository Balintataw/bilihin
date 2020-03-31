import 'package:expenseTracker/models/expense_type.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final Function onSelect;
  final ExpenseType selectedItem;

  CategoryDropdown({this.onSelect, this.selectedItem});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  List<ExpenseType> _expenseTypes = ExpenseType.getTypes();
  List<DropdownMenuItem<ExpenseType>> _dropdownMenuItems;
  ExpenseType _selectedExpenseType;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_expenseTypes);
    _selectedExpenseType = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<ExpenseType>> buildDropdownMenuItems(expenseTypes) {
    List<DropdownMenuItem<ExpenseType>> items = List();
    for(ExpenseType ex in expenseTypes) {
      items.add(DropdownMenuItem(value: ex, child: Text(ex.name)));
    }
    return items;
  }

  handleDropdownMenuItemChange(item) {
    // setState(() {
    //   _selectedExpenseType = item;
    // });
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