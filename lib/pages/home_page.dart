import 'package:flutter/material.dart';
import 'package:fuegobase/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                // Usamos un Map<String, dynamic> para obtener los datos de cada usuario
                Map<String, dynamic> usuario = snapshot.data?[index] ?? {};

                // Asignamos valores por defecto si los datos son nulos
                String nombre = usuario['nombre']?.toString() ?? 'Sin nombre';
                String aPaterno =
                    usuario['aPaterno']?.toString() ?? 'Sin apellido';

                return ListTile(
                  title: Text(nombre),
                  subtitle: Text(aPaterno),
                  leading: CircleAvatar(
                    child: Text(
                      nombre.isNotEmpty ? nombre.substring(0, 1) : '?',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
