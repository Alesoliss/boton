import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class JovenesScreen extends StatefulWidget {
  const JovenesScreen({Key? key}) : super(key: key);

  @override
  _JovenesScreenState createState() => _JovenesScreenState();
}

class _JovenesScreenState extends State<JovenesScreen> with TickerProviderStateMixin {
  Timer? _timer;
  int _currentQuestionIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _currentTime = '';
  bool _isRunning = true;
  bool _showCorrect = false;
  bool _showIncorrect = false;
  bool _optionSelected = false; // Variable para bloquear selección adicional



final List<Map<String, dynamic>> _questions = [
  {
    'question': '¿Cuántos libros tiene la Biblia?',
    'answer': '66',
    'options': ['72', '39', '66', '58'],
  },
  {
    'question': '¿Cómo se clasifican los libros de la Biblia?',
    'answer': 'El Pentateuco, Los Históricos, Los Poéticos, Los Proféticos, Los Evangelios',
    'options': [
      'Libros mayores y menores',
      'Libros de ley y poéticos',
      'Evangelios y apocalípticos',
      'El Pentateuco, Los Históricos, Los Poéticos, Los Proféticos, Los Evangelios'
    ],
  },
  {
    'question': '¿Qué día creó Dios la luna y el sol?',
    'answer': 'Cuarto día',
    'options': ['Primer día', 'Segundo día', 'Cuarto día', 'Sexto día'],
  },
  {
    'question': '¿Cuál fue el primer nombre de Abraham?',
    'answer': 'Abram',
    'options': ['Isaac', 'Jacob', 'Abram', 'David'],
  },
  {
    'question': '¿Quién fue la mujer que fue convertida en la estatua de sal?',
    'answer': 'Edith',
    'options': ['Sara', 'Edith', 'Rebeca', 'Raquel'],
  },
  {
    'question': '¿Cuántos años trabajó Jacob por Raquel?',
    'answer': '14 años',
    'options': ['7 años', '14 años', '20 años', '30 años'],
  },
  {
    'question': '¿Cómo se llamaban los hijos de José?',
    'answer': 'Efraín y Manasés',
    'options': ['Efraín y Manasés', 'Isaac y Jacob', 'Caín y Abel', 'Jacob y Esaú'],
  },
  {
    'question': '¿Cómo se le presentó Dios a Moisés?',
    'answer': 'Por medio de una zarza ardiente',
    'options': ['Como un fuego en el cielo', 'Por medio de una zarza ardiente', 'Con un ángel', 'Como un viento fuerte'],
  },
  {
    'question': '¿Por qué plaga murieron los primogénitos en Egipto?',
    'answer': 'Plaga de mortandad',
    'options': ['Plaga de ranas', 'Plaga de mortandad', 'Plaga de langostas', 'Plaga de oscuridad'],
  },
  {
    'question': '¿Quién hizo el becerro de oro?',
    'answer': 'Aarón',
    'options': ['Moisés', 'Aarón', 'Josué', 'Caleb'],
  },
  {
    'question': '¿Qué tribu fue consagrada para el sacerdocio?',
    'answer': 'La tribu de Levi',
    'options': ['La tribu de Judá', 'La tribu de Efraín', 'La tribu de Levi', 'La tribu de Rubén'],
  },
  {
    'question': '¿Qué cubría al pueblo de Israel en el día y en la noche?',
    'answer': 'Una nube en el día y una apariencia de fuego en la noche',
    'options': [
      'Una nube en el día y una apariencia de fuego en la noche',
      'Una nube en el día y un arco iris en la noche',
      'Una estrella en la noche y el sol en el día',
      'La luna en la noche y el sol en el día'
    ],
  },
  {
    'question': '¿Por qué a María, la hermana de Moisés, le dio lepra?',
    'answer': 'Por murmurar contra Moisés',
    'options': ['Por no creer en Dios', 'Por murmurar contra Moisés', 'Por mentir', 'Por tocar el Arca'],
  },
  {
    'question': '¿Cuántos espías envió Moisés a la tierra prometida?',
    'answer': '12 espías',
    'options': ['10 espías', '12 espías', '8 espías', '15 espías'],
  },
  {
    'question': '¿Por qué Moisés no entró a la tierra prometida?',
    'answer': 'Por desobediente',
    'options': ['Por falta de fe', 'Por miedo', 'Por desobediente', 'Por cansancio'],
  },
  {
    'question': '¿A qué hombre le habló una burra?',
    'answer': 'A Balaam',
    'options': ['A Moisés', 'A Aarón', 'A Balaam', 'A David'],
  },
  {
    'question': '¿Qué significa Deuteronomio?',
    'answer': 'Segunda entrega de la ley',
    'options': ['Ley de los sacerdotes', 'Instrucción a los reyes', 'Ley de los profetas', 'Segunda entrega de la ley'],
  },
  {
    'question': '¿Cuántos años pasó el pueblo de Israel en el desierto?',
    'answer': '40 años',
    'options': ['20 años', '30 años', '40 años', '50 años'],
  },
  {
    'question': '¿Cuál es el evangelio universal?',
    'answer': 'El evangelio según San Juan',
    'options': [
      'El evangelio según San Mateo',
      'El evangelio según San Marcos',
      'El evangelio según San Lucas',
      'El evangelio según San Juan'
    ],
  },
  {
    'question': '¿Qué persona escribió más en el Nuevo Testamento?',
    'answer': 'Lucas',
    'options': ['Pablo', 'Lucas', 'Pedro', 'Juan'],
  },
  {
    'question': '¿Quién de los discípulos de Jesús fue un cobrador de impuestos?',
    'answer': 'Mateo',
    'options': ['Juan', 'Pedro', 'Mateo', 'Tomás'],
  },
  {
    'question': '¿Cuántos versículos tiene el salmo 119?',
    'answer': '176 versículos',
    'options': ['150 versículos', '176 versículos', '100 versículos', '200 versículos'],
  },
  {
    'question': '¿Quién escribió el libro de Hechos?',
    'answer': 'Lucas',
    'options': ['Pablo', 'Lucas', 'Pedro', 'Juan'],
  },
  {
    'question': '¿Qué significa la palabra Biblia?',
    'answer': 'Colección de libros',
    'options': ['Libro sagrado', 'Colección de libros', 'Libro de la ley', 'Historia de Dios'],
  },
  {
    'question': '¿En qué género literario fue escrito el libro de Job?',
    'answer': 'En poesía (prosa)',
    'options': ['Narrativa', 'Historia', 'En poesía (prosa)', 'En ley'],
  },
  {
    'question': '¿De cuántos capítulos se compone el Sermón del monte según Mateo?',
    'answer': 'De 3 capítulos 5-6 y 7',
    'options': [
      'De 2 capítulos 5-6',
      'De 3 capítulos 5-6 y 7',
      'De 4 capítulos 5-6-7-8',
      'De 1 capítulo 5'
    ],
  },
];



