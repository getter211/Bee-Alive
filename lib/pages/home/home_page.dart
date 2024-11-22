import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_widgets/capture_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/sensor_data_utils.dart';
import '../../widgets/home_widgets/drawer_home.dart';
import '../../widgets/home_widgets/header_section.dart';
import '../../widgets/sensor_table.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<Map<String, String>> _sensorData = [];

  Future<void> _loadSensorDataFromFile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await loadSensorDataFromFile();
      setState(() {
        _sensorData = data;
      });
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Hubo un problema al cargar los datos. Por favor, inténtalo de nuevo.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método para guardar los datos en SharedPreferences
  Future<void> _showDeleteConfirmationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Quieres borrar los datos de tu colmena?',
              style: TextStyle(color: Colors.brown)),
          content: Text(
            'Si borras los datos de tu colmena, no podrás verlos en la app.',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.brown),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.brown)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child:
                  const Text('Aceptar', style: TextStyle(color: Colors.brown)),
            ),
          ],
        );
      },
    );

    if (result == true) {
      setState(() {
        _sensorData.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outlined, color: Colors.brown),
            onPressed: () {
              if (_sensorData.isEmpty) {
                // Mostrar un diálogo indicando que no hay datos
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Sin datos',
                        style: TextStyle(color: Colors.brown)),
                    content: Text(
                      'Aún no has importado los datos de tu colmena.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Llama al diálogo de confirmación si hay datos
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
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double textSize = screenWidth * 0.04;
          textSize = textSize > 20 ? 20 : textSize;
          double buttonHeight = screenHeight * 0.04;
          double buttonWidth = screenWidth * 0.4;
          double spacing = screenHeight * 0.05;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: spacing),
                    if (_sensorData.isEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    if (_sensorData.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(height: spacing),
                          SensorTable(
                            sensorData: _sensorData,
                            textSize: textSize,
                          ),
                          const SizedBox(height: 70),
                          ElevatedButton(
                            onPressed: () async {
                              // Guarda los datos en SharedPreferences
                              await saveSensorDataToPreferences(_sensorData);

                              // Muestra un diálogo de confirmación
                              showDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Datos guardados'),
                                  content: const Text(
                                      'Los datos de tu colmena se han guardado correctamente.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Aceptar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFEDDA6F),
                              backgroundColor: const Color(0xFFB27C34),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              elevation: 5,
                              shadowColor: Colors.black.withOpacity(0.2),
                              splashFactory: InkRipple.splashFactory,
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
                          ElevatedButton(
                            onPressed: () async {
                              // Cargar los datos guardados
                              List<Map<String, String>> savedData =
                                  await loadSensorDataFromPreferences();

                              // Mostrar los datos en un dialog o imprimir en consola
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Datos Guardados'),
                                  content: Text(savedData.isNotEmpty
                                      ? 'Datos cargados: ${savedData.length} entradas.'
                                      : 'No hay datos guardados.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Aceptar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('Ver datos guardados'),
                          )
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
