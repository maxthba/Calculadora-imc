import 'package:flutter/material.dart';
import 'MyHomePage.dart';

// Widget raiz do aplicativo.
// Aqui definimos configurações globais, como tema e tela inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nome do app utilizado pelo sistema operacional e por algumas integrações.
      title: 'Calculadora IMC',
      theme: ThemeData(
        // Gera uma paleta de cores baseada em uma cor semente.
        // Isso mantém um visual consistente em todo o app.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      // Define a tela principal única do aplicativo.
      home: const MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}