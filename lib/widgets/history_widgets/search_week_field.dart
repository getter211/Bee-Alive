import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWeekWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchWeekWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "¡Elije la fecha!",
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.brown,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.calendar_today,
              color: Colors.brown,
            ),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                controller.text =
                    "Semana del ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
