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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // Asignamos valores por defecto para evitar errores con valores null
                var usuario = snapshot.data![index];
                String nombre = usuario['nombre'] ?? 'Sin nombre';
                String aPaterno = usuario['aPaterno'] ?? 'Sin apellido';
                String uid = usuario['uid'] ?? '';

                return ListTile(
                  title: Text(nombre),
                  subtitle: Text(aPaterno),
                  leading: CircleAvatar(
                    child: Text(nombre.isNotEmpty ? nombre[0] : '?'),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/edit', arguments: {
                      'uid': uid,
                      'nombre': nombre,
                      'email': usuario['email'] ?? '',
                      'nocuenta': usuario['nocuenta'] ?? '',
                    });
                    setState(() {}); // Refresca la lista después de editar
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {}); // Refresca la lista después de agregar un usuario
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
