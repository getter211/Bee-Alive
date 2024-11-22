import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/history_widgets/history_card.dart';
import 'package:flutter_application_1/widgets/history_widgets/search_week_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../utils/sensor_data_utils.dart'; 

class DataHistoryScreen extends StatefulWidget {
  const DataHistoryScreen({super.key});

  @override
  _DataHistoryScreenState createState() => _DataHistoryScreenState();
}

class _DataHistoryScreenState extends State<DataHistoryScreen> {
  DateTime? selectedDate;

  DateTime getStartOfWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  List<Map<String, String>> filterDataByWeek(
      List<Map<String, String>> sensorData, DateTime selectedDate) {
    DateTime startOfSelectedWeek = getStartOfWeek(selectedDate);

    return sensorData.where((data) {
      String dateTime = data['date'] ?? '';
      DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
      DateTime startOfDataWeek = getStartOfWeek(parsedDate);
      return startOfDataWeek.isAtSameMomentAs(startOfSelectedWeek);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Historial de Datos',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.brown,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: SearchWeekWidget(
                controller: TextEditingController(),
                onDateSelected: (DateTime date) {
                  setState(() {
                    selectedDate = date; 
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Semanas de monitorización',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future:
                    loadSensorDataFromPreferences(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar los datos.'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay datos disponibles.'));
                  }

                  List<Map<String, String>> sensorData = snapshot.data!;
                  List<Map<String, String>> filteredData = sensorData;
                  if (selectedDate != null) {
                    filteredData = filterDataByWeek(sensorData, selectedDate!);
                  }

                  if (filteredData.isEmpty) {
                    return const Center(child: Text('No hay semana de monitorización.'));
                  }

                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      Map<String, String> data = filteredData[index];
                      String dateTime = data['date'] ?? '';
                      DateTime parsedDate =
                          DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(parsedDate);
                      String formattedTime =
                          DateFormat('HH:mm').format(parsedDate);
                      return Column(
                        children: [
                          HistorialCard(
                            semana: formattedDate,
                            hora: formattedTime,
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
