/// Horizontal bar chart example
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mightyAdmin/models/DashboardResponse.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum ChartType { CHART1, CHART2, CHART3 }

// ignore: must_be_immutable
class HorizontalBarChart extends StatelessWidget {
  List<SaleTotalData> seriesList;
  final ChartType chartType;

  HorizontalBarChart(this.seriesList, {this.chartType = ChartType.CHART3});

  final List<SaleTotalData> data = [];

  List<ChartSeries> getChartsOnType(ChartType chartType) {
    switch (chartType) {
      case ChartType.CHART1:
        return getDefaultData();
      case ChartType.CHART2:
        return getDefaultData2();
      case ChartType.CHART3:
        return getDefaultData3();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: Legend(isVisible: true),
      series: getChartsOnType(chartType),
      selectionType: SelectionType.series,
      primaryXAxis: CategoryAxis(
        interval: 1,
        axisLine: AxisLine(color: primaryColor),
      ),
      enableAxisAnimation: true,
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ChartSeries> getDefaultData() {
    final List<SaleTotalData> chartData = [];
    seriesList.forEach((element) {
      if (element.sales != '0.00') {
        chartData.add(SaleTotalData(key: element.key, sales: element.sales));
      }
    });

    return <ChartSeries>[
      SplineSeries<SaleTotalData, String>(
        dataSource: chartData,
        splineType: SplineType.cardinal,
        cardinalSplineTension: 0.9,
        enableTooltip: true,
        width: 2,
        isVisibleInLegend: false,
        pointColorMapper: (SaleTotalData data, _) => Colors.green,
        dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
        markerSettings: MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.black),
        xValueMapper: (SaleTotalData sales, _) => DateFormat('dd/MMM').format(DateTime.parse(sales.key!)),
        yValueMapper: (SaleTotalData sales, _) => double.parse(sales.sales!),
      )
    ];
  }

  List<ChartSeries> getDefaultData2() {
    final List<SaleTotalData> chartData = [];
    seriesList.forEach((element) {
      if (element.sales != '0.00') {
        chartData.add(SaleTotalData(key: element.key, sales: element.sales));
      }
    });

    return <CartesianSeries>[
      AreaSeries<SaleTotalData, String>(
          dataSource: chartData,
          // Type of spline
          enableTooltip: true,
          isVisibleInLegend: false,
          borderWidth: 2,
          borderDrawMode: BorderDrawMode.all,
          animationDuration: 1000,
          /* gradient: LinearGradient(
            colors: <Color>[Color.fromRGBO(230, 0, 180, 1), Color.fromRGBO(255, 200, 0, 1)],
            stops: <double>[0.2, 0.9],
          ),*/
          borderGradient: const LinearGradient(colors: <Color>[Color.fromRGBO(230, 0, 180, 1), Color.fromRGBO(255, 200, 0, 1)], stops: <double>[0.2, 0.9], tileMode: TileMode.decal),
          pointColorMapper: (SaleTotalData data, _) => Colors.green,
          dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
          markerSettings: MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.black),
          xValueMapper: (SaleTotalData sales, _) => DateFormat('dd/MM').format(DateTime.parse(sales.key!)),
          yValueMapper: (SaleTotalData sales, _) => double.parse(sales.sales!),
          emptyPointSettings: EmptyPointSettings(
              // Mode of empty point
              mode: EmptyPointMode.average))
    ];
  }

  List<ChartSeries> getDefaultData3() {
    final List<SaleTotalData> chartData = [];
    seriesList.forEach((element) {
      if (element.sales != '0.00') {
        chartData.add(SaleTotalData(key: element.key, sales: element.sales));
      }
    });

    return <ChartSeries>[
      SplineAreaSeries<SaleTotalData, String>(
          dataSource: chartData,
          // Type of spline
          enableTooltip: true,
          isVisibleInLegend: false,
          borderWidth: 4,
          gradient: LinearGradient(
            colors: <Color>[Colors.white, primaryColor],
            stops: <double>[0.03, 0.9],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
          borderColor: primaryColor,
          borderDrawMode: BorderDrawMode.all,
          animationDuration: 1000,
          dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
          markerSettings: MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.black),
          xValueMapper: (SaleTotalData sales, _) => DateFormat('dd/MMM').format(DateTime.parse(sales.key!)),
          yValueMapper: (SaleTotalData sales, _) => double.parse(sales.sales!),
          emptyPointSettings: EmptyPointSettings(
              // Mode of empty point
              mode: EmptyPointMode.average))
    ];
  }
}
