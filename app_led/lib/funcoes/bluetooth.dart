import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

final _bluetooth = FlutterBluetoothSerial.instance;
BluetoothConnection? _connection;

void PedirPermissoes() async {
  await Permission.bluetooth.request();
  await Permission.bluetoothScan.request();
  await Permission.bluetoothConnect.request();
}

Future<List<BluetoothDevice>> BuscaDispositivos() async {
  var res = await _bluetooth.getBondedDevices();
  return res;
}

void sendData(String data) {
  if (_connection?.isConnected ?? false) {
    _connection?.output.add(ascii.encode(data));
  }
}

Future<bool> ConectarBlue(String pEndereco) async {
  try {
    _connection = await BluetoothConnection.toAddress(pEndereco);
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> EncerrarConecxao() async {
  await _connection?.finish();
}
