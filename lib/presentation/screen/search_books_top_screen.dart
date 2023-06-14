import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/core/extension/string_extension.dart';
import 'package:flutter_study/presentation/screen/webview_screen.dart';

class SearchBooksTopScreen extends StatefulWidget {
  const SearchBooksTopScreen({super.key});

  @override
  State<StatefulWidget> createState() => SearchBooksTopScreenState();
}

class SearchBooksTopScreenState extends State<SearchBooksTopScreen> {
  ScanResult? scanResult;

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('書籍検索'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera),
            tooltip: 'Scan',
            onPressed: () => _scan(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const ListTile(
                    title: Text('機能'),
                    subtitle: Text('ボタンをタップするとカメラが起動して\nISBNコードをスキャンできます'),
                  ),
                  if (scanResult != null)
                    Card(
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            title: Text('スキャン結果'),
                            subtitle: Text('以下はスキャン結果の詳細です'),
                          ),
                          ListTile(
                            title: const Text('結果種類'),
                            subtitle: Text(scanResult.type.toString()),
                          ),
                          ListTile(
                            title: const Text('内容'),
                            subtitle: Text(scanResult.rawContent),
                          ),
                          ListTile(
                            title: const Text('ISBN10'),
                            subtitle: Text(''
                                // scanResult.rawContent.toISBN10() ?? '変換できませんでした',
                                ),
                          ),
                          ListTile(
                            title: const Text('フォーマット'),
                            subtitle: Text(scanResult.format.toString()),
                          ),
                          ListTile(
                            title: const Text('備考'),
                            subtitle: Text(scanResult.formatNote),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scan(BuildContext context) async {
    try {
      final result = await BarcodeScanner.scan();

      if (result.rawContent.getDpParameter() == null) {
        if (!mounted) {
          return;
        }

        final snackBar = SnackBar(
          content: const Text('検索結果が存在しないか、コードが正しくないようです'),
          action: SnackBarAction(
            label: 'もう一度やり直す',
            onPressed: () => _scan(context),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      setState(() => scanResult = result);

      final isbn = result.rawContent.getDpParameter();

      if (!mounted) {
        return;
      }
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) =>
              WebViewScreen(url: 'https://www.amazon.co.jp/dp/$isbn'),
        ),
      );
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'ユーザはカメラを許可していない'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