  final List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    _questions.shuffle();
    _startTickTockSound();
    _startTimer();
  }

  void _startTickTockSound() async {
    await _audioPlayer.play('assets/ticking_clock.mp3', isLocal: true);
  }

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

  @override
  void dispose() {
    _audioPlayer.stop();
    _timer?.cancel();
    super.dispose();
  }

  void _checkAnswer(String selectedOption) {
    if (!_optionSelected) {
      setState(() {
        _optionSelected = true; // Bloquea la selección adicional
        _isRunning = false;
        if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
          _showCorrect = true;
          _showIncorrect = false;
        } else {
          _showCorrect = false;
          _showIncorrect = true;
        }
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _resetQuestionState();
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _resetQuestionState();
      }
    });
  }

  void _resetQuestionState() {
    _showCorrect = false;
    _showIncorrect = false;
    _isRunning = true;
    _optionSelected = false; // Reinicia el bloqueo para la nueva pregunta
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
          children: [
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Column(
                key: ValueKey<int>(_currentQuestionIndex),
                children: [
                  Icon(
                    Icons.question_mark,
                    size: 60,
                    color: const Color(0xFF4E91FF),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentQuestionIndex]['question'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: (_questions[_currentQuestionIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      return GestureDetector(
                        onTap: () => _checkAnswer(option),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: _showCorrect && option == _questions[_currentQuestionIndex]['answer']
                                ? Colors.green
                                : _showIncorrect && option != _questions[_currentQuestionIndex]['answer']
                                    ? Colors.red
                                    : const Color(0xFF293B5F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${_optionLabels[index]}.",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  option,
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
