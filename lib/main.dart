import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // 119 전화 거는 함수
  Future<void> _makeEmergencyCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '119',
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // 에러 처리, 예를 들어 사용자에게 알림을 표시
      print('Could not launch $launchUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 응급 상황 목록
    final List<Map<String, dynamic>> emergencies = [
      {'title': '심폐소생술 (CPR)', 'icon': Icons.favorite_border},
      {'title': '기도 폐쇄', 'icon': Icons.person_off_outlined},
      {'title': '화상', 'icon': Icons.local_fire_department_outlined},
      {'title': '골절', 'icon': Icons.personal_injury_outlined},
      {'title': '출혈', 'icon': Icons.bloodtype_outlined},
      {'title': '발작', 'icon': Icons.bolt_outlined},
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _makeEmergencyCall,
        label: const Text('119 전화', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.call),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String emergency;

  const DetailScreen({super.key, required this.emergency});

  // 상세 정보 데이터
  static final Map<String, Map<String, String>> procedures = {
    '심폐소생술 (CPR)': {
      '성인': '1. (의식 확인) 어깨를 가볍게 두드리며 "괜찮으세요?"라고 물어봅니다.\n2. (119 신고) 반응이 없으면 즉시 119에 신고하고 주변에 자동심장충격기(AED)를 요청합니다.\n3. (가슴 압박) 깍지 낀 손으로 가슴 중앙을 분당 100~120회 속도로 약 5cm 깊이로 30회 압박합니다.\n4. (인공호흡) 환자의 코를 막고 입을 통해 1초 동안 숨을 2회 불어넣습니다. (가슴이 부풀어 오르는지 확인)\n5. 119 구급대원이 도착할 때까지 가슴 압박과 인공호흡을 30:2 비율로 반복합니다.',
      '소아': '1. (의식 확인) 어깨를 가볍게 두드리며 반응을 확인합니다.\n2. (119 신고) 반응이 없으면 즉시 119에 신고합니다.\n3. (가슴 압박) 한 손 또는 두 손가락(영아)으로 가슴 중앙을 분당 100~120회 속도로 약 4~5cm 깊이로 30회 압박합니다.\n4. (인공호흡) 아이의 코를 막고 입을 통해 1초 동안 숨을 2회 불어넣습니다.\n5. 구급대원이 도착할 때까지 30:2 비율로 반복합니다.',
    },
    '기도 폐쇄': {
      '성인': '1. (상태 확인) 환자가 기침을 할 수 있으면 계속하게 하고, 할 수 없다면 등 두드리기를 준비합니다.\n2. (등 두드리기) 환자의 등 중앙을 손바닥으로 강하게 5회 내리칩니다.\n3. (복부 밀어내기) 등 두드리기로 이물질이 나오지 않으면, 환자의 뒤에서 명치와 배꼽 사이에 주먹을 놓고 다른 손으로 감싼 뒤, 위로 강하게 5회 밀어 올립니다. (하임리히법)\n4. 이물질이 나올 때까지 등 두드리기와 복부 밀어내기를 반복합니다.',
      '소아': '1. (등 두드리기) 아이의 머리가 아래로 향하게 하고, 등 중앙을 5회 두드립니다.\n2. (가슴 압박) 이물질이 나오지 않으면, 아이를 바로 눕혀 가슴 중앙을 5회 압박합니다. (영아)\n3. (복부 밀어내기) 큰 아이의 경우 성인과 같이 복부 밀어내기를 시행합니다.\n4. 이물질이 나올 때까지 반복합니다.',
    },
    '화상': {
      '성인': '1. (열기 식히기) 즉시 흐르는 찬물에 10분 이상 화상 부위를 식힙니다. (얼음 사용 금지)\n2. (옷 제거) 상처 부위의 옷을 조심스럽게 제거합니다. 옷이 피부에 붙었다면 억지로 떼지 않습니다.\n3. (상처 보호) 깨끗하고 건조한 거즈나 수건으로 상처를 덮어 감염을 예방합니다.\n4. (병원 방문) 물집이 생기거나 피부색이 변한 경우 즉시 병원에 방문합니다.',
      '소아': '1. (열기 식히기) 성인과 동일하게 흐르는 찬물에 10분 이상 식힙니다. 아이가 추워하면 중단합니다.\n2. (상처 보호) 깨끗한 거즈로 상처를 덮어줍니다.\n3. (병원 방문) 소아는 피부가 약해 작은 화상도 위험할 수 있으므로 즉시 병원에 방문하는 것이 좋습니다.',
    },
    '골절': {
      '성인': '1. (안정) 환자를 가장 편안한 자세로 눕히고 움직이지 않게 합니다.\n2. (고정) 부러진 부위의 위아래 관절을 포함하여 부목이나 두꺼운 책 등으로 고정합니다.\n3. (냉찜질) 부상 부위에 냉찜질을 하여 붓기와 통증을 줄입니다.\n4. (병원 방문) 고정한 상태를 유지하며 즉시 병원으로 이동합니다.',
      '소아': '1. (안정 및 고정) 성인과 동일하게 움직이지 않게 하고 부목으로 고정합니다.\n2. (냉찜질) 냉찜질을 하여 붓기를 가라앉힙니다.\n3. (병원 방문) 아이를 진정시키며 신속하게 병원으로 이동합니다.',
    },
    '출혈': {
      '성인': '1. (직접 압박) 깨끗한 거즈나 천을 사용하여 상처 부위를 직접 강하게 압박합니다.\n2. (상처 부위 올리기) 출혈 부위를 심장보다 높게 유지하여 출혈을 줄입니다.\n3. (압박 유지) 피가 멎지 않으면 거즈를 떼지 말고 그 위에 새 거즈를 덧대어 압박을 계속합니다.\n4. (병원 방문) 심한 출혈의 경우 압박을 유지하며 즉시 119에 신고하거나 병원으로 갑니다.',
      '소아': '1. (직접 압박) 성인과 동일하게 깨끗한 천으로 상처를 직접 압박합니다.\n2. (상처 부위 올리기) 아이를 진정시키고 출혈 부위를 심장보다 높게 유지합니다.\n3. (병원 방문) 출혈이 심하거나 멈추지 않으면 즉시 병원으로 이동합니다.',
    },
    '발작': {
      '성인': '1. (안전 확보) 주변의 위험한 물건을 치워 환자가 다치지 않도록 합니다.\n2. (자세 유지) 환자를 옆으로 눕혀 혀나 구토물로 인해 기도가 막히지 않도록 합니다. 억지로 붙잡거나 입에 무언가를 넣지 않습니다.\n3. (시간 확인) 발작이 얼마나 지속되는지 시간을 확인합니다.\n4. (119 신고) 발작이 5분 이상 지속되거나, 호흡 곤란, 반복적인 발작, 임산부, 당뇨병 환자인 경우 즉시 119에 신고합니다.',
      '소아': '1. (안전 확보) 성인과 동일하게 주변의 위험한 물건을 치웁니다.\n2. (자세 유지) 옆으로 눕혀 기도를 확보합니다.\n3. (119 신고) 처음 발작을 했거나, 5분 이상 지속되거나, 머리를 다친 후 발작을 하는 경우 즉시 119에 신고합니다.',
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