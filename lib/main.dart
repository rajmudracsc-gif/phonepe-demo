import 'package:flutter/material.dart';

void main() {
  runApp(const PhonePeApp());
}

class PhonePeApp extends StatelessWidget {
  const PhonePeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhonePe Clone',
      theme: ThemeData(
        fontFamily: 'sans-serif',
        primaryColor: const Color(0xFF5f259f),
        scaffoldBackgroundColor: const Color(0xFFF4F4F6),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final Color brandPurple = const Color(0xFF5f259f);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandPurple,
        elevation: 0,
        titleSpacing: 10,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Text("घर / ऑफिस", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
              ],
            ),
            Text("पुणे, महाराष्ट्र", style: TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("QR स्कॅनर उघडत आहे...")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // १. बॅनर कार्ड
            Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2C1052), Color(0xFF5f259f)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UPI द्वारे त्वरित पेमेंट करा", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("कोणत्याही बँकेत थेट ०% शुल्कावर ट्रान्सफर", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(Icons.security, color: Colors.amber, size: 36),
                ],
              ),
            ),

            // २. Transfer Money सेक्शन (४ मुख्य आयकॉन्स)
            _buildSectionCard(
              title: "पैसे पाठवा (Transfer Money)",
              actionText: "",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _circleAction(Icons.person_outline, "मोबाईल\nनंबरवर"),
                  _circleAction(Icons.account_balance_outlined, "बँक / UPI\nID वर"),
                  _circleAction(Icons.history, "स्वतःच्या\nखात्यात"),
                  _circleAction(Icons.account_balance_wallet_outlined, "बँक\nशिल्लक"),
                ],
              ),
            ),

            // ३. UPI ID स्ट्रिप
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.payment, size: 20, color: Color(0xFF5f259f)),
                      SizedBox(width: 8),
                      Text("UPI ID: 9876543210@ybl", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
            ),

            // ४. Recharge & Pay Bills ग्रिड
            _buildSectionCard(
              title: "रिचार्ज आणि बिले (Recharge & Pay Bills)",
              actionText: "सर्व पाहा",
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
                children: [
                  _gridAction(Icons.phone_android, "मोबाईल\nरिचार्ज"),
                  _gridAction(Icons.tv, "DTH"),
                  _gridAction(Icons.lightbulb_outline, "वीज बिल"),
                  _gridAction(Icons.credit_card, "क्रेडिट कार्ड"),
                  _gridAction(Icons.home_work_outlined, "घरभाडे"),
                  _gridAction(Icons.request_quote_outlined, "कर्ज हप्ता"),
                  _gridAction(Icons.shield_outlined, "विमा"),
                  _gridAction(Icons.grid_view, "सर्व सेवा"),
                ],
              ),
            ),

            // ५. अलीकडील व्यवहार (Recent Transactions)
            _buildSectionCard(
              title: "अलीकडील व्यवहार (Recent Transactions)",
              actionText: "इतिहास पाहा",
              child: Column(
                children: [
                  _transactionTile("किराणा स्टोअर्स", "22 Oct, 09:30 PM", "- ₹150", Colors.red),
                  const Divider(height: 1),
                  _transactionTile("पैसे मिळाले (सचिन)", "21 Oct, 04:15 PM", "+ ₹500", Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),

      // ६. बॉटम नॅव्हिगेशन बार
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: brandPurple,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "होम"),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: "स्टोअर्स"),
          BottomNavigationBarItem(icon: Icon(Icons.shield_outlined), label: "विमा"),
          BottomNavigationBarItem(icon: Icon(Icons.currency_rupee), label: "गुंतवणूक"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "इतिहास"),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, String actionText = "", required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
              if (actionText.isNotEmpty)
                Text(actionText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: brandPurple)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _circleAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: brandPurple,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _gridAction(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: brandPurple, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _transactionTile(String title, String date, String amount, Color amountColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: brandPurple.withOpacity(0.1),
                child: Icon(Icons.payment, color: brandPurple, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: amountColor),
          ),
        ],
      ),
    );
  }
}
