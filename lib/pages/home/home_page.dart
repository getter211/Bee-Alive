// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_widgets/capture_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services_providers/notification_S.dart';
import '../../utils/sensor_data_utils.dart';
import '../../widgets/home_widgets/drawer_home.dart';
import '../../widgets/home_widgets/header_section.dart';
import '../../widgets/sensor_table.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  bool _isDataSaved = false;
  List<Map<String, String>> _sensorData = [];

  Future<void> _loadSensorDataFromFile() async {
    setState(() => _isLoading = true);
    try {
      final data = await loadSensorDataFromFiles();
      setState(() {
        _sensorData = data;
        _isDataSaved =
            false; 
      });
    } catch (e) {
      _showErrorDialog(
          'Hubo un problema al cargar los datos. Por favor, inténtalo de nuevo.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Se guardaron los datos'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '¿Quieres borrar los datos de tu colmena?',
          style: TextStyle(color: Colors.brown),
        ),
        content: Text(
          'Si borras los datos de tu colmena, no podrás verlos en la app.',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.brown),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.brown)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Aceptar', style: TextStyle(color: Colors.brown)),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        _sensorData.clear();
         deleteSensorDataFromPreferences();
        _isDataSaved = false;
      });
    }
  }

  Future<void> _showSavedDataDialog() async {
    List<Map<String, String>> savedData = await loadSensorDataFromPreferences();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Datos Guardados'),
        content: Text(
          savedData.isNotEmpty
              ? 'Datos cargados: ${savedData.length} entradas.'
              : 'No hay datos guardados.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveData() async {
    await saveSensorDataToPreferences(_sensorData);
    setState(() {
      _isDataSaved = true; 
    });
    
    NotificationService().showNotification(
      title: '¡Datos guardados!',
      body: 'Los datos de tu colmena se han guardado correctamente.',
    );

    _showErrorDialog('Los datos de tu colmena se han guardado correctamente.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outlined,
              color: Colors.brown,
            ),
            onPressed: () {
              if (_sensorData.isEmpty) {
                deleteSensorDataFromPreferences();
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Aún no has importado los datos de tu colmena.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Aceptar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                _showDeleteConfirmationDialog();
              }
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFF9DC),
      drawer: const DrawerHome(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double textSize = constraints.maxWidth * 0.04;
          textSize = textSize > 20 ? 20 : textSize;
          double buttonWidth = constraints.maxWidth * 0.4;
          double buttonHeight = constraints.maxHeight * 0.04;
          double spacing = constraints.maxHeight * 0.05;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: spacing),
                    if (_sensorData.isEmpty)
                      Column(
                        children: [
                          const HeaderSection(),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Importa tu archivo para ver los datos de tu colmena durante la semana',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textSize,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.brown),
                                )
                              : CaptureButton(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  onPressed: _loadSensorDataFromFile,
                                ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          SensorTable(
                              sensorData: _sensorData, textSize: textSize),
                          const SizedBox(height: 50),
                          if (!_isDataSaved) 
                            ElevatedButton(
                              onPressed: _saveData,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB27C34),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                              ),
                              child: Text(
                                'Guardar archivo',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFEDDA6F),
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          if (_isDataSaved) 
                            ElevatedButton(
                              onPressed: _showSavedDataDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB27C34),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                              ),
                              child: Text(
                                'Ver datos guardados',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFEDDA6F),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
