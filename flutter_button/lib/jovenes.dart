import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart'; // Para el sonido del tic-tac

class JovenesScreen extends StatefulWidget {
  const JovenesScreen({Key? key}) : super(key: key);

  @override
  _JovenesScreenState createState() => _JovenesScreenState();
}

class _JovenesScreenState extends State<JovenesScreen> with TickerProviderStateMixin {
  Timer? _timer;
  int _currentQuestionIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Control del audio del tic-tac
  String _currentTime = ''; // Variable para mostrar la hora actual
  bool _isRunning = true; // Estado del temporizador
  bool _isPaused = false; // Estado de pausa del temporizador

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '¿Cuántos libros tiene la Biblia?',
      'icon': Icons.book,
    },
    {
      'question': '¿Cómo se clasifican los libros de la Biblia?',
      'icon': Icons.library_books,
    },
    {
      'question': '¿Qué día creó Dios la luna y el sol?',
      'icon': Icons.wb_sunny,
    },
    {
      'question': '¿Cuál fue el primer nombre de Abraham?',
      'icon': Icons.person,
    },
  ];

  @override
  void initState() {
    super.initState();
    _questions.shuffle(); // Revolver preguntas aleatoriamente
    _startTickTockSound(); // Iniciar sonido de tic-tac
    _startTimer(); // Iniciar el temporizador
  }

  // Función para iniciar el sonido de tic-tac
  void _startTickTockSound() async {
    await _audioPlayer.play('assets/ticking_clock.mp3', isLocal: true); // Reproducir sonido local
  }

  // Función para iniciar el temporizador
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      final now = DateTime.now();
      final formattedTime = "${now.hour}:${now.minute}:${now.second}:${now.millisecond}";
      if (_isRunning) {
        setState(() {
          _currentTime = formattedTime;
        });
      }
    });
  }

  // Detener el sonido y temporizador cuando se deja de usar la pantalla
  @override
  void dispose() {
    _audioPlayer.stop();
    _timer?.cancel();
    super.dispose();
  }

  // Navegar a la pregunta siguiente
  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  // Navegar a la pregunta anterior
  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  // Alternar el estado del temporizador (pausar/continuar)
  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _isRunning = false;
        _isPaused = true;
        _timer?.cancel();
      } else {
        _isRunning = true;
        _isPaused = false;
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas para Jóvenes'),
        backgroundColor: const Color(0xFF1F2C46),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pregunta actual con animación
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Column(
                key: ValueKey<int>(_currentQuestionIndex),
                children: [
                  // Ícono alusivo a la pregunta
                  Icon(
                    _questions[_currentQuestionIndex]['icon'] as IconData,
                    size: 60,
                    color: const Color(0xFF4E91FF),
                  ),
                  const SizedBox(height: 20),
                  // Texto de la pregunta
                  Text(
                    _questions[_currentQuestionIndex]['question']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Temporizador
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Botón para pausar o continuar el temporizador con diseño de botón rojo
            GestureDetector(
              onTap: _toggleTimer,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.red, Colors.redAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    _isPaused ? 'Reanudar' : 'Detener',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Botones de navegación (Anterior/Siguiente) alineados abajo
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentQuestionIndex > 0)
                        GestureDetector(
                          onTap: _previousQuestion,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF4E91FF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: const Text(
                              'Anterior',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: _nextQuestion,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4E91FF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: const Text(
                            'Siguiente',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
