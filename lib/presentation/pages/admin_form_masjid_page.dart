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
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _communityController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  List<XFile> _selectedPhotos = [];
  List<String> _oldPhotoUrls = [];
  bool _isUploading = false;
  String? _formError;
  String? _formSuccess;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.masjidData != null) {
      _nameController.text = widget.masjidData!['name'] ?? '';
      _locationController.text = widget.masjidData!['location'] ?? '';
      _cityController.text = widget.masjidData!['city'] ?? '';
      _addressController.text = widget.masjidData!['address'] ?? '';
      _latitudeController.text =
          widget.masjidData!['latitude']?.toString() ?? '';
      _longitudeController.text =
          widget.masjidData!['longitude']?.toString() ?? '';
      _communityController.text = widget.masjidData!['community'] ?? '';
      _ratingController.text = widget.masjidData!['rating']?.toString() ?? '';
      if (widget.masjidData!['photos'] != null) {
        _oldPhotoUrls = List<String>.from(widget.masjidData!['photos']);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _communityController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  // Helper untuk menampilkan pesan error/feedback
  Widget _buildFormError() {
    if (_formError == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(_formError!, style: const TextStyle(color: Colors.red)),
    );
  }

  // Helper untuk menampilkan pesan sukses
  Widget _buildFormSuccess() {
    if (_formSuccess == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(_formSuccess!, style: const TextStyle(color: Colors.green)),
    );
  }

  Future<void> _pickPhotos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? picked = await picker.pickMultiImage();
    if (picked != null) {
      // Batasi total foto (lama + baru) maksimal 5
      final total = _oldPhotoUrls.length + picked.length;
      if (total > 5) {
        setState(() {
          _formError = 'Total foto maksimal 5!';
          _selectedPhotos = picked.take(5 - _oldPhotoUrls.length).toList();
        });
      } else {
        setState(() {
          _formError = null;
          _selectedPhotos = picked;
        });
      }
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

  // Membuat masjidData dari input form
  Map<String, dynamic> _buildMasjidData(List<String> photoUrls) {
    return {
      'name': _nameController.text.trim(),
      'location': _locationController.text.trim(),
      'city': _cityController.text.trim(),
      'address': _addressController.text.trim(),
      'latitude': double.tryParse(_latitudeController.text.trim()) ?? 0.0,
      'longitude': double.tryParse(_longitudeController.text.trim()) ?? 0.0,
      'community': _communityController.text.trim(),
      'rating': double.tryParse(_ratingController.text.trim()) ?? 0.0,
      'photos': photoUrls,
    };
  }

  /// Validasi semua field form masjid
  bool _validateForm() {
    if (!_formKey.currentState!.validate()) return false;
    if (_selectedPhotos.isEmpty && _oldPhotoUrls.isEmpty) {
      setState(() {
        _formError = 'Minimal 1 foto masjid wajib diisi';
        _formSuccess = null;
      });
      return false;
    }
    setState(() {
      _formError = null;
    });
    return true;
  }

  /// Reset semua field form setelah submit sukses
  void _resetForm() {
    _nameController.clear();
    _locationController.clear();
    _cityController.clear();
    _addressController.clear();
    _latitudeController.clear();
    _longitudeController.clear();
    _communityController.clear();
    _ratingController.clear();
    _selectedPhotos.clear();
    _oldPhotoUrls.clear();
    setState(() {
      _formError = null;
      _formSuccess = null;
    });
  }

  // Submit data masjid ke Firestore
  Future<void> _submitForm() async {
    if (!_validateForm()) return;
    setState(() {
      _isUploading = true;
      _formError = null;
      _formSuccess = null;
    });
    List<String> photoUrls = _oldPhotoUrls;
    if (_selectedPhotos.isNotEmpty) {
      photoUrls = await _uploadPhotos();
    }
    final masjidData = _buildMasjidData(photoUrls);
    final masjidsRef = FirebaseFirestore.instance.collection('masjids');
    try {
      if (widget.isEdit &&
          widget.masjidData != null &&
          widget.masjidData!['id'] != null) {
        await masjidsRef.doc(widget.masjidData!['id']).update(masjidData);
        setState(() {
          _formSuccess = 'Data masjid berhasil diupdate';
        });
      } else {
        await masjidsRef.add(masjidData);
        setState(() {
          _formSuccess = 'Data masjid berhasil ditambah';
        });
        _resetForm();
      }
      setState(() => _isUploading = false);
      Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.of(context).pop(),
      );
    } catch (e) {
      setState(() {
        _formError = 'Gagal menyimpan data. Silakan coba lagi.';
        _formSuccess = null;
        _isUploading = false;
      });
    }
  }

  String? _validateRating(String? value) {
    if (value == null || value.isEmpty) return 'Rating wajib diisi';
    final rating = double.tryParse(value);
    if (rating == null || rating < 0 || rating > 5) return 'Rating harus 0-5';
    return null;
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
              TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Latitude wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Longitude wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _communityController,
                decoration: const InputDecoration(labelText: 'Komunitas'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Komunitas wajib diisi'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: _validateRating,
              ),
              const SizedBox(height: 12),
              Text(
                'Foto Masjid (maksimal 5, saat ini: ${_oldPhotoUrls.length + _selectedPhotos.length})',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ..._oldPhotoUrls.map(
                    (url) => Stack(
                      children: [
                        Image.network(
                          url,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        if (widget.isEdit)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _oldPhotoUrls.remove(url);
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  ..._selectedPhotos.map(
                    (photo) => Image.file(
                      File(photo.path),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed:
                    (_oldPhotoUrls.length + _selectedPhotos.length) < 5
                        ? _pickPhotos
                        : null,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pilih Foto'),
              ),
              const SizedBox(height: 24),
              _buildFormError(),
              _buildFormSuccess(),
              ElevatedButton(
                onPressed: _isUploading ? null : _submitForm,
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
