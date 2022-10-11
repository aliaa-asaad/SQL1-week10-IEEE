import 'package:flutter/material.dart';
import 'package:sql1_week10/model/db_helper.dart';
import 'package:sql1_week10/widgets/buttom_sheet.dart';

import '../model/to_do.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<ToDo> todoList = [];
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      leading: Icon(Icons.menu),
      title: Text('Tasker'),
    );
    var appBarHeight = appBar.preferredSize.height;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var height =
        MediaQuery.of(context).size.height - appBarHeight - statusBarHeight;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: height,
              child: FutureBuilder<List<ToDo>>(
                future: DBHelper.instance.getAllTodo(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    todoList = snapshot.data!;
                    return ListView.separated(
                      itemCount: todoList.length, //TODO
                      itemBuilder: (context, index) {
                        ToDo todo = todoList[index];
                        return ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                todoList.removeAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          leading: Checkbox(
                            shape: CircleBorder(),
                            value: todo.isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                todo.isChecked = value;
                              });
                            },
                          ),
                          subtitle: Text(todo.date.toString()),
                          title: Text(todo.name!),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                context: context,
                builder: (context) => ButtomSheet(
                      todoList: todoList,
                    )
                //من كتر التطبيق هفهم اكتر واوصل للمشكلة اسرع..كنت جايبة اخري مالكود الصراحة بقالي فترة فالموضوع دا وبكره اي حاجة فيها داتا بيز ايا كان شكلها..اي حاجة فيها داتا بتضايق ممنها مش بعرف اوصل للمشكلة لوحدي..ربنا يسترها هحاول اطبق كتير وربنا يسهلها من عنده..تمام
                );
            setState(() {});
          },
        ),
      ),
    );
  }
}
