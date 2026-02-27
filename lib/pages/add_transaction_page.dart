import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool isPemasukan = true;
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Add Transaction", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF9C27B0), 
              Color(0xFF3F51B5), 
              Color(0xFF03A9F4), 
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 120), 
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Toggle Pilihan Pemasukan / Pengeluaran
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildToggleBtn("Pemasukan", isPemasukan),
                          const SizedBox(width: 15),
                          _buildToggleBtn("Pengeluaran", !isPemasukan),
                        ],
                      ),
                      const SizedBox(height: 40),
                      
                      // Input Keterangan
                      _buildTextField(
                        controller: _judulController,
                        hint: "Keterangan (Contoh: Beli Kopi)",
                        icon: Icons.edit_note_rounded,
                      ),
                      const SizedBox(height: 20),
                      
                      // Input Nominal
                      _buildTextField(
                        controller: _nominalController,
                        hint: "Nominal (Rp)",
                        icon: Icons.payments_rounded,
                        isNumber: true,
                      ),
                      
                      const SizedBox(height: 50),
                      
                      // Tombol Simpan dengan Gradasi
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9C27B0), Color(0xFF3F51B5)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            if (_judulController.text.isNotEmpty && _nominalController.text.isNotEmpty) {
                              final dataBaru = Transaction(
                                judul: _judulController.text,
                                nominal: double.parse(_nominalController.text),
                                isPemasukan: isPemasukan,
                              );
                              Navigator.pop(context, dataBaru);
                            }
                          },
                          child: const Text(
                            "Simpan Transaksi",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper 
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF3F51B5)),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF3F6FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF3F51B5), width: 2),
        ),
      ),
    );
  }

  // Widget Helper untuk Tombol Toggle
  Widget _buildToggleBtn(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => isPemasukan = (label == "Pemasukan")),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF3F51B5) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: active ? const Color(0xFF3F51B5) : Colors.grey.shade300,
          ),
          boxShadow: active
              ? [BoxShadow(color: Colors.indigo.withOpacity(0.3), blurRadius: 10)]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              label == "Pemasukan" ? Icons.add_circle_outline : Icons.remove_circle_outline,
              size: 18,
              color: active ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: active ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}