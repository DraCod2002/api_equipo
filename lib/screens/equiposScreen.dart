import 'package:api_equipo/screens/detalleEquipoScreen.dart';
import 'package:flutter/material.dart';
import 'package:api_equipo/dataHeper.dart';
import 'package:api_equipo/equipo.dart';


class EquiposScreen extends StatefulWidget {
  @override
  _EquiposScreenState createState() => _EquiposScreenState();
}

class _EquiposScreenState extends State<EquiposScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Equipo> equiposList = [];

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  void refreshList() {
    databaseHelper.getEquiposList().then((list) {
      setState(() {
        equiposList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos de Fútbol'),
      ),
      body: ListView.builder(
        itemCount: equiposList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(equiposList[index].nombreEquipo),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Año de fundación: ${equiposList[index].anioFundacion}'),
                  Text('Fecha de campeonato: ${equiposList[index].fechaCampeonato}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      navigateToDetailScreen(equiposList[index]);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEquipo(context, equiposList[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetailScreen(Equipo(
            id: 0, // Puedes ajustar el ID según sea necesario o como lo necesites
            nombreEquipo: '',
            anioFundacion: 2000, // Ajusta según sea necesario
            fechaCampeonato: '',
          ));
        },
        tooltip: 'Agregar Equipo',
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteEquipo(BuildContext context, Equipo equipo) async {
    int result = await databaseHelper.deleteEquipo(equipo.id);
    if (result != 0) {
      _showSnackBar(context, 'Equipo eliminado exitosamente');
      refreshList();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetailScreen(Equipo equipo) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetalleEquipoScreen(equipo)),
    );

    if (result != null && result) {
      refreshList(); // Actualiza la lista después de guardar o editar el equipo
    }
  }
}
