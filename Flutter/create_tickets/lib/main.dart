// import 'package:create_tickets/components/ticket.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Concert Tickets'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController ticketNameController = TextEditingController();
//     TextEditingController ticketPriceController = TextEditingController();
//     List ticketData = [
//       {
//         'ticketName': 'General I',
//         'ticketPrice': 100,
//       },
//       {
//         'ticketName': 'General II',
//         'ticketPrice': 80,
//       },
//       {
//         'ticketName': 'General III',
//         'ticketPrice': 50,
//       }
//     ];
//     void createTicket() {
//       ticketData.add({
//         'ticketName': ticketNameController.text,
//         'ticketPrice': ticketPriceController.text,
//       });
//       print('arr: $ticketData');
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Align(
//             alignment: Alignment.center,
//             child: Text(
//               widget.title,
//             )),
//       ),
//       body: Align(
//         alignment: Alignment.topCenter,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//           child: ListView.builder(
//             itemCount: ticketData.length,
//             itemBuilder: (context, index) {
//               final ticket = ticketData[index];
//               return Ticket(
//                 title: '${ticket['ticketName']}',
//                 price: '${ticket['ticketPrice']}',
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return Container(
//                   child: AlertDialog(
//                     title: const Text('Enter ticket details'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextField(
//                           controller: ticketNameController,
//                           maxLength: 50,
//                           decoration: const InputDecoration(
//                               hintText: 'Enter ticket name', counterText: ''),
//                         ),
//                         TextField(
//                           controller: ticketPriceController,
//                           keyboardType: TextInputType.numberWithOptions(),
//                           decoration: const InputDecoration(
//                               hintText: 'Enter ticket price'),
//                         ),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                           onPressed: () {
//                             createTicket();
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Create Ticket'))
//                     ],
//                   ),
//                 );
//               });
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Tickets List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicketListScreen(),
    );
  }
}

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  // Sample data
  List<Map<String, dynamic>> tickets = [
    {
      'ticketName': 'General I',
      'ticketPrice': 100,
    },
    {
      'ticketName': 'General II',
      'ticketPrice': 80,
    },
    {
      'ticketName': 'General III',
      'ticketPrice': 50,
    }
  ];

  void _addTicket(String name, int price) {
    setState(() {
      tickets.add({
        'ticketName': name,
        'ticketPrice': price,
      });
    });
  }

  void _showAddTicketDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Ticket'),
          content: AddTicketForm(onSubmit: _addTicket),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets List'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: _showAddTicketDialog,
            child: const Text('Add Ticket'),
          ),
          Expanded(
            child: ListView(
              children: tickets.map((ticket) {
                return TicketCard(
                  name: ticket['ticketName'],
                  price: ticket['ticketPrice'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String name;
  final int price;

  TicketCard({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${price}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class AddTicketForm extends StatefulWidget {
  final Function(String, int) onSubmit;

  AddTicketForm({super.key, required this.onSubmit});

  @override
  _AddTicketFormState createState() => _AddTicketFormState();
}

class _AddTicketFormState extends State<AddTicketForm> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  void _submitForm() {
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text) ?? 0;

    if (name.isNotEmpty && price > 0) {
      widget.onSubmit(name, price);
      Navigator.of(context).pop();
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter a valid ticket name and price.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Ticket Name'),
        ),
        TextField(
          controller: _priceController,
          decoration: const InputDecoration(labelText: 'Ticket Price'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Add Ticket'),
        ),
      ],
    );
  }
}
