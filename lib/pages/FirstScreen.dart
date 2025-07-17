import 'package:flutter/material.dart';
import 'package:suitmedia_mobiledevtest/pages/SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Text(
            '9:41',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 18),
          const SizedBox(width: 4),
          const Icon(Icons.wifi, color: Colors.white, size: 18),
          const SizedBox(width: 4),
          const Icon(Icons.battery_full, color: Colors.white, size: 18),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_add,
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 58),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 22),
            TextField(
              controller: _palindromeController,
              decoration: InputDecoration(
                hintText: 'Palindrome',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _checkPalindrome();
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
                  'CHECK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(userName: _nameController.text),
                    ),
                  );
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
                  'NEXT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkPalindrome() {
    String text = _palindromeController.text.toLowerCase().replaceAll(' ', '');
    String reversed = text.split('').reversed.join('');
    bool isPalindrome = text == reversed && text.isNotEmpty;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Result'),
        content: Text(isPalindrome ? 'It\'s a palindrome!' : 'Not a palindrome'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }
}