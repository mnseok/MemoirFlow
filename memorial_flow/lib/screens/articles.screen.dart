import 'package:flutter/material.dart';
import 'package:memorial_flow/main.dart';
import 'package:memorial_flow/widgets/memorial.widget.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  DateTime _selectedDay = DateTime.now().subtract(
    Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ),
  );

  Future fetchArticle() async {
    final data = await supabase
        .from('article')
        .select()
        .eq('userId', supabase.auth.currentUser?.id)
        .gte('created_at', _selectedDay)
        .lt('created_at', _selectedDay.add(const Duration(days: 1)));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDay,
                firstDate: DateTime(2010),
                lastDate: DateTime.now(),
              );

              if (selectedDate != null) {
                setState(() {
                  _selectedDay = selectedDate;
                });
              }
            },
            child: Text(
              _selectedDay.toString().split(" ")[0],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: () {
              setState(() {
                _selectedDay = _selectedDay.subtract(const Duration(days: 1));
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  if (_selectedDay
                      .add(const Duration(days: 1))
                      .isBefore(DateTime.now())) {
                    _selectedDay = _selectedDay.add(const Duration(days: 1));
                  }
                });
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: fetchArticle(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터가 아직 로드 중인 경우 로딩 화면을 표시하거나 다른 처리를 할 수 있습니다.
              return const Center(
                  child: CircularProgressIndicator()); // 예시: 로딩 스피너를 표시
            } else if (snapshot.hasError) {
              // 데이터 로딩 중에 오류가 발생한 경우 오류 메시지를 표시하거나 다른 처리를 할 수 있습니다.
              return Text('Error: ${snapshot.error}');
            } else {
              // 데이터가 성공적으로 로드된 경우 ListView를 표시합니다.
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return MemorialWidget(
                      content: snapshot.data[index]['content'],
                    );
                  },
                );
              } else {
                // 데이터가 null인 경우에 대한 처리를 할 수 있습니다.
                return const Text('Data is null');
              }
            }
          },
        ));
  }
}