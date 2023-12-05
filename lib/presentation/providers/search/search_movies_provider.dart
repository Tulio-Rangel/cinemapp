import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Estado del query de la busqueda
final searchQueryProvider = StateProvider<String>((ref) => '');
