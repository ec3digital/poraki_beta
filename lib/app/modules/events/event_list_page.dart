import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poraki/app/data/models/evento.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/events/event_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';

class EventsListPage extends StatefulWidget {

  EventsListPage({Key? key}) : super(key: key);

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  final HomeController controller = Get.find();
  List<Evento> evtList = [];

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final EventController _eventController = Get.put(EventController());
    final Color colorText = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    Future<void> pegaEventos() async {
      evtList = await _eventController.retornaEventos();
    }

    Widget _buildRow(Evento evento) {
      if (evento.EventoUID == _loginController.usuGuid)
        return ListTile(
          trailing: GestureDetector(onTap: () async {
            await _eventController.apagaEvento(evento);
            var tempEvtList = await _eventController.retornaEventos();
            setState(() {
              evtList = tempEvtList;
            });

          },
            child: Badge(
                backgroundColor: Colors.red,
                label: Text(' X '),
                textStyle: TextStyle(fontSize: 18),
                smallSize: 22,
                largeSize: 24),
          ),
          leading: Icon(Icons.calendar_today_outlined),
          title: Text(evento.EventoNome.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, color: colorText, fontWeight: FontWeight.w900)
              ),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Text(
              evento.EventoDetalhes.toString(),
              style: TextStyle(fontSize: 16, color: colorText),
            ),
            const SizedBox(height: 20),
            Text(
              'Data do evento: ' +
                  DateFormat("dd/MM/yyyy").format(evento.EventoData!) +
                  ' às ' +
                  evento.EventoHora.toString(),
              style: TextStyle(fontSize: 16, color: colorText),
            ),
            // Text('Data do evento: ' + evento.EventoData.toString()),
            const SizedBox(height: 20),

            FullScreenWidget(
              disposeLevel: DisposeLevel.Medium,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/eventos%2F' +
                          evento.EventoGUID.toString() +
                          '.jpg?alt=media',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Text(""),
                  //height: 110,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ]),
        );
      else
        return ListTile(
          leading: Icon(Icons.calendar_today_outlined),
          //trailing: Text(noticia.NoticiaPor.toString()),
          title: Text(evento.EventoNome.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, color: colorText, fontWeight: FontWeight.w900)
              // style: _biggerFont,
              ),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Text(
              evento.EventoDetalhes.toString(),
              style: TextStyle(fontSize: 16, color: colorText),
            ),
            const SizedBox(height: 20),
            Text(
              'Data do evento: ' +
                  DateFormat("dd/MM/yyyy").format(evento.EventoData!) +
                  ' às ' +
                  evento.EventoHora.toString(),
              style: TextStyle(fontSize: 16, color: colorText),
            ),
            // Text('Data do evento: ' + evento.EventoData.toString()),
            const SizedBox(height: 20),

            FullScreenWidget(
              disposeLevel: DisposeLevel.Medium,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/eventos%2F' +
                          evento.EventoGUID.toString() +
                          '.jpg?alt=media',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Text(""),
                  //height: 110,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ]),
        );
    }

    return FutureBuilder(
        future: pegaEventos(),
        builder: (context, futuro) {
          if (futuro.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator(backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString())));
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  ButtonOffer(
                      onPressed: () {
                        Get.toNamed(AppRoutes.newEvent);
                      },
                      colorText: _loginController.colorFromHex(_loginController
                          .listCore
                          .where(
                              (coreItem) => coreItem.coreChave == 'textLight')
                          .first
                          .coreValor
                          .toString()),
                      text: 'Publicar evento',
                      colorButton: _loginController.colorFromHex(
                          _loginController.listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'textDark')
                              .first
                              .coreValor
                              .toString())),
                  const SizedBox(height: 10),
                  Center(
                      child: Text(
                    "Eventos da Região",
                    style: TextStyle(fontSize: 26),
                  )),
                  const SizedBox(height: 10),
                  if (evtList.length == 0)
                    Container(
                        child: Center(
                            child: Text(
                                "Ops, nenhum evento poraki agora... ;-)",
                                style: TextStyle(fontSize: 16))))
                  else
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(6.0),
                          itemCount: evtList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: backColor,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: backColor,
                                ),
                                child:
                                    _buildRow(evtList[index]));
                          }),
                    ))
                ]
                //)
                );
          }
        });
  }
}
