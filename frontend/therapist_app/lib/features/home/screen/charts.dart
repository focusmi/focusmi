import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class BarChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 239, 251, 241)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 12, // Adjust the maximum y-axis value as needed
                gridData: FlGridData(
                  show: false,
                ),
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.white,
                    tooltipRoundedRadius: 10,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: false),
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    margin: 10,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Sun';
                        case 1:
                          return 'Mon';
                        case 2:
                          return 'Tue';
                        case 3:
                          return 'Wed';
                        case 4:
                          return 'Thu';
                        case 5:
                          return 'Fri';
                        case 6:
                          return 'Sat';
                        default:
                          return '';
                      }
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                axisTitleData: FlAxisTitleData(show: false),
      
                barGroups: getBarGroups(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            y: 4, // Value for Sunday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 6, // Value for Monday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 8, // Value for Tuesday
           colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 5, // Value for Wednesday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            y: 9, // Value for Thursday
           colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            y: 7, // Value for Friday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            y: 3, // Value for Saturday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
    ];
  }
}

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 239, 251, 241)
        ),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
             Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: Colors.blue,
                  text: 'First',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.yellow,
                  text: 'Second',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.purple,
                  text: 'Third',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.green,
                  text: 'Fourth',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: Colors.green,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}