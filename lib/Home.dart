import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _ControllerCep = TextEditingController();

  String _resultado = "Resultado";

  _cep() async {

    String cep = _ControllerCep.text;

    print(_ControllerCep.text);
    Uri url = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];

    if (complemento.isEmpty) {
      complemento = "Não informado";
    }
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      _resultado = "UF: $uf\nLogradouro: $logradouro\nComplemento: $complemento\nBairro: $bairro\nLocalidade: $localidade";
    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    double a = (height / 1.6180339);

    double b = height - a;

    double c = (b / 1.6180339);

    double d = b - c;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(

        ),
        toolbarHeight: d,
        centerTitle: true,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff000000), Colors.white30]),
          ),
        ),
        title: const Text(
          "Consumo de serviço web",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(40),
        color: Colors.white,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _ControllerCep,
              style: const TextStyle(
                fontSize: 25,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex: 45820625"
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                _resultado,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: _cep,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
                child: const Text(
                  "Resultado",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
