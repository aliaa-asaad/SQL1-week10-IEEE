class ToDo {
  int? id;
  String? name;
  String? date;
  bool? isChecked;

  ToDo({this.id, this.name, this.date, this.isChecked});

  ToDo.fromMap(Map<String, dynamic> map) {
    if (map['id'] != null) this.id = map['id'];
    this.name = map['name'];
    this.date = map['date'];
    this.isChecked = map['isChecked'] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map;
    return map = {
      if (this.id != null) 'id': this.id,
      'name': this.name,
      'date': this.date,
      'isChecked': this.isChecked == true ? 1 : 0,
    };
  }
}
