// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorTable extends StatefulWidget {
  final List<Map<String, String>> sensorData;
  final double textSize;

  const SensorTable({
    super.key,
    required this.sensorData,
    required this.textSize,
  });

  @override
  _SensorTableState createState() => _SensorTableState();
}

class _SensorTableState extends State<SensorTable> {
  int currentPage = 0;
  static const int itemsPerPage = 6;

  get textSize => null;

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.sensorData.length / itemsPerPage).ceil();
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage) > widget.sensorData.length
        ? widget.sensorData.length
        : startIndex + itemsPerPage;
    final currentData = widget.sensorData.sublist(startIndex, endIndex);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            border: TableBorder.all(
              color: Colors.grey.shade300,
              width: 1,
              borderRadius: BorderRadius.circular(12),
            ),
            children: [
              // Header
              TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xFFB27C34),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                children: [
                  _buildTableHeader('Lectura',
                      icon: const Icon(Icons.book, color: Color(0xFFEDDA6F))),
                  _buildTableHeader('Temp',
                      icon: const Icon(Icons.thermostat,
                          color: Color(0xFFEDDA6F))),
                  _buildTableHeader('Humedad',
                      icon: const Icon(Icons.water_drop_outlined,
                          color: Color(0xFFEDDA6F))),
                  _buildTableHeader('Fecha',
                      icon: const Icon(Icons.calendar_month,
                          color: Color(0xFFEDDA6F))),
                ],
              ),
              ...currentData.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> sensor = entry.value;
                bool isEven = index % 2 == 0;
                return TableRow(
                  decoration: BoxDecoration(
                    color: isEven ? Colors.white : Colors.grey.shade100,
                  ),
                  children: [
                    _buildTableCell('Lectura ${startIndex + index + 1}'),
                    _buildTableCell('${sensor['temperature']}°C'),
                    _buildTableCell('${sensor['humidity']}%'),
                    _buildTableCell(sensor['date']!),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: currentPage > 0
                  ? () {
                      setState(() {
                        currentPage--;
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB27C34),
                disabledBackgroundColor: Colors.grey.shade400,
              ),
              child: const Icon(Icons.arrow_back_ios, color: Color(0xFFEDDA6F)),
            ),
            const SizedBox(width: 10),
            Text(
              'Página ${currentPage + 1} de $totalPages',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFB27C34),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: currentPage < totalPages - 1
                  ? () {
                      setState(() {
                        currentPage++;
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB27C34),
                disabledBackgroundColor: Colors.grey.shade400,
              ),
              child:
                  const Icon(Icons.arrow_forward_ios, color: Color(0xFFEDDA6F)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text, {Widget? icon}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFEDDA6F),
            ),
          ),
          if (icon != null) ...[
            const SizedBox(height: 4),
            icon,
          ],
        ],
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: widget.textSize - 2,
          fontWeight: FontWeight.w500,
          color: Colors.brown.shade600,
        ),
      ),
    );
  }
}
