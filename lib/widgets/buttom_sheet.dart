import 'package:flutter/material.dart';
import 'package:sql1_week10/model/to_do.dart';

import '../model/db_helper.dart';

class ButtomSheet extends StatefulWidget {
final  List<ToDo>? todoList;

  const ButtomSheet({ this.todoList});

  @override
  _ButtomSheetState createState() => _ButtomSheetState();
}

class _ButtomSheetState extends State<ButtomSheet> {
  TextEditingController? nameController = TextEditingController();
DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Enter the task'),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                       lastDate: DateTime.now().add(Duration(days: 30)));
                    print(selectedDate.toString());
                    setState(() {});
                  },
                  icon: Icon(Icons.calendar_month)),
              SizedBox(
                width: 20,
              ),
              Text(selectedDate != null
                  ? selectedDate.toString()
                  : "No Date Chosen")
            ],
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () {
                DBHelper.instance.insertTodo(ToDo(
                    isChecked: false,
                    date: selectedDate,
                    name: nameController!.text));
                print('aliaa');
                Navigator.of(context).pop();
              },
              child: Text('Add'))
          //.
        ],
      ),
    );
  }
}
