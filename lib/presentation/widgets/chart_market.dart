import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartMarket extends StatefulWidget {
  final IconData logo;
  final String name;
  final String description;
  final double value;
  final double valueUsd;
  final double priceDif; // Thêm tham số priceDif
  final List<dynamic>? prices; // Để xử lý dữ liệu không xác định
  final bool showBorder;

  const ChartMarket({
    required this.logo,
    required this.name,
    required this.description,
    required this.value,
    required this.valueUsd,
    required this.priceDif, // Nhận priceDif từ widget
    this.prices, // Giá được truyền dưới dạng danh sách
    this.showBorder = true,
    super.key,
  });

  @override
  State<ChartMarket> createState() => _ChartMarketState();
}

class _ChartMarketState extends State<ChartMarket> {
  late List<FlSpot> chartData;

  final NumberFormat vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  final NumberFormat usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  @override
  void initState() {
    super.initState();

    if(widget.prices == null) {
      chartData = getChartDataFromPrices([0, 0]);
    } else if(widget.prices!.isEmpty) {
      chartData = getChartDataFromPrices([0, 0]);
    } else {
      chartData = getChartDataFromPrices(widget.prices!);
    }
  }

  @override
  void didUpdateWidget(covariant ChartMarket oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.prices != widget.prices) {
      setState(() {
        chartData = getChartDataFromPrices(widget.prices ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color priceDifColor = widget.priceDif > 0
        ? Colors.green
        : widget.priceDif < 0
            ? Colors.red
            : Colors.green;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      decoration: BoxDecoration(
        border: widget.showBorder
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(widget.logo, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                '${widget.priceDif >= 0 ? '↑' : '↓'} ${widget.priceDif.toStringAsFixed(3)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: priceDifColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vndFormat.format(widget.value),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      usdFormat.format(widget.valueUsd),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 0),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: chartData,
                            isCurved: true,
                            color: priceDifColor,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                        titlesData: const FlTitlesData(show: false),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<FlSpot> getChartDataFromPrices(List<dynamic> prices) {
    return List<FlSpot>.generate(
      prices.length,
      (index) {
        final price = prices[index];
        if (price is num) {
          return FlSpot(index.toDouble(), price.toDouble());
        } else {
          return FlSpot(index.toDouble(), 0);
        }
      },
    );
  }
}
