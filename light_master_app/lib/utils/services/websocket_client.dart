import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketApiClient {
  var _websocketClient;
  var _multiStream;
  var _stateStream;
  var _infoStream;

  WebsocketApiClient({
    String baseUrl,
  }) {
    _websocketClient = IOWebSocketChannel.connect('ws://$baseUrl/ws');

    _multiStream = StreamSplitter(_websocketClient.stream.transform(
        StreamTransformer<String, dynamic>.fromHandlers(
            handleData: (String value, EventSink<dynamic> sink) {
      sink.add(jsonDecode(value));
    })));
    _stateStream = _multiStream.split().transform(
        StreamTransformer<dynamic, dynamic>.fromHandlers(
            handleData: (dynamic value, EventSink<dynamic> sink) {
      sink.add(value['state']);
    })).asBroadcastStream();
    _infoStream = _multiStream.split().transform(
        StreamTransformer<dynamic, dynamic>.fromHandlers(
            handleData: (dynamic value, EventSink<dynamic> sink) {
      sink.add(value['info']);
    })).asBroadcastStream();
  }

  void close() {
    _multiStream.close();
  }

  Stream get stateStream => _stateStream;
  Stream get infoStream => _infoStream;
}
