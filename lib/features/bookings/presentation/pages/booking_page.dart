import 'package:balanced/features/bookings/presentation/components/custom_date_picker.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Image(
              image: AssetImage("assets/img/LogoBlack.png"), height: 30),
        ),
      ),
      body: Column(
        children: [
          CustomDatePicker(),
        ],
      ),
    );
  }
}
