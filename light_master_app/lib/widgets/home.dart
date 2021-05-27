import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/add_light.dart';
import 'package:provider/provider.dart';

import 'card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Consumer<AppModel>(builder: (context, model, child) {
      return CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
              largeTitle: Text('Lights'),
              trailing: TextButton(
                child: Text("Add"),
                onPressed: () => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(35),
                          topRight: const Radius.circular(35))),
                  isScrollControlled: true,
                  context: context, builder: (BuildContext bc) => AddLight()
                  )
              )),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 2.0,
              mainAxisExtent: 200.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: ChangeNotifierProvider.value(
                      value: model.lightSources[index], child: LMCard()),
                );
              },
              childCount: model.lightSources.length,
            ),
          ),
        ],
      );
    }));
  }
}
