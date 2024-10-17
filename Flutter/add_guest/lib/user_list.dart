import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://kristalle.com/wp-content/uploads/2020/07/dummy-profile-pic-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'FirstName LastName',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: false
                  ? Icon(
                      Icons.circle_outlined,
                      size: 26,
                    )
                  : Icon(
                      Icons.check_circle_rounded,
                      size: 26,
                    ))
        ],
      ),
    );
  }
}
