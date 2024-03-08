
#include <Arduino.h>
#include <SoftwareSerial.h> //Biblioteca para conectar com o bluetooth (já vem instalado), não precisa baixar

SoftwareSerial serialdobluetooth(3,2); // Portas para o serial do bluetooth (RX, TX)

#define Red 9
#define Blue 10
#define Green 11

void DefineCor(char letra);

int r,g,b = 0;
char valordobluetooth;

void setup() {
  serialdobluetooth.begin(9600); //Início da serial do bluetooth
  pinMode(Red, OUTPUT);
  pinMode(Blue, OUTPUT);
  pinMode(Green, OUTPUT);

}

void loop() {

  if (serialdobluetooth.available()) //Se o bluetooth estiver funcionando, vai ser lido o "valor", para reproduzir o comando
  {
    valordobluetooth = serialdobluetooth.read();

    DefineCor(valordobluetooth);
  }

}

void DefineCor(char letra)
{
  switch (letra)
  {
    case 'a':
    r = 0;
    g = 0;
    b = 0;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  // Vermelho
  case 'A':
    r = 255;
    g = 0;
    b = 0;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  // Verde
  case 'B':
    r = 0;
    g = 255;
    b = 0;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  // Azul
  case 'C':
    r = 0;
    g = 0;
    b = 255;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  // Branco
  case 'D':
    r = 255;
    g = 255;
    b = 255;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  // Amarelo
  case 'E':
    r = 255;
    g = 255;
    b = 0;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, 0);
    break;
  // Roxo
    case 'F':
    r = 128;
    g = 0;
    b = 128;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  // Rosa
  case 'G':
    r = 255;
    g = 0;
    b = 255;
    analogWrite(Red, r);  
    analogWrite(Green, g);
    analogWrite(Blue, b);
    break;
  }
  
}