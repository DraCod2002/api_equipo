class Equipo {
  int id;
  String nombreEquipo;
  int anioFundacion;
  String fechaCampeonato;

  Equipo({required this.id, required this.nombreEquipo, required this.anioFundacion, required this.fechaCampeonato});

  factory Equipo.fromMap(Map<String, dynamic> json) => Equipo(
        id: json['id'],
        nombreEquipo: json['nombreEquipo'],
        anioFundacion: json['anioFundacion'],
        fechaCampeonato: json['fechaCampeonato'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombreEquipo': nombreEquipo,
        'anioFundacion': anioFundacion,
        'fechaCampeonato': fechaCampeonato,
      };
}
