import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'dart:async';

void main() => runApp(const DadaApp());

class DadaApp extends StatelessWidget {
  const DadaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dada',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(primary: Colors.cyanAccent),
      ),
      home: const DadaHome(),
    );
  }
}

class DadaHome extends StatefulWidget {
  const DadaHome({super.key});
  @override
  State<DadaHome> createState() => _DadaHomeState();
}

class _DadaHomeState extends State<DadaHome> {
  static const platform = MethodChannel('com.dada.focusos/kiosk');
  
  @override
  void initState() {
    super.initState();
    // 1 ಸೆಕೆಂಡ್ ಬಿಟ್ಟು ಆಟೋಮ್ಯಾಟಿಕ್ ಲಾಕ್ ಆಗುತ್ತೆ
    Future.delayed(const Duration(seconds: 1), () => _kiosk(true));
  }

  Future<void> _kiosk(bool enable) async {
    try {
      await platform.invokeMethod(enable ? 'startKiosk' : 'stopKiosk');
      if (!enable) SystemNavigator.pop();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("DADA OS", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
            const SizedBox(height: 20),
            const Text("🔒 PHONE LOCKED 🔒", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => LaunchApp.openApp(androidPackageName: "com.termux"),
              child: const Text("Open Termux"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _kiosk(false),
              child: const Text("EMERGENCY EXIT", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
