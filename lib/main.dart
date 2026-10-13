import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const FnOPulse());

class FnOPulse extends StatelessWidget {
  const FnOPulse({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FnO Pulse', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0C1527),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF34D6C1),
        brightness: Brightness.dark)),
    home: const MarketShell(),
  );
}

class MarketShell extends StatefulWidget {
  const MarketShell({super.key});
  @override
  State<MarketShell> createState() => _MarketShellState();
}

class _MarketShellState extends State<MarketShell> {
  int tab = 0;
  String symbol = 'NIFTY';
  final Set<String> watch = {'NIFTY', 'SENSEX'};
  static const symbols = ['NIFTY', 'SENSEX', 'BANKNIFTY', 'DIXON', 'TCS', 'TITAN'];
  static const pages = ['Home', 'Charts', 'Options', 'News', 'Watchlist', 'Settings'];
  static const icons = [Icons.dashboard_outlined, Icons.show_chart,
    Icons.table_chart_outlined, Icons.article_outlined, Icons.star_outline,
    Icons.settings_outlined];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('✦ FnO Pulse', style:
      TextStyle(fontWeight: FontWeight.w800)),
      actions: const [Padding(padding: EdgeInsets.all(15),
        child: Center(child: Text('DEMO', style: TextStyle(
        color: Color(0xFFFFD080), fontWeight: FontWeight.bold))))]),
    body: Column(children: [
      Container(width: double.infinity, color: const Color(0xFF3D3020),
        padding: const EdgeInsets.all(10), child: const Text(
        'DEMO ONLY • Not live market data • Orders disabled',
        style: TextStyle(color: Color(0xFFFFD080), fontSize: 12))),
      Expanded(child: SingleChildScrollView(
        padding: const EdgeInsets.all(16), child: _page())),
    ]),
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab, height: 78,
      onDestinationSelected: (i) => setState(() => tab = i),
      destinations: [
        for (int i = 0; i < pages.length; i++)
          NavigationDestination(icon: Icon(icons[i]), label: pages[i]),
      ],
    ),
  );

  Widget _title(String title, String caption) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
      const SizedBox(height: 6), Text(caption,
        style: const TextStyle(color: Colors.white60)),
    ]));
  Widget _tile(String heading, String detail, IconData icon) => Card(
    color: const Color(0xFF17243B),
    child: Padding(padding: const EdgeInsets.all(17), child: Row(children: [
      Icon(icon, color: const Color(0xFF35D6C1)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(heading, style: const TextStyle(fontWeight:
          FontWeight.bold, fontSize: 16)), const SizedBox(height: 8),
          Text(detail, style: const TextStyle(color: Colors.white70))])),
    ])));
  Widget _page() {
    switch (tab) {
      case 0:
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _title('Market intelligence', 'Indian F&O research • safe demo'),
          _tile('NIFTY • 25,100', 'Illustrative sample, not an exchange quote', Icons.trending_up),
          _tile('SENSEX • 82,000', 'Illustrative sample, not an exchange quote', Icons.trending_down),
          _tile('Research discipline', 'Check real quotes, spread, volatility and liquidity before decisions', Icons.shield_outlined),
          _tile('No orders', 'This version never places trades', Icons.lock_outline),
        ]);
      case 1:
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _title('Price charts', 'Synthetic data, not historical candles'),
          DropdownButtonFormField<String>(initialValue: symbol,
            decoration: const InputDecoration(border: OutlineInputBorder(),
              labelText: 'Instrument'),
            items: [for (final s in symbols) DropdownMenuItem(value: s, child: Text(s))],
            onChanged: (v) => setState(() => symbol = v ?? 'NIFTY')),
          const SizedBox(height: 12),
          SizedBox(height: 230, child: Card(
            color: const Color(0xFF17243B),
            child: CustomPaint(painter: DemoPlot(),
              child: const Center(child: Text('SYNTHETIC DEMO CHART',
                style: TextStyle(color: Colors.white30)))))),
          _tile('RSI • DEMO', 'Sample 52.6  •  No trading signal', Icons.analytics_outlined),
          _tile('SMA20/50 • DEMO', 'Indicators require authenticated real market history',
            Icons.show_chart),
        ]);
      case 2:
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _title('Option chain', 'Illustrative premiums only'),
          _tile('PCR unavailable', 'Verified OI, correct expiry and full contract mapping required', Icons.shield),
          Card(child: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: DataTable(columns: const [
              DataColumn(label: Text('CALL demo')),
              DataColumn(label: Text('Strike')),
              DataColumn(label: Text('PUT demo')),
            ], rows: [for (int i = 0; i < 7; i++) DataRow(cells: [
              DataCell(Text((240 - i * 15).toString())),
              DataCell(Text((24800 + i * 100).toString())),
              DataCell(Text((50 + i * 20).toString())),
            ])]))),
        ]);
      case 3:
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _title('News & research', 'Educational offline reference, not breaking news'),
          _tile('Volatility matters', 'Option value depends on more than index direction', Icons.school_outlined),
          _tile('Verify sources', 'Official exchange data and current event calendars are required', Icons.fact_check_outlined),
          _tile('News unavailable', 'No authorized live news feed is connected', Icons.cloud_off_outlined),
        ]);
      case 4:
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _title('Watchlist', 'Local demo choices'),
          for (final s in symbols) Card(child: CheckboxListTile(
            title: Text(s), subtitle: const Text('No verified live quote'),
            value: watch.contains(s), onChanged: (v) => setState(() {
              if (v == true) { watch.add(s); } else { watch.remove(s); }
            }))),
        ]);
      default:
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _title('Settings', 'Transparency and responsible market research'),
          _tile('Data source: DEMO', 'Authenticated broker connection not configured', Icons.cloud_off),
          _tile('Trading disabled', 'Never enter a broker password or token into this demo', Icons.security),
          _tile('FnO Pulse v0.6.0', 'GitHub Android build candidate', Icons.info_outline),
        ]);
    }
  }
}

class DemoPlot extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFF35D6C1)
      ..strokeWidth = 2.8..style = PaintingStyle.stroke;
    final path = Path();
    for (int i = 0; i < 55; i++) {
      final x = size.width * i / 54;
      final y = size.height * (0.64 - i * 0.005 - 0.12 * math.sin(i / 5));
      if (i == 0) { path.moveTo(x, y); } else { path.lineTo(x, y); }
    }
    canvas.drawPath(path, p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
