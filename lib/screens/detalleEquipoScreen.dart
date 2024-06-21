import 'package:flutter/material.dart';
import 'package:api_equipo/equipo.dart';
import 'package:api_equipo/dataHeper.dart';

class DetalleEquipoScreen extends StatefulWidget {
  final Equipo equipo;

  DetalleEquipoScreen(this.equipo);

  @override
  _DetalleEquipoScreenState createState() => _DetalleEquipoScreenState();
}

class _DetalleEquipoScreenState extends State<DetalleEquipoScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController nombreController = TextEditingController();
  TextEditingController anioController = TextEditingController();
  TextEditingController fechaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.equipo.id != null) {
      nombreController.text = widget.equipo.nombreEquipo;
      anioController.text = widget.equipo.anioFundacion.toString();
      fechaController.text = widget.equipo.fechaCampeonato;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipo.id != null ? 'Editar Equipo' : 'Agregar Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre del Equipo'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: anioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Año de Fundación'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(labelText: 'Fecha de Campeonato'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveEquipo();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveEquipo() async {
    Equipo equipo = Equipo(
      id: widget.equipo.id ?? 0, // Si widget.equipo.id es null, asigna 0
      nombreEquipo: nombreController.text,
      anioFundacion: int.parse(anioController.text),
      fechaCampeonato: fechaController.text,
    );

    if (widget.equipo.id != null && widget.equipo.id != 0) {
      await databaseHelper.updateEquipo(equipo);
    } else {
      await databaseHelper.insertEquipo(equipo);
    }

    Navigator.pop(context, true); // Devuelve true para indicar éxito al guardar
  }
}
