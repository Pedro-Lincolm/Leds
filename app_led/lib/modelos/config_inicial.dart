class ConfigInicial {
  String strBlueNome;

  ConfigInicial(this.strBlueNome);

  ConfigInicial.fromJson(Map<String, dynamic> pJson)
      : strBlueNome = pJson['BlueNome'] as String;

  Map<String, dynamic> toJson() => {'BlueNome': strBlueNome};
}
