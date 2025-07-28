import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AdminFormMasjidPage extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? masjidData;
  const AdminFormMasjidPage({Key? key, this.isEdit = false, this.masjidData})
    : super(key: key);

  @override
  State<AdminFormMasjidPage> createState() => _AdminFormMasjidPageState();
}

class _AdminFormMasjidPageState extends State<AdminFormMasjidPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  List<XFile> _selectedPhotos = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.masjidData != null) {
      _nameController.text = widget.masjidData!['name'] ?? '';
      _locationController.text = widget.masjidData!['location'] ?? '';
      _cityController.text = widget.masjidData!['city'] ?? '';
      _addressController.text = widget.masjidData!['address'] ?? '';
      // Load existing photos if any
      // _selectedPhotos = //... load from widget.masjidData['photos']
    }
  }

  Future<void> _pickPhotos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? picked = await picker.pickMultiImage();
    if (picked != null) {
      setState(() {
        _selectedPhotos = picked.take(5).toList(); // Maksimal 5 foto
      });
    }
  }

  Future<List<String>> _uploadPhotos() async {
    List<String> urls = [];
    for (var photo in _selectedPhotos) {
      final ref = FirebaseStorage.instance.ref().child(
        'masjid_photos/${DateTime.now().millisecondsSinceEpoch}_${photo.name}',
      );
      await ref.putData(await photo.readAsBytes());
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Masjid' : 'Tambah Masjid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Masjid'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Nama wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Lokasi'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Lokasi wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Kota'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Kota wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Alamat wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              Text('Foto Masjid (maksimal 5):'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    _selectedPhotos
                        .map(
                          (photo) => Image.file(
                            File(photo.path),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
              ),
              TextButton.icon(
                onPressed: _pickPhotos,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pilih Foto'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed:
                    _isUploading
                        ? null
                        : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isUploading = true);
                            List<String> photoUrls = [];
                            if (_selectedPhotos.isNotEmpty) {
                              photoUrls = await _uploadPhotos();
                            }
                            final masjidData = {
                              'name': _nameController.text.trim(),
                              'location': _locationController.text.trim(),
                              'city': _cityController.text.trim(),
                              'address': _addressController.text.trim(),
                              'photos': photoUrls,
                            };
                            final masjidsRef = FirebaseFirestore.instance
                                .collection('masjids');
                            if (widget.isEdit &&
                                widget.masjidData != null &&
                                widget.masjidData!['id'] != null) {
                              await masjidsRef
                                  .doc(widget.masjidData!['id'])
                                  .update(masjidData);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Data masjid berhasil diupdate',
                                  ),
                                ),
                              );
                            } else {
                              await masjidsRef.add(masjidData);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Data masjid berhasil ditambah',
                                  ),
                                ),
                              );
                            }
                            setState(() => _isUploading = false);
                            Navigator.of(context).pop();
                          }
                        },
                child:
                    _isUploading
                        ? const CircularProgressIndicator()
                        : Text(widget.isEdit ? 'Update' : 'Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
