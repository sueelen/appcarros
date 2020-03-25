import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/dart/nav.dart';
import 'package:flutter/material.dart';
import 'carros_api.dart';

// ignore: must_be_immutable
class CarrosListView extends StatelessWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Carro>> future = CarrosApi.getCarros(tipo);

    return FutureBuilder(
      // ignore: missing_return
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível buscar os carros",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _ListView(carros);
      },
    );
  }

  // ignore: non_constant_identifier_names
  Container _ListView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];
            return Card(
              color: Colors.grey[140],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Image.network(
                      c.urlFoto ??
                          "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Eldorado.png",
                      width: 270,
                    )),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "descrição...",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18),
                    ),
                    ButtonBarTheme(
                      data: ButtonBarTheme.of(context),
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                              child: const Text('DETALHES'),
                              onPressed: () => _onClickCarro(context, c)),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
  _onClickCarro(context,Carro c) {
    push(context, CarroPage(c));
  }
}