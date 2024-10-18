import 'package:flutter/material.dart';
import 'timer_screen.dart'; // Para navegar al temporizador desde la pantalla de selección de equipo

class TeamSelectionScreen extends StatelessWidget {
  const TeamSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu equipo'),
        backgroundColor: const Color(0xFF0D1B2A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Elige un equipo:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTeamCard(context, 'Equipo 1', Colors.redAccent, 'rojo'),
                _buildTeamCard(context, 'Equipo 2', Colors.blueAccent, 'azul'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context, String title, Color color, String teamColor) {
    return GestureDetector(
      onTap: () {
        _showTeamNameInput(context, teamColor);
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showTeamNameInput(BuildContext context, String teamColor) {
    final TextEditingController _teamNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el nombre del equipo ($teamColor)'),
          content: TextField(
            controller: _teamNameController,
            decoration: const InputDecoration(
              labelText: 'Nombre del equipo',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String teamName = _teamNameController.text;
                Navigator.pop(context); // Cerrar el modal
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(teamName: teamName, teamColor: teamColor),
                  ),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
