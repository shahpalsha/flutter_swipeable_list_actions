import 'package:flutter/material.dart';
import 'package:flutter_swipeable_list_actions/flutter_swipeable_list_actions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            'Swipeable List Actions',
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: SwipeableListActions(
                leftActions: [
                  SwipeActionButton(
                    icon: Icons.edit,
                    label: 'Edit',
                    style: const SwipeActionStyle(
                      backgroundColor: Colors.blue,
                    ),
                    onTap: () async {
                      TextEditingController controller =
                      TextEditingController(text: items[index]);

                      String? updatedValue = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Edit Item'),
                            content: TextField(
                              controller: controller,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, controller.text);
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );

                      if (updatedValue != null && updatedValue.isNotEmpty) {
                        setState(() {
                          items[index] = updatedValue;
                        });
                      }
                    },
                  ),
                ],
                rightActions: [
                  SwipeActionButton(
                    icon: Icons.delete,
                    label: 'Delete',
                    style: const SwipeActionStyle(
                      backgroundColor: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                  ),
                ],
                child: Card(
                  child: ListTile(
                    title: Text(items[index]),
                    subtitle: const Text('Swipe left or right'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}