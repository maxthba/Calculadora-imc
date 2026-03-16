import 'package:flutter/material.dart';

// Tela principal do app.
// É Stateful porque o resultado muda conforme o usuário digita e calcula.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Título exibido no AppBar.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controla o texto digitado no campo de peso.
  final TextEditingController _pesoController = TextEditingController();

  // Controla o texto digitado no campo de altura.
  final TextEditingController _alturaController = TextEditingController();

  // Mensagem exibida ao usuário antes e depois do cálculo.
  String _resultado = 'Informe seus dados para calcular o IMC';

  @override
  void dispose() {
    // Libera recursos dos controllers para evitar vazamento de memória.
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  void _calcularImc() {
    // Converte o texto para número decimal.
    // replaceAll permite aceitar tanto vírgula quanto ponto como separador.
    final double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
    final double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));

    // Validação básica:
    // - campos vazios ou não numéricos -> null
    // - peso/altura menor ou igual a zero é inválido
    if (peso == null || altura == null || peso <= 0 || altura <= 0) {
      setState(() {
        _resultado = 'Digite valores válidos de peso e altura';
      });
      return;
    }

    // Fórmula do IMC: peso dividido por altura ao quadrado.
    final double imc = peso / (altura * altura);

    // Guarda a classificação de acordo com a faixa do IMC.
    String classificacao;

    // Classificação padrão usada em calculadoras de IMC.
    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
    } else if (imc < 25) {
      classificacao = 'Peso normal';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else if (imc < 35) {
      classificacao = 'Obesidade grau I';
    } else if (imc < 40) {
      classificacao = 'Obesidade grau II';
    } else {
      classificacao = 'Obesidade grau III';
    }

    // Atualiza a interface com o valor final (2 casas decimais) e a classificação.
    setState(() {
      _resultado = 'IMC: ${imc.toStringAsFixed(2)}\n$classificacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Cor de topo baseada no tema do aplicativo.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        // Espaçamento geral da tela para não encostar nas bordas.
        padding: const EdgeInsets.all(16),
        child: Column(
          // Centraliza o conteúdo verticalmente.
          mainAxisAlignment: MainAxisAlignment.center,
          // Faz os filhos ocuparem toda a largura disponível.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo para entrada do peso em quilogramas.
            TextField(
              controller: _pesoController,
              // Abre teclado numérico com suporte a decimal.
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Campo para entrada da altura em metros.
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Botão que dispara o cálculo do IMC.
            ElevatedButton(
              onPressed: _calcularImc,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 20),

            // Exibe o estado atual: mensagem inicial, erro de validação ou resultado final.
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}