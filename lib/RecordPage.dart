import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'record.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

final Box<Record> recordsBox = Hive.box<Record>('records');
void addRecord(String type, int score) {
  final record = Record(type: type, score: score);
  recordsBox.add(record);
}
class _RecordPageState extends State<RecordPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的记录'),
      ),
      body: ValueListenableBuilder(
        valueListenable: recordsBox.listenable(),
        builder: (context, Box<Record> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('尚无记录'));
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Record record = box.getAt(index)!;
              return ListTile(
                title: Text(record.type),
                subtitle: Text('Score: ${record.score}'),
              );
            },
          );
        },
      ),
    );
  }
}