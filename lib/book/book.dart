class Book {
  String name;
  String image;
  String description;
  double rate;
  int page;
  String categoryBook;
  String languange;

  Book({
    required this.name,
    required this.image,
    required this.description,
    required this.rate,
    required this.page,
    required this.categoryBook,
    required this.languange,
  });
}

List<Book> listBook = [
  Book(
    name: 'Eleceed',
    image: 'images/image1.webp',
    description: 'Kaiden Pengguna kemampuan misterius yang bersembunyi di dalam tubuh kucing jalanan.\n'
                'Dia kemudian dijemput oleh Jiwoo setelah terluka setelah berkelahi dengan pengguna kemampuan lain.\n'
                'Ia memiliki kepribadian yang keras kepala dan suka memerintah Jiwoo anak SMA yang energik dan banyak bicara yang suka kucing.\n'
                'Ia sangat baik dan juga tampaknya memiliki kemampuan khusus.\n',
    rate: 9.5,
    page: 310,
    categoryBook: 'Action, Supernatural',
    languange: 'IDN'),

  Book(
    name: 'Mount Hua Sect',
    image: 'images/image2.webp',
    description: 'Chung Myung Murid ke- 13 dari Mount hua sect salah satu dari 3 swordsman terkuat Plum Blossom Sword Saint Mengalahkan Cheonn Ma yang membawa kehancuran pada dunia ini.\n'
                 'Setelah pertarungan tersebut ia menghembuskan nafas terakhirnya di atas gunung tempat mount hua sect berada dia terlahir kembali 100 tahun kemudian di dalam tubuh seorang anak kecil.\n',
    rate: 9.7,
    page: 192,
    categoryBook: 'Action, Comedy, Fantasy',
    languange: 'IDN'),

  Book(
    name: 'Sword Saint Reincarnation',
    image: 'images/image3.webp',
    description: 'Dalam kehidupan sebelumnya, sang protagonis dipuja sebagai “Sword Saint”. Puncak absolut ilmu pedang yang mencapai ketinggian tertinggi dalam kemampuan bela diri.\n'
                 'Setelah kematiannya, ia bereinkarnasi ke dunia baru sebagai bayi yang baru lahir dari keluarga bangsawan terkemuka dan terkenal karena penguasaan sihirnya yang mutlak. Di dunia ini, sihir dianggap sebagai bentuk kekuatan tertinggi, sementara pertarungan fisik dan ilmu pedang dipandang rendah sebagai seni yang inferior.\n'
                 'Meskipun dibesarkan dalam lingkungan yang mengharapkannya untuk unggul murni dalam sihir, ia mempertahankan ingatan dan penguasaan dari kehidupan masa lalunya.\n'
                 'Berbekal keterampilan tak tertandingi dari pendekar pedang terhebat dan menggabungkannya dengan mekanisme sihir yang halus, ia memulai perjalanan untuk menempa jalan baru—membuktikan kepada dunia yang terobsesi dengan sihir bahwa pedang paling tajam, yang dipegang oleh seorang master sejati, tetap tak tersentuh.\n',
    rate: 9.2,
    page: 98,
    categoryBook: 'Action, Martial Arts',
    languange: 'IDN'),

  Book(
    name: 'Sword Undying',
    image: 'images/image4.webp',
    description: 'Archimond, Sang Necromancer Terkuat yang Pernah Menebar Teror di Seluruh Benua.\n'
                 'Nyawanya melayang di ujung pedang sang pahlawan, Berkel Reinland.\n'
                 'Dan 200 tahun kemudian… ia terlahir kembali sebagai bayi dari sebuah keluarga bangsawan.\n'
                 'Kata-kata pertama yang terucap dari bibirnya\n'
                 'Wahai para penjaga kegelapan, para kaki tangan, dan seluruh pasukanku… taatilah perintahku!\n',
    rate: 9.4,
    page: 277,
    categoryBook: 'Action',
    languange: 'IDN'),

  Book(
    name: 'Villain Patrolled',
    image: 'images/image5.webp',
    description: 'Aku, seorang budak yang bereinkarnasi menjadi seorang bangsawan di dalam game.\n'
                 'Tapi katanya aku cuma karakter figuran yang nanti akan mati dibunuh oleh para penjahat masa depan?\n'
                 'Tidak bisa begitu! Aku akan menuntun mereka ke jalan yang benar dan menikmati hidup mewah sebagai bangsawan!\n'
                 'Untuk mencegah para calon penjahat kecil itu berubah menjadi jahat, aku menjadi dermawan dan membantu mereka mengatasi lingkungan yang keras.\n'
                 'Hasilnya? Mereka semua tumbuh menjadi anak-anak yang luar biasa dan… sepenuhnya normal.\n'
                 'Namun pada akhirnya…\n'
                 'Aku malah menjadi dalang terakhir dari kerajaan.\n',
    rate: 9.5,
    page: 240,
    categoryBook: 'Action, Supernatural',
    languange: 'IDN'),

  Book(
    name: 'The Heavenly Demon',
    image: 'images/image6.webp',
    description: 'Di kehidupanku yang selanjutnya aku ingin menyusuri jalan yang benar-benar berdeda dari ini.\n'
                 'Sang Heavenly Demon yang semasa hidupnya ditakuti dan dihormati mendapatkan petunjuk penting untuk bisa menguasai teknik Soul Augmenting Demonic Art pada saat momen kematiannya.\n'
                 'Teknik Soul Augmenting Demonic Art bukan hanya tentang memakan jiwa orang lain Sang Heavenly Demon kemudian terbangun pada tubuh Byeok Taesan seorang bangsawan muda yang lemah dan bisa mati kapan saja.\n'
                 'Untuk bertahan hidup dia harus pergi ke rumah bordil Sang Heavenly Demon yang kini menjelma menjadi Raja Malammemulai perjalanan hidupnya yang penuh ambisi.\n',              
    rate: 9.1,
    page: 210,
    categoryBook: 'Action, Adventure',
    languange: 'IDN'),

  Book(
    name: 'Star Embracing',
    image: 'images/image7.webp',
    description: 'Vlad adalah anak gelandangan dari daerah kumuh yang selalu mengagumi kesatria Setelah sebuah insiden di mana dia tersambar petir hitam dia mulai mendengar suara Suatu hari mendadak kesatria blue moonlight muncul dan kehidupan Vlad di daerah kumuh itu berubah drastis\n.'
                 'Bahkan sebuah bintang yang redup yang tidak bersinar di puncak langit malam masih sebuah bintang jika ia ingin bersinar.',
    rate: 9.0,
    page: 199,
    categoryBook: 'Action, Supernatural',
    languange: 'IDN'),

  Book(
    name: 'The World After The Fall',
    image: 'images/image8.webp',
    description: 'Manusia tibatiba dipanggil untuk menjadi Walkers dan mereka perlu menyelesaikan menara untuk menyelamatkan dunia.\n'
                 'Kemudian Regression Stone ditemukan sekarang Walkers bisa kembali ke masa lalu.\n'
                 'Dan perlahan-lahan semua orang pergi Jika aku pergi ke masa lalu lalu bagaimana dengan nasib orangorang di dunia ini.'
                 'Siapa yang akan menyelamatkan mereka.\n'
                 'Harapan terakhir umat manusia kelompok Carpe Diem dibentuk oleh orangorang yang menolak untuk meninggalkan dunia.\n'
                 'Tapi begitu Walker terakhir mencapai lantai 100 dia tidak tahu lagi apa yg harus dia percayai.\n'
                 'Ini adalah kisah tentang satusatunya pria yang pantang mundur untuk meninggalkan dunianya meskipun semua walker yang lain kembali ke masa lalu.\n',
    rate: 9.2,
    page: 143,
    categoryBook: 'Action, Adventure, Fantasy',
    languange: 'IDN'),

  Book(
    name: 'Pick Me Up',
    image: 'images/image9.webp',
    description: 'Dalam game gacha yang terkenal dengan kesulitannya yang mengerikan, Master peringkat ke5 di dunia Loki kehilangan kesadaran saat menyerbu Dungeon.\n'
                 'Setelah bangun Loki menyadari bahwa dia telah berubah menjadi Pahlawan Level 1 Bintang 1Han Yslat Untuk kembali ke Bumi dia harus memimpin para master dan hero pemula dan membersihkan lantai 100 Dungeon.\n'
                 'Kau macam-macam dengan orang yang salah.\n'
                 'Ini adalah kisah perjuangan keras Master Loki yang belum pernah mengalami satu kekalahan pun.',
    rate: 9.6,
    page: 122,
    categoryBook: 'Action, Supernatural',
    languange: 'IDN'),
];