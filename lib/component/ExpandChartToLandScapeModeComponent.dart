import 'package:flutter/material.dart';
import 'package:mightyAdmin/component/HorizontalBarChart.dart';
import 'package:mightyAdmin/models/DashboardResponse.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class ExpandChartToLandScapeModeComponent extends StatefulWidget {
  List<SaleTotalData> seriesList;
  final bool? animate;

  ExpandChartToLandScapeModeComponent(this.seriesList, {this.animate});

  @override
  _ExpandChartToLandScapeModeComponentState createState() => _ExpandChartToLandScapeModeComponentState();
}

class _ExpandChartToLandScapeModeComponentState extends State<ExpandChartToLandScapeModeComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setOrientationLandscape();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setOrientationPortrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              HorizontalBarChart(widget.seriesList, chartType: ChartType.CHART3),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.crop_rotate_rounded,
                  ),
                  onPressed: () {
                    finish(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
