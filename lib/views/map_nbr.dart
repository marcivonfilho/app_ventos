// ignore_for_file: library_private_types_in_public_api, camel_case_types, avoid_print, use_rethrow_when_possible, deprecated_member_use, prefer_const_constructors, prefer_conditional_assignment, unnecessary_null_comparison

import 'package:app_ventos/keys/key.dart';
import 'package:app_ventos/views/Drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class mapNBR extends StatefulWidget {
  const mapNBR({super.key});

  @override
  _MapNBRState createState() => _MapNBRState();
}

class _MapNBRState extends State<mapNBR> {
  @override
  void initState() {
    super.initState();
    // Certifique-se de que a inicialização do WebView ocorre apenas uma vez
    if (WebView.platform == null) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa Isopletas NBR',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body: WebView(
        initialUrl: '$key_server/html_isopleta?map_type=isopleta_nbr',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // Configurações adicionais do WebView, se necessário
        },
        onPageStarted: (String url) {
          print('Página começou a carregar: $url');
        },
        onPageFinished: (String url) {
          print('Página terminou de carregar: $url');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
