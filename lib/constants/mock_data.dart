// lib/constants/mock_data.dart

import '../models/user_model.dart';

final List<ScheduleItem> mockSchedule = [
  ScheduleItem(
    id: 's1',
    day: 'Monday',
    courseName: 'Algoritma & Pemrograman',
    lecturer: 'Dr. Budi Santoso',
    room: 'Lab Komputer A-201',
    timeStart: '07:30',
    timeEnd: '09:10',
    status: ClassStatus.ongoing,
    description: 'Mempelajari konsep dasar algoritma, flowchart, dan pemrograman dengan bahasa pemrograman C/C++. Mencakup pengenalan variabel, tipe data, perulangan, dan fungsi.',
  ),
  ScheduleItem(
    id: 's2',
    day: 'Monday',
    courseName: 'Kalkulus Lanjut',
    lecturer: 'Prof. Siti Rahayu',
    room: 'Gedung B - R.305',
    timeStart: '09:30',
    timeEnd: '11:10',
    status: ClassStatus.upcoming,
    description: 'Lanjutan mata kuliah kalkulus mencakup integral lipat, persamaan diferensial, deret tak terbatas, dan aplikasinya dalam bidang teknik.',
  ),
  ScheduleItem(
    id: 's3',
    day: 'Monday',
    courseName: 'Bahasa Inggris Teknik',
    lecturer: 'Ms. Amanda Clarke',
    room: 'Gedung C - R.101',
    timeStart: '13:00',
    timeEnd: '14:40',
    status: ClassStatus.canceled,
    description: 'Pembelajaran bahasa inggris dengan fokus pada terminologi teknik, membaca dokumentasi teknis, dan presentasi teknis dalam bahasa inggris.',
  ),
  ScheduleItem(
    id: 's4',
    day: 'Tuesday',
    courseName: 'Struktur Data',
    lecturer: 'Dr. Reza Firmansyah',
    room: 'Lab Komputer B-105',
    timeStart: '08:00',
    timeEnd: '09:40',
    status: ClassStatus.upcoming,
    description: 'Mempelajari struktur data seperti array, linked list, stack, queue, tree, dan graph. Implementasi dan analisis kompleksitas waktu dan ruang.',
  ),
  ScheduleItem(
    id: 's5',
    day: 'Tuesday',
    courseName: 'Basis Data',
    lecturer: 'Dr. Rina Susanti',
    room: 'Lab Komputer A-202',
    timeStart: '10:00',
    timeEnd: '11:40',
    status: ClassStatus.upcoming,
    description: 'Pengenalan konsep basis data relasional, SQL, normalisasi, dan manajemen data. Praktik menggunakan MySQL dan database design.',
  ),
  ScheduleItem(
    id: 's6',
    day: 'Wednesday',
    courseName: 'Rekayasa Perangkat Lunak',
    lecturer: 'Prof. Ahmad Hidayat',
    room: 'Aula Teknik Lt.3',
    timeStart: '07:30',
    timeEnd: '09:10',
    status: ClassStatus.upcoming,
    description: 'Metodologi pengembangan perangkat lunak, analisis kebutuhan, desain sistem, testing, dan maintenance. Mencakup berbagai model SDLC.',
  ),
  ScheduleItem(
    id: 's7',
    day: 'Thursday',
    courseName: 'Jaringan Komputer',
    lecturer: 'Dr. Hendri Wahyudi',
    room: 'Lab Jaringan C-301',
    timeStart: '09:30',
    timeEnd: '11:10',
    status: ClassStatus.upcoming,
    description: 'Pembelajaran protokol jaringan, TCP/IP, routing, switching, dan konfigurasi jaringan. Praktik konfigurasi dengan cisco packet tracer.',
  ),
  ScheduleItem(
    id: 's8',
    day: 'Friday',
    courseName: 'Keamanan Sistem Informasi',
    lecturer: 'Dr. Yudi Prasetyo',
    room: 'Gedung D - R.204',
    timeStart: '13:00',
    timeEnd: '14:40',
    status: ClassStatus.upcoming,
    description: 'Konsep keamanan sistem informasi, kriptografi, autentikasi, otorisasi, dan manajemen risiko keamanan siber.',
  ),
  ScheduleItem(
    id: 's9',
    day: 'Wednesday',
    courseName: 'Pemrograman Mobile Android',
    lecturer: 'Agus Mulyana',
    room: '11.010',
    timeStart: '10:00',
    timeEnd: '11:40',
    status: ClassStatus.upcoming,
    description: 'Pembelajaran pengembangan aplikasi mobile Android menggunakan Kotlin/Java. Mencakup UI/UX design, lifecycle activity, database SQLite, dan API integration.',
  ),
];

final List<NewsItem> mockNews = [
  NewsItem(
    id: 'n1',
    title: 'Pendaftaran Beasiswa Prestasi Semester Ganjil 2024/2025 Dibuka',
    content:
        'Direktorat Kemahasiswaan membuka pendaftaran beasiswa prestasi untuk semester ganjil tahun akademik 2024/2025. Mahasiswa dengan IPK minimal 3.5 dan aktif di kegiatan kampus dipersilakan untuk mendaftar melalui portal akademik.',
    category: 'Announcement',
    imageUrl:
        'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=600&q=80',
    publishedAt: '2 hours ago',
  ),
  NewsItem(
    id: 'n2',
    title: 'Tim Robotika Kampus Raih Juara 1 Kompetisi Nasional KRTI 2024',
    content:
        'Tim Robotika Terbang Kampus berhasil meraih juara pertama pada Kontes Robot Terbang Indonesia (KRTI) 2024 yang diselenggarakan di Universitas Gadjah Mada. Prestasi membanggakan ini merupakan hasil kerja keras selama satu tahun penuh.',
    category: 'Achievement',
    imageUrl:
        'https://images.unsplash.com/photo-1518770660439-4636190af475?w=600&q=80',
    publishedAt: '1 day ago',
  ),
  NewsItem(
    id: 'n3',
    title: 'Seminar Nasional Kecerdasan Buatan & Masa Depan Industri 4.0',
    content:
        'Fakultas Teknik menggelar seminar nasional bertema "AI dan Industri 4.0: Peluang dan Tantangan bagi Generasi Z". Acara akan menghadirkan pembicara dari Google Indonesia dan Tokopedia.',
    category: 'Event',
    imageUrl:
        'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80',
    publishedAt: '3 days ago',
  ),
];

const List<String> faculties = [
  'Engineering',
  'Science',
  'Arts & Humanities',
  'Computing & Design',
];
