import 'dart:io';
import 'dart:convert';
import 'package:app_led/modelos/config_inicial.dart';
import 'package:path_provider/path_provider.dart';

Future<ConfigInicial> CriaInstancia() async {
  return await VerificaArquivo()
      ? ConfigInicial.fromJson(
          jsonDecode(await LerAquivo()) as Map<String, dynamic>)
      : ConfigInicial('');
}

Future<bool> VerificaArquivo() async {
  final String strCaminho = await BuscarCaminho();
  bool booll = await File('${strCaminho}/config.json').exists();

  return booll;
}

Future<String> BuscarCaminho() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future SalvarArquivo(String pArquivo) async {
  final String strCaminho = await BuscarCaminho();

  File objArquivo = File('$strCaminho/config.json');

  await objArquivo.writeAsString(pArquivo);
}

Future<String> LerAquivo() async {
  String strText = '';
  try {
    final String strCaminho = await BuscarCaminho();
    final File file = File('$strCaminho/config.json');
    strText = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return strText;
}
