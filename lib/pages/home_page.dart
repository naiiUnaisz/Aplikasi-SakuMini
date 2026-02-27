import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'add_transaction_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> listTransaksi = [];

  double hitungSaldo() {
    double total = 0;
    for (var item in listTransaksi) {
      item.isPemasukan ? total += item.nominal : total -= item.nominal;
    }
    return total;
  }

  double ambilTotalMasuk() {
    double total = 0;
    for (var item in listTransaksi) {
      if (item.isPemasukan) total += item.nominal;
    }
    return total;
  }

  double ambilTotalKeluar() {
    double total = 0;
    for (var item in listTransaksi) {
      if (!item.isPemasukan) total += item.nominal;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text("My Wallet", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFF3F51B5)],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3949AB), Color(0xFF8E24AA)],
                ),
              ),
              accountName: const Text("unaii", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text("unaiiunais207@gmail.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF3F51B5)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Color(0xFF3F51B5)),
              title: const Text("Lihat Profil"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            const Divider(),
            const Spacer(),
            const Text("SakuMini | By: unaii", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: Column(
        children: [
          // Widget Saldo Utama & Ringkasan (Pemasukan/Pengeluaran)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFF3F51B5)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              // Kartu Saldo Utama
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text("Total Saldo", style: TextStyle(color: Colors.grey, fontSize: 16)),
                          const SizedBox(height: 5),
                          Text(
                            "Rp ${hitungSaldo()}",
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5)),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          // Widget Pemasukan & Pengeluaran (Horizontal)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildSummaryItem(Icons.arrow_downward, "Pemasukan", ambilTotalMasuk(), Colors.green),
                              Container(height: 30, width: 1, color: Colors.grey[200]),
                              _buildSummaryItem(Icons.arrow_upward, "Pengeluaran", ambilTotalKeluar(), Colors.red),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Text("Riwayat Transaksi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))
            ),
          ),
          
          Expanded(
            child: listTransaksi.isEmpty
                ? const Center(child: Text("Belum ada transaksi, ayo tambah!", style: TextStyle(color: Colors.black45)))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 0, bottom: 80),
                    itemCount: listTransaksi.length,
                    itemBuilder: (context, index) {
                      final item = listTransaksi[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)]
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: item.isPemasukan ? const Color(0xFFE1FFEB) : const Color(0xFFFFE1E1),
                            child: Icon(
                              item.isPemasukan ? Icons.south_west : Icons.north_east, 
                              color: item.isPemasukan ? Colors.green : Colors.red, 
                              size: 20
                            ),
                          ),
                          title: Text(item.judul, style: const TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Text(
                            "${item.isPemasukan ? '+' : '-'} Rp ${item.nominal}", 
                            style: TextStyle(fontWeight: FontWeight.bold, color: item.isPemasukan ? Colors.green : Colors.red)
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3F51B5),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final res = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionPage()));
          if (res != null) setState(() { listTransaksi.add(res); });
        },
      ),
    );
  }

  // Widget Helper untuk Ringkasan Masuk/Keluar
  Widget _buildSummaryItem(IconData icon, String title, double amount, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 5),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "Rp $amount",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color),
        ),
      ],
    );
  }
}