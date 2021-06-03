import 'dart:async';
import 'dart:developer';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';
import 'package:http/http.dart' as http;

/// Provider model that allows to handle Bonsoir discoveries.
class WLEDDiscoveryModel extends ChangeNotifier {
  final WledRestClient wled = WledRestClient(httpClient: http.Client());
  static const String type = '_http._tcp';
  final _controller = StreamController<List<LightSource>>();

  /// The current Bonsoir discovery object instance.
  BonsoirDiscovery _bonsoirDiscovery;

  /// Contains all discovered (and resolved) services.
  final List<LightSource> _resolvedServices = [];

  /// The subscription object.
  StreamSubscription<BonsoirDiscoveryEvent> _subscription;

  /// Creates a new Bonsoir discovery model instance.
  WLEDDiscoveryModel() {
    start();
  }

  /// Returns all discovered (and resolved) services.
  List<LightSource> get discoveredServices => List.of(_resolvedServices);

  Stream<List<LightSource>> get discoverWLEDDevices => _controller.stream;

  /// Starts the Bonsoir discovery.
  Future<void> start() async {
    if (_bonsoirDiscovery == null || _bonsoirDiscovery.isStopped) {
      _bonsoirDiscovery = BonsoirDiscovery(type: type);
      await _bonsoirDiscovery.ready;
    }

    await _bonsoirDiscovery.start();
    _subscription = _bonsoirDiscovery.eventStream.listen(_onEventOccurred);
  }

  /// Stops the Bonsoir discovery.
  void stop() {
    _subscription?.cancel();
    _subscription = null;
    _bonsoirDiscovery?.stop();
  }

  /// Triggered when a Bonsoir discovery event occurred.
  Future<void> _onEventOccurred(BonsoirDiscoveryEvent event) async {
    if (event.service == null || !event.isServiceResolved) {
      return;
    }

    if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_RESOLVED) {
      ResolvedBonsoirService service = event.service;
      try {
        var state = await wled.fetchState(service.ip);
        var mainseg = state['state']['seg'][state['state']['mainseg']];
        final light = LightSource(
            service.ip,
            state['info']['name'],
            state['state']['on'],
            mainseg['fx'] == 0
                ? SolidLight(Color.fromRGBO(mainseg['col'][0][0],
                    mainseg['col'][0][1], mainseg['col'][0][2], 1))
                : EffectLight(mainseg['fx'], mainseg['bri'], mainseg['sx']));
        _resolvedServices.add(light);
        notifyListeners();
        _controller.sink.add(_resolvedServices);
      } catch (e) {
        log("$service is not a WLED-Instance");
      }
    }
  }

  @override
  void dispose() {
    stop();
    _controller.close();
    super.dispose();
  }
}
