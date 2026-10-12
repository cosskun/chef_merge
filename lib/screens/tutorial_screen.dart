import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _bounceController;

  final List<Map<String, dynamic>> _steps = [
    {
      'title': '1. Kilerden Malzeme Çıkar',
      'icon': '🍅',
      'badge': 'KİLER',
      'arrowDirection': 'down', // Ok aşağıyı göstersin
      'description':
          'Aşağıdaki "Kilerden Malzeme Çıkar" butonuna dokunarak tezgahına taze domates, hamur, peynir ve kıyma gibi hammaddeler çıkar.',
      'tip': '💡 İpucu: Kilerden çıkan malzemeler en üstten başlayarak düzenli sırayla tezgahına dizilir.',
      'preview': Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7043),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            Text('🍅 🍞 🧀', style: TextStyle(fontSize: 18)),
            Text(
              'KİLERDEN MALZEME ÇIKAR 👆',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    },
    {
      'title': '2. Kartları Birleştir (Merge)',
      'icon': '🥣',
      'badge': 'BİRLEŞTİRME',
      'arrowDirection': 'center',
      'description':
          'Aynı veya birbiriyle uyumlu iki kartı parmağınla tutup üst üste sürükle! Kartlar birleşerek yeni ve daha değerli bir lezzete dönüşür.',
      'tip': '💡 2x Domates ➔ 1x Doğranmış Domates\n💡 2x Doğranmış Domates ➔ 1x Domates Çorbası!',
      'preview': Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange.shade200, width: 1.5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MiniDemoCard(emoji: '🍅', label: 'Domates'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('+', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
            ),
            _MiniDemoCard(emoji: '🍅', label: 'Domates'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.arrow_forward_rounded, color: Colors.orange, size: 20),
            ),
            _MiniDemoCard(emoji: '🥣', label: 'Doğranmış', isResult: true),
          ],
        ),
      ),
    },
    {
      'title': '3. Siparişi Teslim Et',
      'icon': '🍲',
      'badge': 'TESLİMAT',
      'arrowDirection': 'up',
      'description':
          'Yemeği tamamlayınca müşterinin üstteki sipariş kutucuğuna veya ortadaki yeşil "Teslim Alanı"na sürükleyip bırak!',
      'tip': '💡 Hangi yemeğin nasıl yapıldığını unuttuysan siparişin altındaki [💡 Tarif] butonuna tıkla!',
      'preview': Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.green.shade400, width: 1.5),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('📥', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text(
              'Yemeği Buraya veya Siparişe Bırak',
              style: TextStyle(
                color: Color(0xFF1B5E20),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    },
    {
      'title': '4. Hız & Sabır Puanları',
      'icon': '⏱️',
      'badge': 'PUANLAMA',
      'arrowDirection': 'up',
      'description':
          'Müşterilerin sabır barı sürekli azalır. Hızlı teslim edersen daha çok puan kazanırsın!',
      'tip': '🔥 Hızlı Teslimat (Süre > %50): +120 P\n⭐ Normal Teslimat: +100 P\n💔 Süre Dolarsa: -50 P',
      'preview': Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.amber.shade300, width: 1.2),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🔥 +120 P', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 13)),
            SizedBox(width: 12),
            Text('⭐ +100 P', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 13)),
            SizedBox(width: 12),
            Text('💔 -50 P', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    },
    {
      'title': '5. Çöp Kovası & Yıldızlar',
      'icon': '🏆',
      'badge': 'BÖLÜM GEÇME',
      'arrowDirection': 'center',
      'description':
          'Tezgah dolduğunda istemediğin malzemeleri "🗑️ Çöp Kovası"na atabilirsin. %40 puan barajını geçerek sonraki bölümleri aç!',
      'tip': '⭐ 1 Yıldız (%40 Barajı) ➔ Bölüm Geçildi!\n⭐⭐ 2 Yıldız (%70) ➔ Harika!\n⭐⭐⭐ 3 Yıldız (%100) ➔ Usta Şef!',
      'preview': Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: const Row(
              children: [
                Text('🗑️', style: TextStyle(fontSize: 16)),
                SizedBox(width: 4),
                Text('Çöp Kovası', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Text('⭐⭐⭐', style: TextStyle(fontSize: 22)),
        ],
      ),
    },
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _finishTutorial();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _finishTutorial() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final isLast = _currentStep == _steps.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF7F0),
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF3E0),
                    Color(0xFFFFE0B2),
                    Color(0xFFFBE9E7),
                  ],
                ),
              ),
            ),
          ),

          // Main Responsive Frame
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 460),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. Top Header: Step Badge & Skip Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade500,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '🎓 ÖĞRETİCİ (${_currentStep + 1}/${_steps.length})',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.brown.shade800,
                            backgroundColor: Colors.white.withValues(alpha: 0.8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.close_rounded, size: 14),
                          label: const Text(
                            'Geç',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _finishTutorial,
                        ),
                      ],
                    ),

                    // 2. Main Step Card with Animated Arrow
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.orange.shade200, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withValues(alpha: 0.15),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              // Step Icon & Title
                              Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(step['icon'] as String, style: const TextStyle(fontSize: 36)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    step['title'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.brown.shade900,
                                    ),
                                  ),
                                ],
                              ),

                              // Interactive / Visual Preview
                              step['preview'] as Widget,

                              // Animated Direction Arrow
                              AnimatedBuilder(
                                animation: _bounceController,
                                builder: (context, child) {
                                  double dy = 0;
                                  if (step['arrowDirection'] == 'down') {
                                    dy = 6 * _bounceController.value;
                                  } else if (step['arrowDirection'] == 'up') {
                                    dy = -6 * _bounceController.value;
                                  }
                                  return Transform.translate(
                                    offset: Offset(0, dy),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        step['arrowDirection'] == 'down'
                                            ? Icons.arrow_downward_rounded
                                            : step['arrowDirection'] == 'up'
                                                ? Icons.arrow_upward_rounded
                                                : Icons.touch_app_rounded,
                                        color: Colors.brown.shade800,
                                        size: 22,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Description & Tip
                              Column(
                                children: [
                                  Text(
                                    step['description'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.brown.shade800,
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.orange.shade200),
                                    ),
                                    child: Text(
                                      step['tip'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown.shade900,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                    // 3. Step Dots Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_steps.length, (index) {
                        final isActive = index == _currentStep;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: isActive ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.orange.shade600 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    // 4. Navigation Buttons (Önceki & İleri / Şimdi Oyna)
                    Row(
                      children: [
                        if (_currentStep > 0) ...[
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.brown.shade800,
                                side: BorderSide(color: Colors.brown.shade300),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: _prevStep,
                              child: const Text('Geri'),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLast ? const Color(0xFF4CAF50) : const Color(0xFFFF7043),
                              foregroundColor: Colors.white,
                              elevation: 4,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: isLast ? _finishTutorial : _nextStep,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isLast ? 'Anasayfaya Dön 🏠' : 'İleri',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(width: 4),
                                Icon(isLast ? Icons.home_rounded : Icons.arrow_forward_rounded, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniDemoCard extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isResult;

  const _MiniDemoCard({
    required this.emoji,
    required this.label,
    this.isResult = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isResult ? Colors.orange.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isResult ? Colors.orange.shade600 : Colors.grey.shade300,
          width: isResult ? 1.8 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.bold,
              color: isResult ? Colors.orange.shade900 : Colors.brown.shade800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
