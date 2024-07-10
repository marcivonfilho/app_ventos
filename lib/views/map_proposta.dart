// ignore_for_file: depend_on_referenced_packages, camel_case_types, library_private_types_in_public_api, avoid_print, use_rethrow_when_possible, prefer_const_constructors, unnecessary_brace_in_string_interps, prefer_conditional_assignment, unnecessary_null_comparison

import 'package:app_ventos/keys/key.dart';
import 'package:app_ventos/views/Drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class mapPROP extends StatefulWidget {
  const mapPROP({super.key});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<mapPROP> {
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
          'Mapa Isopletas Proposta',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body: WebView(
        initialUrl: '$key_server/html_isopleta?map_type=isopleta_prop',
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
