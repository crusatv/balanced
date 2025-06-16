import 'package:balanced/features/bookings/presentation/pages/booking_page.dart';
import 'package:balanced/features/home/presentation/pages/home_page.dart';
import 'package:balanced/features/home/presentation/pages/profile_wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    BookingPage(),
    ProfileWrapperPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        gap: 8,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        duration: Duration(milliseconds: 200),
        tabs: const [
          GButton(icon: Icons.home_outlined, text: 'Inicio'),
          GButton(icon: Icons.calendar_month_outlined, text: 'Reservar'),
          GButton(icon: Icons.account_circle_outlined, text: 'Perfil'),
        ],
      ),
    );
  }
}
