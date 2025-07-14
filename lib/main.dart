import 'package:flutter/material.dart';

void main() {
  runApp(const EmergencyResponseApp());
}

class EmergencyResponseApp extends StatelessWidget {
  const EmergencyResponseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '응급 대처 가이드',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Pretendard',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencies = [
      {'title': '심폐소생술 (CPR)', 'icon': Icons.favorite_border},
      {'title': '기도 폐쇄', 'icon': Icons.person_off_outlined},
      {'title': '골절', 'icon': Icons.personal_injury_outlined},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('응급 대처 가이드', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: emergencies.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: Icon(emergencies[index]['icon'], color: Colors.red, size: 40),
              title: Text(emergencies[index]['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(emergency: emergencies[index]['title']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String emergency;

  const DetailScreen({super.key, required this.emergency});

  // 상세 정보 데이터 (탭 구조에 맞게 복원)
  static final Map<String, Map<String, String>> procedures = {
    '심폐소생술 (CPR)': {
      '성인': '1. (의식 확인) 어깨를 가볍게 두드리며 "괜찮으세요?"라고 물어봅니다.\n2. (119 신고) 반응이 없으면 즉시 119에 신고하고 주변에 자동심장충격기(AED)를 요청합니다.\n3. (가슴 압박) 깍지 낀 손으로 가슴 중앙을 분당 100~120회 속도로 약 5cm 깊이로 30회 압박합니다.\n4. (인공호흡) 환자의 코를 막고 입을 통해 1초 동안 숨을 2회 불어넣습니다. (가슴이 부풀어 오르는지 확인)\n5. 119 구급대원이 도착할 때까지 가슴 압박과 인공호흡을 30:2 비율로 반복합니다.',
      '소아': '1. (의식 확인) 어깨를 가볍게 두드리며 반응을 확인합니다.\n2. (119 신고) 반응이 없으면 즉시 119에 신고합니다.\n3. (가슴 압박) 한 손 또는 두 손가락(영아)으로 가슴 중앙을 분당 100~120회 속도로 약 4~5cm 깊이로 30회 압박합니다.\n4. (인공호흡) 아이의 코를 막고 입을 통해 1초 동안 숨을 2회 불어넣습니다.\n5. 구급대원이 도착할 때까지 30:2 비율로 반복합니다.',
    },
    '기도 폐쇄': {
      '성인': '1. (상태 확인) 환자가 기침을 할 수 있으면 계속하게 하고, 할 수 없다면 등 두드리기를 준비합니다.\n2. (등 두드리기) 환자의 등 중앙을 손바닥으로 강하게 5회 내리칩니다.\n3. (복부 밀어내기) 등 두드리기로 이물질이 나오지 않으면, 환자의 뒤에서 명치와 배꼽 사이에 주먹을 놓고 다른 손으로 감싼 뒤, 위로 강하게 5회 밀어 올립니다. (하임리히법)\n4. 이물질이 나올 때까지 등 두드리기와 복부 밀어내기를 반복합니다.',
      '소아': '1. (등 두드리기) 아이의 머리가 아래로 향하게 하고, 등 중앙을 5회 두드립니다.\n2. (가슴 압박) 이물질이 나오지 않으면, 아이를 바로 눕혀 가슴 중앙을 5회 압박합니다. (영아)\n3. (복부 밀어내기) 큰 아이의 경우 성인과 같이 복부 밀어내기를 시행합니다.\n4. 이물질이 나올 때까지 반복합니다.',
    },
    '골절': {
      '성인': '성인의 뼈는 성장이 완료되어 단단하고 강도가 높습니다.\n\n하지만 유연성이 소아보다 낮아 강한 충격을 받으면 완전히 부러지는 \'완전 골절\'이 발생하기 쉽습니다.\n\n치유 속도는 소아에 비해 상대적으로 느린 편입니다.',
      '소아': '소아의 뼈는 여러 가지 면에서 성인과 다릅니다.\n\n1. 성장판: 뼈의 끝에 성장판이라는 연골 조직이 있어 뼈가 계속 자랍니다. 이 부분이 다치면 성장 장애가 생길 수 있습니다.\n\n2. 유연성: 뼈가 더 유연하고 탄력적이어서, 완전히 부러지기보다는 휘거나 금만 가는 \'생나무 골절\'이 흔합니다.\n\n3. 치유 속도: 신진대사가 활발하여 성인보다 뼈가 훨씬 빨리 붙습니다.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final adultProcedure = procedures[emergency]?['성인']?.replaceAll('\n', '\n\n') ?? '정보가 없습니다.';
    final childProcedure = procedures[emergency]?['소아']?.replaceAll('\n', '\n\n') ?? '정보가 없습니다.';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(emergency, style: const TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            tabs: [
              Tab(text: '성인'),
              Tab(text: '소아'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                adultProcedure,
                style: const TextStyle(fontSize: 17, height: 1.8, letterSpacing: 0.5),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                childProcedure,
                style: const TextStyle(fontSize: 17, height: 1.8, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
