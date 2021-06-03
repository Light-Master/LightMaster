import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:http/http.dart' as http;

Stream<LightSource> discoverWLEDDevices() async* {
  const String name = '_http._tcp';
  final MDnsClient client = MDnsClient();
  final WledRestClient wled = WledRestClient(httpClient: http.Client());

  // Start the client with default options.
  await client.start();
  await for (final PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      await for (final IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target))) {
        try {
          var state = await wled.fetchState(ip.address.address);
          var mainseg = state['state']['seg'][state['state']['mainseg']];
          yield LightSource(
              ip.address.address,
              state['info']['name'],
              state['state']['on'],
              mainseg['fx'] == 0
                  ? SolidLight(Color.fromRGBO(mainseg['col'][0],
                      mainseg['col'][1], mainseg['col'][2], 1))
                  : EffectLight(mainseg['fx'], mainseg['bri'], mainseg['sx']));
        } catch (e) {
          log("${srv.name} is not a WLED-Instance");
        }
      }
      await for (final IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv6(srv.target))) {
        try {
          var state = await wled.fetchState(ip.address.address);
          var mainseg = state['state']['seg'][state['state']['mainseg']];
          yield LightSource(
              ip.address.address,
              state['info']['name'],
              state['state']['on'],
              mainseg['fx'] == 0
                  ? SolidLight(Color.fromRGBO(mainseg['col'][0],
                      mainseg['col'][1], mainseg['col'][2], 1))
                  : EffectLight(
                      mainseg['fx'], state['info']['bri'], mainseg['sx']));
        } catch (e) {
          log("${srv.name} is not a WLED-Instance");
        }
      }
    }
  }
  client.stop();
}
