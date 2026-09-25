// ignore_for_file: avoid_print
import 'dart:io';

Future<void> main(List<String> args) async {
  final port = args.isNotEmpty ? int.parse(args[0]) : 8765;
  final dir = Directory('example/build/web');
  if (!dir.existsSync()) {
    stderr.writeln('Build directory does not exist: ${dir.path}');
    exit(1);
  }

  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  print('SERVER_READY on http://localhost:$port');

  await for (final request in server) {
    var path = request.uri.path;
    if (path == '/' || path.isEmpty) {
      path = '/index.html';
    }

    final file = File('${dir.path}$path');
    if (await file.exists()) {
      _setContentType(request.response, file.path);
      await file.openRead().pipe(request.response);
    } else {
      // Fallback for single page routing
      final indexFile = File('${dir.path}/index.html');
      if (await indexFile.exists()) {
        _setContentType(request.response, 'index.html');
        await indexFile.openRead().pipe(request.response);
      } else {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
      }
    }
  }
}

void _setContentType(HttpResponse response, String path) {
  if (path.endsWith('.html')) {
    response.headers.contentType = ContentType.html;
  } else if (path.endsWith('.js') || path.endsWith('.mjs')) {
    response.headers.contentType = ContentType('application', 'javascript');
  } else if (path.endsWith('.wasm')) {
    response.headers.contentType = ContentType('application', 'wasm');
  } else if (path.endsWith('.json')) {
    response.headers.contentType = ContentType.json;
  } else if (path.endsWith('.css')) {
    response.headers.contentType = ContentType('text', 'css');
  } else if (path.endsWith('.png')) {
    response.headers.contentType = ContentType('image', 'png');
  } else if (path.endsWith('.otf') || path.endsWith('.ttf')) {
    response.headers.contentType = ContentType('font', 'ttf');
  }
}
