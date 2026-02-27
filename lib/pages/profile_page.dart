import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nama = "Unaii";
  String email = "unaiiunais207@gmail.com";
  String hp = "08********";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend body ke belakang AppBar agar gradasi penuh satu layar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profil Pengguna", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8E24AA), 
              Color(0xFF3949AB), 
              Color(0xFF1E88E5), 
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), 
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 70, color: Color(0xFF3949AB)),
              ),
            ),
            
            const SizedBox(height: 15),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
                shadows: [Shadow(color: Colors.black26, blurRadius: 10)],
              ),
            ),
            const SizedBox(height: 30),

            // WIDGET PEMBUNGKUS INFO 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // Putih sangat transparan agar terlihat seperti kaca
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    _buildInfoItem(Icons.person_outline, "Nama Lengkap", nama),
                    Divider(color: Colors.white.withOpacity(0.1), indent: 70),
                    _buildInfoItem(Icons.mail_outline, "Email", email),
                    Divider(color: Colors.white.withOpacity(0.1), indent: 70),
                    _buildInfoItem(Icons.phone_android, "Nomor HP", hp),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol Edit dengan warna kontras
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3949AB),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
              ),
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("EDIT PROFIL", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 28),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white60)),
      subtitle: Text(
        value, 
        style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}