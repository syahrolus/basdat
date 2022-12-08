--ADMIN

--managemen kelompok mapel
SELECT * FROM kel_mapel km 

INSERT INTO kel_mapel (kode, nama, deskripsi) VALUES ('km10', 'Kelompok D', 'Peminatan')

UPDATE kel_mapel SET deskripsi = 'Muatan Lokal' WHERE kode = 'km10'

DELETE FROM kel_mapel WHERE kode = 'km10'

--managemen mapel
SELECT * FROM mapel m 

INSERT INTO mapel (kode, kode_kelompok, nama, singkatan, kkm) 
VALUES ('m10', 'km1', 'Seni Budaya', 'Sby', 75)

UPDATE mapel SET singkatan = 'SBY' WHERE kode = 'm10'

DELETE FROM mapel WHERE kode = 'm10'

--managemen kegiatan
SELECT * FROM kegiatan k 

INSERT INTO kegiatan (kode, kode_kelompok, nama) VALUES ('keg10', 'km3', 'Karate')

UPDATE kegiatan SET nama = 'Pencak Silat' WHERE kode = 'keg10'

DELETE FROM kegiatan WHERE kode = 'keg10'

--managemen kelas
SELECT * FROM kelas k 

INSERT INTO kelas (kode, nama, tingkat) VALUES ('kelas10', 'IX D', 'IX')

UPDATE kelas SET tingkat = 'XII', nama = 'XII D' WHERE kode = 'kelas10'

DELETE FROM kelas WHERE kode = 'kelas10'

--managemen siswa
SELECT * FROM siswa s  

INSERT INTO siswa (nis, nisn, nama, jk, tempat_lahir, tgl_lahir, alamat, no_hp, agama) 
VALUES ('1112', '7777771', 'Gunawan', 1, 'Aceh', '06-15-2000', 'Solo', '081984374', 'Budha')

UPDATE siswa SET agama = 'islam' WHERE nis = '1112'

DELETE FROM siswa WHERE nis = '1112'

--managemen guru
SELECT * FROM guru g 

INSERT INTO guru (nuptk, nama, email, jk, tempat_lahir, tanggal_lahir, alamat, no_hp, agama) 
VALUES ('555700', 'Sitama', 'saitama@gmail.com', 1, 'Jepang', '08-17-1945', 'Solo', '081233834', 'islam')

UPDATE guru SET agama = 'kristen' WHERE nuptk = '555700'

DELETE FROM guru WHERE nuptk = '555700'

--managemen mengajar
SELECT * FROM mengajar m

INSERT INTO mengajar (nuptk, kode_mapel, tahun) VALUES ('555700', 'm10', 2022)

DELETE FROM mengajar WHERE nuptk = '555700' AND kode_mapel = 'm10'

UPDATE mengajar SET kode_mapel = 'm3' WHERE nuptk = '555700' AND kode_mapel = 'm10'


--managemen jadwal
SELECT * FROM jadwal j 

INSERT INTO jadwal (id, kode_kelas, nuptk, hari, jamke, tahun, semester) 
VALUES (100, 'kelas1', '555551', 'selasa', 1, 2022, 1)

UPDATE jadwal SET jamke = 3 WHERE id=100

DELETE FROM jadwal WHERE id=100

--managemen wali kelas
SELECT * FROM walikelas w 

INSERT INTO walikelas (id, nuptk, kode_kelas, tahun) VALUES (20, '555551', 'kelas1', '2020')

UPDATE walikelas SET kode_kelas = 'kelas10' WHERE id = 20

DELETE FROM walikelas WHERE id = 20

--managemen ambil kelas
SELECT * FROM ambil_kelas ak 

INSERT INTO ambil_kelas (nis, kode_kelas, tahun) VALUES ('1112', 'kelas9', 2022)

UPDATE ambil_kelas SET tahun = 2021 WHERE nis = '1112' AND kode_kelas = 'kelas9'

DELETE FROM ambil_kelas WHERE nis = '1112' AND kode_kelas = 'kelas9'

--managemen prestasi siswa
SELECT * FROM prestasi p 

INSERT INTO prestasi (id, nis, nama, tingkat, tanggal) VALUES (10, '1112', 'Juara 1 Angkat Besi', 'Internasional', '12-12-2022')

UPDATE prestasi SET tingkat = 'Nasional' WHERE id = 10

DELETE FROM prestasi WHERE id = 10

--GURU
--managemen nilai
--managemen capaian
--managemen kehadiran

--WALI KELAS

--managemen pengembangan diri

--FITUR
--menampilkan daftar guru dan pelajaran diampu 
SELECT g.nama, m2.nama as pelajaran FROM mengajar m 
JOIN mapel m2 ON m2.kode = m.kode_mapel
JOIN guru g ON g.nuptk = m.nuptk 

--menampilkan jadwal guru 
SELECT g.nama, k.nama as kelas, m2.nama as mapel, j.hari, j.jamke 
FROM jadwal j 
JOIN guru g ON g.nuptk = j.nuptk 
JOIN kelas k ON k.kode = j.kode_kelas 
JOIN mengajar m ON m.nuptk = g.nuptk 
JOIN mapel m2 ON m2.kode = m.kode_mapel
WHERE g.nuptk = '555551' AND j.tahun = 2022

--menampilkan siswa, kelas, wali kelas tahun 2022
SELECT s.nama, k.nama, g.nama as walikelas, k.tingkat FROM ambil_kelas ak 
JOIN siswa s ON s.nis = ak.nis
JOIN kelas k ON k.kode = ak.kode_kelas 
JOIN walikelas w ON w.kode_kelas = k.kode 
JOIN guru g ON g.nuptk = w.nuptk 
WHERE ak.tahun = 2022


