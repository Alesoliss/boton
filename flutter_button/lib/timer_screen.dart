import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  final String teamName;
  final String teamColor;

  const TimerScreen({Key? key, required this.teamName, required this.teamColor}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  String _currentTime = '';
  bool _isRunning = true;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipo: ${widget.teamName} (${widget.teamColor})'),
        backgroundColor: widget.teamColor == 'rojo' ? Colors.red : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
