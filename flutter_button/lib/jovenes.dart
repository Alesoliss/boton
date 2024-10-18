import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart'; // Para el sonido del tic-tac

class JovenesScreen extends StatefulWidget {
  const JovenesScreen({Key? key}) : super(key: key);

  @override
  _JovenesScreenState createState() => _JovenesScreenState();
}

class _JovenesScreenState extends State<JovenesScreen> {
  Timer? _timer;
  int _currentQuestionIndex = 0;
  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Control del audio del tic-tac
  String _currentTime = ''; // Variable para mostrar la hora actual
  bool _isRunning = true; // Estado del temporizador
  bool _isPaused = false; // Estado de pausa del temporizador

  final List<Map<String, String>> _questions = [
    {
      'question': '¿Cuántos libros tiene la Biblia?',
    },
    {
      'question': '¿Cómo se clasifican los libros de la Biblia?',
    },
    {
      'question': '¿Qué día creó Dios la luna y el sol?',
    },
    {
      'question': '¿Cuál fue el primer nombre de Abraham?',
    },
    {
      'question':
          '¿Quién fue la mujer que fue convertida en una estatua de sal?',
    },
    {
      'question': '¿Cuántos años trabajó Jacob por Raquel?',
    },
    {
      'question': '¿Cómo se llamaban los hijos de José?',
    },
    {
      'question': '¿Cómo se le presentó Dios a Moisés?',
    },
    {
      'question': '¿Por qué plaga murieron los primogénitos en Egipto?',
    },
    {
      'question': '¿Quién hizo el becerro de oro?',
    },
    {
      'question': '¿Qué tribu fue consagrada para el sacerdocio?',
    },
    {
      'question': '¿Qué cubría al pueblo de Israel en el día y en la noche?',
    },
    {
      'question': '¿Por qué a María, la hermana de Moisés, le dio lepra?',
    },
    {
      'question': '¿Cuántos espías envió Moisés a la tierra prometida?',
    },
    {
      'question': '¿Por qué Moisés no entró a la tierra prometida?',
    },
    {
      'question': '¿A qué hombre le habló una burra?',
    },
    {
      'question': '¿Qué significa Deuteronomio?',
    },
    {
      'question': '¿Cuántos años pasó el pueblo de Israel en el desierto?',
    },
    {
      'question': '¿Cuál es el evangelio universal?',
    },
    {
      'question': '¿Qué persona escribió más en el Nuevo Testamento?',
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
    await _audioPlayer.play('assets/ticking_clock.mp3',
        isLocal: true); // Reproducir sonido local
  }

  // Función para iniciar el temporizador
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      final now = DateTime.now();
      final formattedTime =
          "${now.hour}:${now.minute}:${now.second}:${now.millisecond}";
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
            // Pregunta actual
            Text(
              _questions[_currentQuestionIndex]['question']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Respuesta actual
            Text(
              'R// ${_questions[_currentQuestionIndex]['answer']}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Temporizador
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            // Botón para pausar o continuar el temporizador
            GestureDetector(
              onTap: _toggleTimer,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isPaused ? Colors.green : Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
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
            const SizedBox(height: 20),
            // Botones de navegación (Anterior/Siguiente)
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: _previousQuestion,
                      child: const Text('Anterior'),
                    ),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
