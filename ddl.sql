--CREATE DATABASE sekolah;
 
--USE sekolah;
 
DROP TABLE IF EXISTS prestasi
DROP TABLE IF EXISTS nilai
DROP TABLE IF EXISTS capaian
DROP TABLE IF EXISTS jadwal
DROP TABLE IF EXISTS pengembangan_diri
DROP TABLE IF EXISTS kehadiran
DROP TABLE IF EXISTS mengajar
DROP TABLE IF EXISTS walikelas
DROP TABLE IF EXISTS ambil_kelas
DROP TABLE IF EXISTS kelas
DROP TABLE IF EXISTS guru
DROP TABLE IF EXISTS kegiatan
DROP TABLE IF EXISTS mapel
DROP TABLE IF EXISTS kel_mapel
DROP TABLE IF EXISTS siswa

CREATE TABLE siswa (
    nis VARCHAR(10) NOT NULL,
    nisn VARCHAR(10) NOT NULL,
    nama VARCHAR(100),
    jk BIT,
    tempat_lahir VARCHAR(100),
    tgl_lahir DATE,
    alamat VARCHAR(100),
    no_hp VARCHAR(20),
    agama VARCHAR(20)
    
    CONSTRAINT PK_Siswa PRIMARY KEY (nis)
);
 
CREATE TABLE prestasi (
    id INT NOT NULL,
    nis VARCHAR(10) NOT NULL,
    nama VARCHAR(200),
    tingkat VARCHAR(20),
    tanggal DATE,
    
    CONSTRAINT PK_prestasi PRIMARY KEY (id, nis),
    CONSTRAINT FK_prestasi_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
);
 
CREATE TABLE kelas (
    kode VARCHAR(10) NOT NULL,
    nama VARCHAR(20),
    tingkat VARCHAR(5),
    
    CONSTRAINT PK_Kelas PRIMARY KEY (kode)
);
 
CREATE TABLE kel_mapel (
    kode VARCHAR(10) NOT NULL,
    nama VARCHAR(20),
    deskripsi VARCHAR(30),
    
    CONSTRAINT PK_kelmapel PRIMARY KEY (kode)
);
 
CREATE TABLE mapel (
    kode VARCHAR(10) NOT NULL,
    kode_kelompok VARCHAR(10) NOT NULL,
    nama VARCHAR(20),
    singkatan VARCHAR(10),
    kkm INT,
    
    CONSTRAINT PK_Mapel PRIMARY KEY (kode),
    CONSTRAINT FK_mapel_kelmapel FOREIGN KEY (kode_kelompok) REFERENCES kel_mapel(kode)
);

CREATE TABLE kegiatan (
	kode VARCHAR(10),
	kode_kelompok VARCHAR(10),
	nama VARCHAR(200),
	
	CONSTRAINT PK_kegiatan PRIMARY KEY (kode),
	CONSTRAINT FK_kegiatan_kelompok FOREIGN KEY (kode_kelompok) REFERENCES kel_mapel(kode),
)

CREATE TABLE guru (
    nuptk VARCHAR(10) NOT NULL,
    nama VARCHAR(100),
    email VARCHAR(50),
    jk BIT,
    tempat_lahir VARCHAR(100),
    tanggal_lahir DATE,
    alamat TEXT,
    no_hp VARCHAR(20),
    agama VARCHAR(20),
    
    CONSTRAINT PK_Guru PRIMARY KEY (nuptk),
)
 
CREATE TABLE nilai (
    id INT NOT NULL,
    nis VARCHAR(10) NOT NULL,
    nuptk VARCHAR(10),
    kode_mapel VARCHAR(10),
    kode_kelas VARCHAR(10),
    semester TINYINT,
    tahun SMALLINT,
    nilai INT,
    jenis VARCHAR(20),
    
    CONSTRAINT PK_Nilai PRIMARY KEY (id),
    CONSTRAINT FK_nilai_mapel FOREIGN KEY (kode_mapel) REFERENCES mapel(kode),
    CONSTRAINT FK_nilai_guru FOREIGN KEY (nuptk) REFERENCES guru(nuptk),
    CONSTRAINT FK_nilai_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
    CONSTRAINT FK_nilai_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode)
)
 
