import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String avatarUrl;

  User({required this.name, required this.email, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: '${json['first_name']} ${json['last_name']}',
      email: json['email'],
      avatarUrl: json['avatar'],
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=1&per_page=10'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1', 
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> usersData = responseData['data'];
        
        setState(() {
          users = usersData.map<User>((user) => User.fromJson(user)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load users: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching users: $e');
      setState(() {
        error = 'Error connecting to server';
        isLoading = false;
      });
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!),
            ElevatedButton(
              onPressed: fetchUsers,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (users.isEmpty) {
      return const Center(
        child: Text(
          'No users found',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchUsers,
      child: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () {
                final selectedName = user.name;
                Navigator.pop(context, selectedName);
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        user.avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text(
                '9:41',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: false,
              actions: [
                const Icon(Icons.signal_cellular_4_bar, color: Colors.black, size: 18),
                const SizedBox(width: 4),
                const Icon(Icons.wifi, color: Colors.black, size: 18),
                const SizedBox(width: 4),
                const Icon(Icons.battery_full, color: Colors.black, size: 18),
                const SizedBox(width: 16),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Third Screen',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildContent(),
    );
  }
}