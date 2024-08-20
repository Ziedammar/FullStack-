import 'package:d_chart/d_chart.dart';
import 'package:eshop/Model/Commande_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Controller/Commande_Controller.dart';
class Statistique extends StatefulWidget {
  const Statistique({Key? key}) : super(key: key);
  static Map<String, dynamic> sumByDomain = {};

  @override
  State<Statistique> createState() => _StatistiqueState();

}

class _StatistiqueState extends State<Statistique> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Statistique.sumByDomain={};
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<CommandeController>(
        init: CommandeController(),
        builder: (value){
          return FutureBuilder<List<Commande>>(
            future: value.getAllCmd(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                print("${snapshot.error}");

                return Text('error');}
              else if (snapshot. hasData){
                final cmd = snapshot.data!;
                print('this is cmd $cmd');



                for (var e in cmd) {
                  if (Statistique.sumByDomain.containsKey(e.user)) {
                    Statistique.sumByDomain[e.user] += e.prix;
                  } else {
                    Statistique.sumByDomain[e.user] = e.prix;
                  }
                  print('sumByDomain: ${Statistique.sumByDomain}');
                }

                return DChartBar(
                  data: [
                    {
                      'id': 'Bar',
                      'data': [
                        for (var entry in Statistique.sumByDomain.entries)
                          { 'measure': entry.value ,'domain': entry.key},
                      ],
                    },
                  ],

                  yAxisTitle: "User",
                  xAxisTitle: "Chifre D'affaires",
                  measureMin: 0,
                  minimumPaddingBetweenLabel: 1,
                  domainLabelPaddingToAxisLine: 16,
                  axisLineTick: 2,
                  axisLinePointTick: 2,
                  axisLinePointWidth: 10,
                  axisLineColor: Colors.green,
                  measureLabelPaddingToAxisLine: 16,
                  verticalDirection: false,
                  barColor: (barData, index, id) => barData['measure'] >= 1000
                      ? Colors.green.shade300
                      : Colors.green.shade700,
                  barValue: (barData, index) => '${barData['measure']}',
                  showBarValue: true,
                  barValuePosition: BarValuePosition.outside,
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },);
        });
  }
}