CREATE TABLE capaian (
    id INT NOT NULL,
    kode_mapel VARCHAR(10),
    nuptk VARCHAR(10),
    nis VARCHAR(10) NOT NULL,
    kode_kelas VARCHAR(10),
    semester TINYINT,
    tahun SMALLINT,
    nilai_pengetahuan INT,
    nilai_keterampilan INT,
    nilai_sosial INT,
    
    CONSTRAINT PK_Capaian PRIMARY KEY (id),
    CONSTRAINT FK_capaian_mapel FOREIGN KEY (kode_mapel) REFERENCES mapel(kode),
    CONSTRAINT FK_capaian_guru FOREIGN KEY (nuptk) REFERENCES guru(nuptk),
    CONSTRAINT FK_capaian_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
    CONSTRAINT FK_capaian_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode)
)
 
CREATE TABLE pengembangan_diri (
    id INT NOT NULL,
    kode_mapel VARCHAR(10),
    nuptk VARCHAR(10),
    nis VARCHAR(10) NOT NULL,
    kode_kelas VARCHAR(10),
    semester TINYINT,
    nilai INT,
    tahun SMALLINT,
    keterangan TEXT,
    
    CONSTRAINT PK_Pengembangandiri PRIMARY KEY (id),
    CONSTRAINT FK_pengembangandiri_mapel FOREIGN KEY (kode_mapel) REFERENCES mapel(kode),
    CONSTRAINT FK_pengembangandiri_guru FOREIGN KEY (nuptk) REFERENCES guru(nuptk),
    CONSTRAINT FK_pengembangandiri_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
    CONSTRAINT FK_pengembangandiri_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode)
)
 
CREATE TABLE kehadiran (
    id INT NOT NULL,
    kode_mapel VARCHAR(10),
    nuptk VARCHAR(10),
    nis VARCHAR(10) NOT NULL,
    kode_kelas VARCHAR(10),
    pertemuan_ke TINYINT,
    tanggal DATE
    
    CONSTRAINT PK_Kehadiran PRIMARY KEY (id),
    CONSTRAINT FK_kehadiran_mapel FOREIGN KEY (kode_mapel) REFERENCES mapel(kode),
    CONSTRAINT FK_kehadiran_guru FOREIGN KEY (nuptk) REFERENCES guru(nuptk),
    CONSTRAINT FK_kehadiran_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
    CONSTRAINT FK_kehadiran_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode)
)
 

CREATE TABLE mengajar (
    kode_mapel VARCHAR(10),
    nuptk VARCHAR(10), 
--	nis VARCHAR(10) NOT NULL,
--	kode_kelas VARCHAR(10),
	tahun SMALLINT,

	CONSTRAINT PK_Mengajar PRIMARY KEY(kode_mapel, nuptk),
	CONSTRAINT FK_mengajar_mapel FOREIGN KEY (kode_mapel) REFERENCES mapel(kode),
	CONSTRAINT FK_mengajar_guru FOREIGN KEY (nuptk) REFERENCES guru(nuptk),
--	CONSTRAINT FK_mengajar_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
--	CONSTRAINT FK_mengajar_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode)
)


CREATE TABLE walikelas (
	id INT NOT NULL,
    nuptk VARCHAR(10),
    kode_kelas VARCHAR(10),
    tahun SMALLINT,

	CONSTRAINT PK_Walikelas PRIMARY KEY(id),
	CONSTRAINT FK_walikelas_guru FOREIGN KEY (nuptk) REFERENCES guru(nuptk),
	CONSTRAINT FK_walikelas_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode)

)

CREATE TABLE ambil_kelas (
	nis VARCHAR(10),
	kode_kelas VARCHAR(10),
	tahun SMALLINT,
	
	CONSTRAINT PK_ambilkelas PRIMARY KEY(nis, kode_kelas),
	CONSTRAINT FK_amkel_siswa FOREIGN KEY (nis) REFERENCES siswa(nis),
	CONSTRAINT FK_amkel_kelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode),
)

CREATE TABLE jadwal (
	id INT,
	kode_kelas VARCHAR(10),
	nuptk VARCHAR(10),
	hari VARCHAR(15),
	jamke TINYINT,
	tahun SMALLINT,
	semester TINYINT
	
	CONSTRAINT PK_jadwal PRIMARY KEY(id),
	CONSTRAINT FK_jadwal_kodekelas FOREIGN KEY (kode_kelas) REFERENCES kelas(kode),
)
