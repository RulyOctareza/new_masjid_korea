import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/admin_form_masjid_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

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
              itemBuilder: (context, index) {
                final masjid = masjids[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(masjid.name),
                    subtitle: Text(masjid.location),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AdminFormMasjidPage(
                                  isEdit: true,
                                  masjidData: {
                                    'name': masjid.name,
                                    'location': masjid.location,
                                    'city': masjid.city,
                                    'address': masjid.address,
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
                              builder: (context) => AlertDialog(
                                title: const Text('Konfirmasi Hapus'),
                                content: Text('Yakin ingin menghapus masjid "${masjid.name}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await FirebaseFirestore.instance.collection('masjids').doc(masjid.id).delete();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masjid berhasil dihapus')));
                              context.read<MasjidCubit>().fetchMasjid();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
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
