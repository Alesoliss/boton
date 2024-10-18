import 'package:flutter/material.dart';
import 'team_selection_screen.dart'; // Importar la pantalla de selección de equipos
import 'jovenes.dart'; // Importar la pantalla de preguntas para Jóvenes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1F2C46),
        scaffoldBackgroundColor: const Color(0xFF1F2C46),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2C46),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texto del balance
            Center(
              child: Column(
                children: const [
                  Text(
                    'Campeonato',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bíblico 2024',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Romanos 8:31-39',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Botones de acciones (Estudio Bíblico, Oración, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.book, 'Parabolas'),
                _buildActionButton(Icons.church, 'Testamentos'),
                _buildActionButton(Icons.people, 'Historia'),
                _buildActionButton(Icons.light, 'Reflexión'),
              ],
            ),
            const SizedBox(height: 30),
            // Filtro de transacciones (Eventos, Capítulos, etc.)
            const Text(
              'Eventos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('D', true),
                _buildFilterButton('M', false),
                _buildFilterButton('W', false),
                _buildFilterButton('V', false),
                _buildFilterButton('S', false),
              ],
            ),
            const SizedBox(height: 20),
            // Lista de transacciones
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem('Primarios', 'Estudio', 'Historia', Icons.people),
                  _buildTransactionItem('Adolescentes', 'Estudio', 'Historia', Icons.people),
                  GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de Jóvenes
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const JovenesScreen()), // Navegación a JovenesScreen
                      );
                    },
                    child: _buildTransactionItem('Jóvenes', 'Estudio', 'Historia', Icons.people),
                  ),
                ],
              ),
            ),
            // Barra inferior con opciones de cuentas
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF162A4A),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavButton(context, 'Iniciar', true),
                  _buildBottomNavButton(context, 'Empezar', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para los botones de acción
  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF4E91FF),
          ),
          width: 60,
          height: 60,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  // Widget para los botones de filtro de transacciones
  Widget _buildFilterButton(String label, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4E91FF) : const Color(0xFF293B5F),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  // Widget para los elementos de la lista de transacciones
  static Widget _buildTransactionItem(
      String title, String subtitle, String points, IconData icon) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF293B5F),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: Text(
        points,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget para los botones de navegación inferior
  Widget _buildBottomNavButton(BuildContext context, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TeamSelectionScreen()), 
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E91FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
