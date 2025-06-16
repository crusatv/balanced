import 'package:balanced/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

// PARA VERSIÓN 2.0.9 - USANDO EasyDateTimeLine (funciona en v2.0.9)
/*
dependencies:
  easy_date_timeline: ^2.0.9
*/

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyDateTimeLine(
            locale: 'es_ES',
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              setState(() {
                this.selectedDate = selectedDate;
              });
            },
            headerProps: const EasyHeaderProps(
              showHeader: false,
            ),
            dayProps: EasyDayProps(
              height: 60,
              width: 40,
              dayStructure: DayStructure.dayNumDayStr,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                dayStrStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              inactiveDayStyle: const DayStyle(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                dayStrStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                dayStrStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
            timeLineProps: const EasyTimeLineProps(
              hPadding: 8.0,
              separatorPadding: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}
