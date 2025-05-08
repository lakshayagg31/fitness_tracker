import 'package:flutter/material.dart';

class StatsChart extends StatelessWidget {
  final String period;

  StatsChart({required this.period});

  @override
  Widget build(BuildContext context) {
    // Mock data for the chart
    final List<Map<String, dynamic>> weekData = [
      {'day': 'Mon', 'steps': 8240, 'calories': 320},
      {'day': 'Tue', 'steps': 10456, 'calories': 420},
      {'day': 'Wed', 'steps': 7890, 'calories': 310},
      {'day': 'Thu', 'steps': 5670, 'calories': 210},
      {'day': 'Fri', 'steps': 9870, 'calories': 390},
      {'day': 'Sat', 'steps': 11240, 'calories': 450},
      {'day': 'Sun', 'steps': 6500, 'calories': 260},
    ];

    final List<Map<String, dynamic>> monthData = List.generate(30, (index) {
      return {
        'day': '${index + 1}',
        'steps': 5000 + (index % 7) * 1000 + (index % 3) * 500,
        'calories': 200 + (index % 7) * 40 + (index % 3) * 20,
      };
    });

    final List<Map<String, dynamic>> yearData = List.generate(12, (index) {
      return {
        'month':
            [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ][index],
        'steps': 150000 + (index % 4) * 50000 + (index % 3) * 25000,
        'calories': 6000 + (index % 4) * 2000 + (index % 3) * 1000,
      };
    });

    // Choose data based on period
    List<Map<String, dynamic>> data;
    String xAxisLabel;

    switch (period) {
      case 'Week':
        data = weekData;
        xAxisLabel = 'day';
        break;
      case 'Month':
        data = monthData;
        xAxisLabel = 'day';
        break;
      case 'Year':
        data = yearData;
        xAxisLabel = 'month';
        break;
      default:
        data = weekData;
        xAxisLabel = 'day';
    }

    return Column(
      children: [
        Container(
          height: 200,
          child: CustomPaint(
            size: Size.infinite,
            painter: ChartPainter(data: data, xAxisLabel: xAxisLabel),
          ),
        ),
      ],
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final String xAxisLabel;

  ChartPainter({required this.data, required this.xAxisLabel});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    final double padding = 40;
    final double graphWidth = size.width - (padding * 2);
    final double graphHeight = size.height - (padding * 2);

    // Find the maximum value in the data
    double maxValue = 0;
    for (var item in data) {
      if (item['steps'] > maxValue) {
        maxValue = item['steps'].toDouble();
      }
    }

    // Draw x and y axes
    final axesPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, size.height - padding),
      axesPaint,
    );

    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      axesPaint,
    );

    // Calculate x and y increments
    final double xIncrement = graphWidth / (data.length - 1);

    // Draw gridlines
    final gridPaint =
        Paint()
          ..color = Colors.grey.shade200
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < 5; i++) {
      final double y = padding + (i * graphHeight / 4);
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - padding, y),
        gridPaint,
      );
    }

    // Draw the data points and connect them with lines
    final path = Path();
    bool firstPoint = true;

    for (int i = 0; i < data.length; i++) {
      final double x = padding + (i * xIncrement);
      final double y =
          size.height - padding - ((data[i]['steps'] / maxValue) * graphHeight);

      // Draw point
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.blue);

      // Add point to path
      if (firstPoint) {
        path.moveTo(x, y);
        firstPoint = false;
      } else {
        path.lineTo(x, y);
      }

      // Draw x-axis labels
      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i][xAxisLabel],
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - (textPainter.width / 2), size.height - padding + 10),
      );
    }

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
