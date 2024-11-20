import 'package:flutter/material.dart';
import 'package:fuegobase/services/firebase_service.dart';

class EditUsuario extends StatefulWidget {
  const EditUsuario({super.key});

  @override
  State<EditUsuario> createState() => _EditUsuarioState();
}

class _EditUsuarioState extends State<EditUsuario> {
  // Controladores para los campos de texto
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nocuentaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Recibimos los argumentos
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Asignamos los valores iniciales a los controladores
    nombreController.text = arguments['nombre'];
    emailController.text = arguments['email'];
    nocuentaController.text = arguments['nocuenta'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nocuentaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'No. cuenta',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Llamamos a la función para editar el usuario en Firestore
                await editUsuario(
                  arguments['uid'],
                  nombreController.text,
                  emailController.text,
                  nocuentaController.text,
                ).then((_) {
                  Navigator.pop(context); // Volver a la pantalla anterior
                });
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
