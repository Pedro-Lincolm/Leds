import 'dart:convert';
import 'package:app_led/funcoes/bluetooth.dart';
import 'package:app_led/funcoes/save_file.dart';
import 'package:app_led/modelos/config_inicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool _isConnecting = false;
  bool? _connection;
  List<BluetoothDevice> _devices = [];
  // ignore: unused_field
  BluetoothDevice? _deviceConnected;
  String strMensagem = '';

  late ConfigInicial objClasse;

  @override
  void initState() {
    super.initState();

    PedirPermissoes();

    CriaInstancia().then((value) {
      objClasse = value;

      if (objClasse.strBlueNome.isNotEmpty) {
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Conectando ao dispositivo paddrão"),
            ),
          );
          ConectarBlue(objClasse.strBlueNome).then((value) {
            _connection = value;

            setState(() {});

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Bluetooth conectado!"),
              ),
            );
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Não foi possivel conectar ao dispositivo"),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Leds'),
        actions: [
          IconButton(
              onPressed: () => sendData('a'),
              icon: const Icon(Icons.power_settings_new)),
          IconButton(
              onPressed: () async {
                bool con = _connection ?? false;
                if (con) {
                  //await _connection?.finish();
                  await EncerrarConecxao();
                  _connection = false;
                  setState(() {
                    _deviceConnected = null;
                  });
                } else {
                  _devices = await BuscaDispositivos();
                  setState(() {});
                }
              },
              icon: Icon(
                Icons.bluetooth,
                color: _connection ?? false ? Colors.red : null,
              ))
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _listDevices(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.red,
                  onPressed: () {
                    sendData('A');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.green,
                  onPressed: () {
                    sendData('B');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.blue,
                  onPressed: () {
                    sendData('C');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    sendData('D');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.yellow,
                  onPressed: () {
                    sendData('E');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.purple,
                  onPressed: () {
                    sendData('F');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  iconSize: 40,
                  color: Colors.pink,
                  onPressed: () async {
                    sendData('G');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () {
                            setState(() => _isConnecting = true);
                            try {
                              ConectarBlue(device.address)
                                  .then((value) => _connection = value);
                              _deviceConnected = device;
                              _devices = [];
                              _isConnecting = false;
                              _connection = true;

                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Bluetooth conectado!"),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Não foi possivel conectar ao dispositivo!"),
                                ),
                              );
                              setState(() {
                                _isConnecting = false;
                              });
                            }
                          },
                          onLongPress: () async {
                            objClasse.strBlueNome = device.address;
                            SalvarArquivo(jsonEncode(objClasse));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Dispisitovo selecionado como padrão"),
                              ),
                            );
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }
}
