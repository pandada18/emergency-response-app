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
      '성인': '성인의 경우 뼈가 이미 다 굳어 꼭 빠른 대처가 필요한 것은 아님.',
      '소아': '성인의 경우 뼈가 이미 다 굳어 꼭 빠른 대처가 필요한 것은 아님. 그러나 어린아이의 경우 뼈가 무르기에 빠른 대처가 없다면 뼈가 변형된채로 성장할 가능성이 높아 영구적인 장애가 남을 가능성이 큼. 또한 골단(팔이나 다리뼈의 양쪽 끝 부분, 관절에 가까운 부분)에 인접한 골단판(성장판)이 어른과 달리 부드러운 연골로 이루어져 외력에 의한 골단판 골절이 흔하기에 빠르게 병원에 데려가거나 골절부분을 지지해주는 등의 대처법이 없다면 아이의 성장에 큰 영향을 끼침. 어린아이의 경우 골절이 치유되는 속도가 빠르기에 정확한 위치로 뼈가 붙지 않은 상태로 자연교정되는 경우가 많음 그렇기에 소아 골절의 대부분은 골절 부위를 맞추고 석고로 고정하는 것이 보통. 초기진단이 제대로 이루어지지 않으면 골절 치유속도가 빠른 어린아이는 이미 골유합이 이루어져 영구적인 장애를 얻거나 성장에 있어 악영향을 끼침.',
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
