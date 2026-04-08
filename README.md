# 🔄 flutter_swipeable_list_actions
```
flutter_swipeable_list_actions is a powerful and customizable swipe action library for Flutter.

It allows developers to add swipeable left and right actions to any list item, similar to email apps, chat apps and task managers.

The package supports custom edit, delete, archive, favorite or any other action buttons with fully customizable colors, icons, widths and styles.

Developers can create modern swipeable list experiences for Android, iOS, Web and Desktop applications using a lightweight and simple API.
```

------------------------------

## ✨ Features
```
- 👈 Swipe Left & Right Actions
- 🗑 Custom Delete Action
- ✏️ Custom Edit Action
- 🎨 Fully Customizable Colors & Styles
- 🔘 Custom Icons and Labels
- 📏 Adjustable Action Width
- ⚡ Smooth Animated Swipe Motion
- 👆 Tap Support on Swipe Actions
- 🔄 Auto Close After Action Click
- 📱 Works with ListView, Column and Custom Widgets
- 🌐 Supports Android, iOS, Web & Desktop
- 📦 Lightweight and Easy to Use
```
-----------------------------

## 📦 Installation

Add dependency in your pubspec.yaml
```
dependencies:
  flutter_swipeable_list_actions:
    path: 
```
Then run:
```
flutter pub get
```  

----------------------------

## 🎬 Preview

https://github.com/user-attachments/assets/bfa9ea3b-09aa-4655-9439-6e15acd5e1c8

----------------------

## 🗂 File Structure

```
flutter_swipeable_list_actions/
│
├─ lib/
│   ├─ flutter_swipeable_list_actions.dart
│   │   // Main export file
│   │ 
│   ├─ main.dart
│   │      // Example application
│   │ 
│   └─ src/
│       ├─ swipeable_list_actions.dart
│       │   // Main swipeable widget
│       │
│       ├─ swipe_action_button.dart
│       │   // Action model for edit/delete buttons
│       │
│       ├─ swipe_action_style.dart
│       │   // Custom style options for action buttons
│       │
│       ├─ swipe_action_controller.dart
│       │   // Open / close swipe state controller
│       │
│       ├─ swipe_direction.dart
│       │   // Swipe direction enum
│       │
│       └─ utils/
│           └─ swipe_constants.dart
│               // Default widths, durations and limits
│
├─ test/
│   └─ swipeable_list_actions_test.dart
│       // Package test file
│
├─ README.md
├─ LICENSE
├─ CHANGELOG.md
└─ pubspec.yaml
```
-----------------------------

## 🚀 How To Use

1️⃣ Import Package
```
import 'package:flutter_swipeable_list_actions/flutter_swipeable_list_actions.dart';
```
2️⃣ Basic Swipe Actions
```
SwipeableListActions(
  leftActions: [
    SwipeActionButton(
      icon: Icons.edit,
      label: 'Edit',
      style: const SwipeActionStyle(
        backgroundColor: Colors.blue,
      ),
      onTap: () {
        print('Edit clicked');
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
        print('Delete clicked');
      },
    ),
  ],
  child: Card(
    child: ListTile(
      title: Text('Item 1'),
      subtitle: Text('Swipe left or right'),
    ),
  ),
)
```
3️⃣ Delete Item From List
```
onTap: () {
  setState(() {
    items.removeAt(index);
  });
}
```
4️⃣ Edit Item
```
onTap: () async {
  TextEditingController controller =
      TextEditingController(text: items[index]);

  String? result = await showDialog<String>(
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

  if (result != null && result.isNotEmpty) {
    setState(() {
      items[index] = result;
    });
  }
}
```
5️⃣ Full Example
```
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

                      if (updatedValue != null &&
                          updatedValue.isNotEmpty) {
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
```

-----------------------------

## 🎨 SwipeActionStyle Properties

| Property        | Description                       |
| --------------- | --------------------------------- |
| backgroundColor | Background color of action button |
| foregroundColor | Icon and text color               |
| borderRadius    | Border radius of action           |
| width           | Width of swipe action button      |


-----------------------------

## 📄 MIT License
```
Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files to deal in the Software without restriction.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
```














