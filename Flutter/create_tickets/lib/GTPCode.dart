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
