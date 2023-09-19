import 'package:flutter/material.dart';
import 'package:memorial_flow/main.dart';
import 'package:memorial_flow/widgets/memorial.widget.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  DateTime now = DateTime.now();
  late DateTime _selectedDay = DateTime(now.year, now.month, now.day);

  Future fetchArticle() async {
    final data = await supabase
        .from('article')
        .select()
        .eq('userId', supabase.auth.currentUser?.id)
        .eq('date', _selectedDay.toString().split(" ")[0])
        .order('timeType', ascending: true);
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
              fontFamily: 'PretendardThin',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w300,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // 데이터가 성공적으로 로드된 경우
            if (snapshot.data != null && snapshot.data.length > 0) {
              // 데이터가 있을 경우 ListView를 표시합니다.
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return MemorialWidget(
                    content: snapshot.data[index]['content'],
                    timeType: snapshot.data[index]['timeType'],
                    date: snapshot.data[index]['date'],
                  );
                },
              );
            } else {
              // 데이터가 없을 경우 '작성한 글이 없습니다' 메시지를 표시합니다.
              return const Center(
                child: Text(
                  '작성한 글이 없습니다',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
