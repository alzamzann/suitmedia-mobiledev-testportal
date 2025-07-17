import 'package:flutter/material.dart';
import 'package:suitmedia_mobiledevtest/pages/ThirdScreen.dart';

class SecondScreen extends StatefulWidget {
  final String userName;
  const SecondScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selectedUser = '';

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
                      'Second Screen',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.userName.isNotEmpty ? widget.userName : 'No User Name',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 200),
            Center(
              child: Text(
                selectedUser.isNotEmpty ? selectedUser : 'Selected User Name',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThirdScreen(),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      selectedUser = result;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B637B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Choose a User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}