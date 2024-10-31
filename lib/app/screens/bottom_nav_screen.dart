import 'package:content_safeguard/app/screens/upload_screen.dart';
import 'package:flutter/material.dart';
import 'feed_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UploadScreen(),
    const FeedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 1, 40, 40),
          elevation: 8,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.blueGrey[600],
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload_outlined), label: 'Upload'),
            BottomNavigationBarItem(
                icon: Icon(Icons.featured_play_list_outlined), label: 'Feed'),
          ],
        ),
      ),
    );
  }
}
