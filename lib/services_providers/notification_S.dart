// ignore_for_file: prefer_const_declarations

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inicializa la notificación
  Future<void> initNotification() async {
    // Solicita permiso para las notificaciones en Android
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings initializationSettings =
        const InitializationSettings(
      android: androidInitializationSettings,
    );

    // Inicializa el plugin
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Manejar la respuesta de la notificación, si es necesario
      },
    );

    // Crear el canal de notificación en Android
    await _createNotificationChannel();
  }

  // Crear un canal de notificación para Android
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channelId', // ID del canal
      'channelName', // Nombre del canal
      description: 'Your channel description', // Descripción del canal
      importance: Importance.max, // Importancia máxima
    );

    // Registrar el canal
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Devuelve los detalles de la notificación
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId', // ID del canal
        'channelName', // Nombre del canal
        channelDescription: 'Your channel description', // Descripción del canal
        importance: Importance.max, // Importancia máxima
        priority: Priority.high, // Prioridad alta
        ticker: 'ticker', // Ticker (opcional)
      ),
    );
  }

  // Muestra la notificación
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    return notificationsPlugin.show(
      id,
      title ?? 'Título predeterminado', // Valor predeterminado si title es null
      body ??
          'Cuerpo de la notificación', // Valor predeterminado si body es null
      notificationDetails(),
      payload: payLoad, // Payload opcional
    );
  }
}
