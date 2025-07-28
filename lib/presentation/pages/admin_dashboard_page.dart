import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/admin_form_masjid_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  /// Helper untuk membangun card masjid (clean architecture)
  Widget _buildMasjidCard(BuildContext context, MasjidModel masjid) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto masjid (jika ada)
            if (masjid.photos.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  masjid.photos.first,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (c, e, s) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                ),
              )
            else
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            const SizedBox(width: 16),
            // Info masjid
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    masjid.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    masjid.location,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    masjid.city,
                    style: const TextStyle(color: Colors.black45),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(
                        masjid.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Aksi edit/hapus
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => AdminFormMasjidPage(
                              isEdit: true,
                              masjidData: {
                                'id': masjid.id,
                                'name': masjid.name,
                                'location': masjid.location,
                                'city': masjid.city,
                                'address': masjid.address,
                                'latitude': masjid.latitude,
                                'longitude': masjid.longitude,
                                'rating': masjid.rating,
                                'photos': masjid.photos,
                              },
                            ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Konfirmasi Hapus'),
                            content: Text(
                              'Yakin ingin menghapus masjid "${masjid.name}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: const Text('Hapus'),
                              ),
                            ],
                          ),
                    );
                    if (confirm == true) {
                      await FirebaseFirestore.instance
                          .collection('masjids')
                          .doc(masjid.id)
                          .delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Masjid berhasil dihapus'),
                        ),
                      );
                      context.read<MasjidCubit>().fetchMasjid();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Admin')),
      body: BlocBuilder<MasjidCubit, MasjidState>(
        builder: (context, state) {
          if (state is MasjidLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MasjidSuccess) {
            final masjids = state.masjid;
            return ListView.builder(
              itemCount: masjids.length,
              itemBuilder:
                  (context, index) => _buildMasjidCard(context, masjids[index]),
            );
          } else if (state is MasjidFailed) {
            return Center(child: Text('Gagal memuat data: ${state.error}'));
          }
          return const Center(child: Text('Tidak ada data masjid'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AdminFormMasjidPage(),
            ),
          );
        },
        label: const Text('Tambah Masjid'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
