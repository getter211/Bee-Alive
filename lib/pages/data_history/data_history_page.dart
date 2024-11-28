// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/history_widgets/history_card.dart';
import 'package:flutter_application_1/widgets/history_widgets/search_week_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../utils/sensor_data_utils.dart';
import '../chart/charts_page.dart';

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

  List<Map<String, String>> getLastDataPerDay(
      List<Map<String, String>> sensorData) {
    Map<String, Map<String, String>> lastDataByDay = {};

    for (var data in sensorData) {
      String dateTime = data['date'] ?? '';
      if (dateTime.isNotEmpty) {
        DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
        String dayKey = DateFormat('dd/MM/yyyy').format(parsedDate);

        if (!lastDataByDay.containsKey(dayKey) ||
            parsedDate.isAfter(DateFormat('dd/MM/yyyy HH:mm')
                .parse(lastDataByDay[dayKey]!['date']!))) {
          lastDataByDay[dayKey] = data;
        }
      }
    }

    return lastDataByDay.values.toList();
  }

  List<Map<String, String>> getSensorDataForDay(
      DateTime day, List<Map<String, String>> sensorData) {
    return sensorData.where((data) {
      String dateTime = data['date'] ?? '';
      if (dateTime.isNotEmpty) {
        DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
        String dayKey = DateFormat('dd/MM/yyyy').format(parsedDate);
        String selectedDayKey = DateFormat('dd/MM/yyyy').format(day);
        return dayKey == selectedDayKey;
      }
      return false;
    }).toList();
  }

  List<Map<String, String>> getSensorDataForWeek(
      DateTime weekStart, List<Map<String, String>> sensorData) {
    return sensorData.where((data) {
      String dateTime = data['date'] ?? '';
      if (dateTime.isNotEmpty) {
        DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
        DateTime startOfWeek = getStartOfWeek(parsedDate);
        return startOfWeek == weekStart;
      }
      return false;
    }).toList();
  }

  /// Agrupa los datos por semana
  Map<DateTime, List<Map<String, String>>> groupDataByWeek(
      List<Map<String, String>> sensorData) {
    Map<DateTime, List<Map<String, String>>> dataByWeek = {};

    for (var data in sensorData) {
      String dateTime = data['date'] ?? '';
      if (dateTime.isNotEmpty) {
        DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
        DateTime weekStart = getStartOfWeek(parsedDate);

        if (!dataByWeek.containsKey(weekStart)) {
          dataByWeek[weekStart] = [];
        }
        dataByWeek[weekStart]!.add(data);
      }
    }

    return dataByWeek;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 231, 207),
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
                    if (date.weekday != DateTime.monday) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('La semana debe comenzar en lunes.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      selectedDate = getStartOfWeek(date);
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Semanas de monitorización',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.brown,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future: loadSensorDataFromPreferences(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error al cargar los datos.'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay datos disponibles.'));
                  }

                  List<Map<String, String>> sensorData = snapshot.data!;
                  List<Map<String, String>> lastDataPerDay =
                      getLastDataPerDay(sensorData);
                  Map<DateTime, List<Map<String, String>>> dataByWeek =
                      groupDataByWeek(lastDataPerDay);

                  if (selectedDate != null) {
                    DateTime startOfSelectedWeek =
                        getStartOfWeek(selectedDate!);

                    if (!dataByWeek.containsKey(startOfSelectedWeek)) {
                      return Center(
                        child: Text(
                          'No hay datos para la semana seleccionada.',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.brown,
                          ),
                        ),
                      );
                    }

                    // Filtrar solo la semana seleccionada
                    dataByWeek = {
                      startOfSelectedWeek: dataByWeek[startOfSelectedWeek]!,
                    };
                  }

                  if (dataByWeek.isEmpty) {
                    return const Center(
                        child: Text('No hay semanas disponibles.'));
                  }

                  return ListView(
                    children: dataByWeek.entries.map((entry) {
                      DateTime weekStart = entry.key;
                      List<Map<String, String>> weekData = entry.value;

                      List<Widget> weekCards = weekData.map((data) {
                        String dateTime = data['date'] ?? '';
                        DateTime parsedDate =
                            DateFormat('dd/MM/yyyy HH:mm').parse(dateTime);
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(parsedDate);
                        String formattedTime =
                            DateFormat('HH:mm').format(parsedDate);
                        List<Map<String, String>> dayData =
                            getSensorDataForDay(parsedDate, sensorData);

                        return HistorialCard(
                          semana: formattedDate,
                          hora: formattedTime,
                          dayData: dayData,
                        );
                      }).toList();

                      // Envolver las tarjetas de una semana en un contenedor clicable
                      return GestureDetector(
                        onTap: () {
                          List<Map<String, String>> weekData =
                              getSensorDataForWeek(weekStart, sensorData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChartScreen(
                                weekData: weekData,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 253, 181, 99),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Semana del ${DateFormat('dd/MM/yyyy').format(weekStart)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: weekCards,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
