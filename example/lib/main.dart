import 'dart:io';

import 'package:dio/dio.dart';
import 'package:epub_viewer_bookmcface/epub_viewer_bookmcface.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";

  final plugin = EpubViewerBookmcface();

  @override
  void initState() {
    download();
    super.initState();
  }

  Future<void> download() async {
    await startDownload();
    final PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status == PermissionStatus.granted) {
      await startDownload();
    } else {
      await Permission.manageExternalStorage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('E-pub Example'),
        ),
        body: Center(
          child: loading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Downloading.... E-pub'),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: download,
                      child: const Text('Download epub'),
                    ),
                    ElevatedButton(
                      onPressed: filePath.isEmpty ? null : showViewer,
                      child: const Text('Open epub'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void showViewer() {
    // plugin.openViewer(
    //     "/storage/emulated/0/Download/02. Those-who-accuse-you.epub");
    plugin.openViewer(filePath);
  }

  Future<void> startDownload() async {
    setState(() {
      loading = true;
    });
    Directory? appDocDir = Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir.path}/sample2.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        "https://firebasestorage.googleapis.com/v0/b/dag-bible.appspot.com/o/books%2F19.%20Transform-your-pastoral-ministry.epub?alt=media&token=ca53d0b4-fbb3-4855-92fc-9f83d4a3ddf9",
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('Download --- ${(receivedBytes / totalBytes) * 100}');
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }
}
