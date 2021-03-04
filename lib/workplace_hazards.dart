import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';

class WorkplaceHazards extends StatefulWidget {
  @override
  _WorkplaceHazardsState createState() => _WorkplaceHazardsState();
}

class _WorkplaceHazardsState extends State<WorkplaceHazards> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];

  final _items = _animals.map((animal) => MultiSelectItem<Animal>(animal, animal.name)).toList();

  List<Animal> _selectedAnimals = [];

  List<Animal> _selectedAnimals2 = [];

  List<Animal> _selectedAnimals3 = [];

  List<Animal> _selectedAnimals4 = [];

  List<Animal> _selectedAnimals5 = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'images/SIS Logo.png',
            width: 240,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Select all that Apply',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MultiSelectDialogField(
                      items: _items,
                      title: Text("Animals"),
                      selectedColor: Colors.red,
                      selectedItemsTextStyle: TextStyle(fontSize: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.pets,
                        color: Colors.blue,
                      ),
                      buttonText: Text(
                        "Favorite Animals",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 24,
                        ),
                      ),
                      onConfirm: (results) {
                        _selectedAnimals = results;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class EnvironmentBox extends StatelessWidget {
//   EnvironmentBox(this.environmentName);
//
//   final String environmentName;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//       child: RaisedButton(
//         padding: EdgeInsets.symmetric(vertical: 30),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         // color: Color(0XFF3F51B5),
//         color: Colors.green[200],
//         // textColor: Color(0xFFFFFFFF),
//         // splashColor: Colors.grey,
//         elevation: 10,
//         onPressed: () {},
//         child: Text(
//           environmentName,
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}
