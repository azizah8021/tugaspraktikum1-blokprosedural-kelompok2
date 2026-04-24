DROP PROCEDURE IF EXISTS bagian_a;

DELIMITER $$
CREATE PROCEDURE bagian_a(
    IN p_nama     VARCHAR(100),
    IN p_nim      VARCHAR(20),
    IN p_semester INT,
    IN p_prodi    VARCHAR(100)
)
BEGIN
    DECLARE v_kampus   VARCHAR(100) DEFAULT 'Universitas Mega Buana Palopo';
    DECLARE v_output   TEXT;

    SET v_output = CONCAT(
        'Mahasiswa ', p_nama,
        ' (', p_nim, ')',
        ' dari Program Studi ', p_prodi,
        ' terdaftar di ', v_kampus,
        ' pada semester ', p_semester, '.'
    );

    SELECT v_output AS 'Identitas Mahasiswa';
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS bagian_b;

DELIMITER $$
CREATE PROCEDURE bagian_b(
    IN p_jumlah_sks  INT,
    IN p_ipk         DECIMAL(3,2),
    IN p_status_ukt  VARCHAR(20),
    IN p_semester    INT
)
BEGIN
    DECLARE v_status_data  VARCHAR(20);
    DECLARE v_beban_studi  VARCHAR(20);
    DECLARE v_performa     VARCHAR(30);

    -- Kelayakan data
    IF UPPER(p_status_ukt) = 'LUNAS' AND p_semester > 0 AND p_jumlah_sks > 0 THEN
        SET v_status_data = 'Valid';
    ELSE
        SET v_status_data = 'Tidak Valid';
    END IF;

    -- Kategori beban studi
    IF p_jumlah_sks BETWEEN 1 AND 12 THEN
        SET v_beban_studi = 'Ringan';
    ELSEIF p_jumlah_sks BETWEEN 13 AND 18 THEN
        SET v_beban_studi = 'Sedang';
    ELSEIF p_jumlah_sks BETWEEN 19 AND 24 THEN
        SET v_beban_studi = 'Padat';
    ELSE
        SET v_beban_studi = 'Tidak Diketahui';
    END IF;

    -- Kategori performa akademik
    IF p_ipk >= 3.50 THEN
        SET v_performa = 'Sangat Baik';
    ELSEIF p_ipk >= 3.00 THEN
        SET v_performa = 'Baik';
    ELSEIF p_ipk >= 2.50 THEN
        SET v_performa = 'Cukup';
    ELSE
        SET v_performa = 'Perlu Pembinaan';
    END IF;

    SELECT
        v_status_data  AS 'Status Data',
        v_beban_studi  AS 'Beban Studi',
        v_performa     AS 'Performa Akademik';
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS bagian_c;

DELIMITER $$
CREATE PROCEDURE bagian_c(
    IN p_nama        VARCHAR(100),
    IN p_nim         VARCHAR(20),
    IN p_semester    INT,
    IN p_prodi       VARCHAR(100),
    IN p_jumlah_sks  INT,
    IN p_ipk         DECIMAL(3,2),
    IN p_status_ukt  VARCHAR(20)
)
BEGIN
    DECLARE v_kampus       VARCHAR(100) DEFAULT 'Universitas Mega Buana Palopo';
    DECLARE v_layak        VARCHAR(20);
    DECLARE v_beban_studi  VARCHAR(20);
    DECLARE v_performa     VARCHAR(30);
    DECLARE v_alasan       TEXT;
    DECLARE v_ringkasan    TEXT;

    -- Kelayakan KRS
    IF UPPER(p_status_ukt) = 'LUNAS' AND p_semester > 0 AND p_jumlah_sks > 0 THEN
        SET v_layak  = 'layak';
        SET v_alasan = 'Data akademik lengkap dan UKT telah dilunasi.';
    ELSE
        SET v_layak = 'tidak layak';
        IF UPPER(p_status_ukt) != 'LUNAS' THEN
            SET v_alasan = 'UKT belum dilunasi.';
        ELSEIF p_semester <= 0 THEN
            SET v_alasan = 'Data semester tidak valid.';
        ELSE
            SET v_alasan = 'Jumlah SKS tidak valid.';
        END IF;
    END IF;

    -- Beban studi
    IF p_jumlah_sks BETWEEN 1 AND 12 THEN
        SET v_beban_studi = 'Ringan';
    ELSEIF p_jumlah_sks BETWEEN 13 AND 18 THEN
        SET v_beban_studi = 'Sedang';
    ELSEIF p_jumlah_sks BETWEEN 19 AND 24 THEN
        SET v_beban_studi = 'Padat';
    ELSE
        SET v_beban_studi = 'Tidak Diketahui';
    END IF;

    -- Performa akademik
    IF p_ipk >= 3.50 THEN
        SET v_performa = 'Sangat Baik';
    ELSEIF p_ipk >= 3.00 THEN
        SET v_performa = 'Baik';
    ELSEIF p_ipk >= 2.50 THEN
        SET v_performa = 'Cukup';
    ELSE
        SET v_performa = 'Perlu Pembinaan';
    END IF;

    -- Ringkasan akhir
    SET v_ringkasan = CONCAT(
        'Mahasiswa ', p_nama, ' dengan NIM ', p_nim,
        ' dinyatakan ', v_layak, ' mengambil KRS. ',
        'Beban studi berada pada kategori ', v_beban_studi,
        ' dengan performa akademik ', v_performa, '.'
    );

    SELECT
        CONCAT(p_nama, ' (', p_nim, ')')  AS 'Identitas',
        p_prodi                           AS 'Program Studi',
        v_kampus                          AS 'Kampus',
        p_semester                        AS 'Semester',
        v_layak                           AS 'Kelayakan KRS',
        v_beban_studi                     AS 'Beban Studi',
        v_performa                        AS 'Performa Akademik',
        v_alasan                          AS 'Alasan',
        v_ringkasan                       AS 'Ringkasan';
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS bagian_d;

DELIMITER $$
CREATE PROCEDURE bagian_d(
    IN p_nama1     VARCHAR(100), IN p_nim1     VARCHAR(20),
    IN p_semester1 INT,          IN p_sks1     INT,
    IN p_ipk1      DECIMAL(3,2), IN p_ukt1     VARCHAR(20),
    IN p_nama2     VARCHAR(100), IN p_nim2     VARCHAR(20),
    IN p_semester2 INT,          IN p_sks2     INT,
    IN p_ipk2      DECIMAL(3,2), IN p_ukt2     VARCHAR(20)
)
BEGIN
    DECLARE v_performa1   VARCHAR(30);
    DECLARE v_beban1      VARCHAR(20);
    DECLARE v_performa2   VARCHAR(30);
    DECLARE v_beban2      VARCHAR(20);
    DECLARE v_kesimpulan  TEXT;

    -- Performa mahasiswa 1
    IF p_ipk1 >= 3.50 THEN SET v_performa1 = 'Sangat Baik';
    ELSEIF p_ipk1 >= 3.00 THEN SET v_performa1 = 'Baik';
    ELSEIF p_ipk1 >= 2.50 THEN SET v_performa1 = 'Cukup';
    ELSE SET v_performa1 = 'Perlu Pembinaan';
    END IF;

    -- Beban studi mahasiswa 1
    IF p_sks1 BETWEEN 1 AND 12 THEN SET v_beban1 = 'Ringan';
    ELSEIF p_sks1 BETWEEN 13 AND 18 THEN SET v_beban1 = 'Sedang';
    ELSEIF p_sks1 BETWEEN 19 AND 24 THEN SET v_beban1 = 'Padat';
    ELSE SET v_beban1 = 'Tidak Diketahui';
    END IF;

    -- Performa mahasiswa 2
    IF p_ipk2 >= 3.50 THEN SET v_performa2 = 'Sangat Baik';
    ELSEIF p_ipk2 >= 3.00 THEN SET v_performa2 = 'Baik';
    ELSEIF p_ipk2 >= 2.50 THEN SET v_performa2 = 'Cukup';
    ELSE SET v_performa2 = 'Perlu Pembinaan';
    END IF;

    -- Beban studi mahasiswa 2
    IF p_sks2 BETWEEN 1 AND 12 THEN SET v_beban2 = 'Ringan';
    ELSEIF p_sks2 BETWEEN 13 AND 18 THEN SET v_beban2 = 'Sedang';
    ELSEIF p_sks2 BETWEEN 19 AND 24 THEN SET v_beban2 = 'Padat';
    ELSE SET v_beban2 = 'Tidak Diketahui';
    END IF;

    -- Ringkasan dua mahasiswa
    SELECT
        p_nama1      AS 'Nama',    p_nim1      AS 'NIM',
        p_semester1  AS 'Smstr',   p_sks1      AS 'SKS',
        p_ipk1       AS 'IPK',     p_ukt1      AS 'UKT',
        v_beban1     AS 'Beban',   v_performa1 AS 'Performa'
    UNION ALL
    SELECT
        p_nama2, p_nim2, p_semester2, p_sks2,
        p_ipk2, p_ukt2, v_beban2, v_performa2;

    -- Kesimpulan perbandingan
    IF p_ipk1 > p_ipk2 THEN
        SET v_kesimpulan = CONCAT(
            p_nama1, ' memiliki performa akademik lebih baik dibanding ',
            p_nama2, ' (IPK ', p_ipk1, ' > ', p_ipk2, ').'
        );
    ELSEIF p_ipk2 > p_ipk1 THEN
        SET v_kesimpulan = CONCAT(
            p_nama2, ' memiliki performa akademik lebih baik dibanding ',
            p_nama1, ' (IPK ', p_ipk2, ' > ', p_ipk1, ').'
        );
    ELSE
        IF p_sks1 > p_sks2 THEN
            SET v_kesimpulan = CONCAT(
                'IPK keduanya sama (', p_ipk1, '). ',
                p_nama1, ' lebih unggul berdasarkan jumlah SKS (',
                p_sks1, ' > ', p_sks2, ').'
            );
        ELSEIF p_sks2 > p_sks1 THEN
            SET v_kesimpulan = CONCAT(
                'IPK keduanya sama (', p_ipk2, '). ',
                p_nama2, ' lebih unggul berdasarkan jumlah SKS (',
                p_sks2, ' > ', p_sks1, ').'
            );
        ELSE
            SET v_kesimpulan = CONCAT(
                'Kedua mahasiswa memiliki kondisi akademik yang setara ',
                '(IPK: ', p_ipk1, ', SKS: ', p_sks1, ').'
            );
        END IF;
    END IF;

    SELECT v_kesimpulan AS 'Kesimpulan Perbandingan';
END$$
DELIMITER ;


-- ============================================================
-- SKENARIO 1 - VALID
-- UKT lunas, semester dan SKS valid, layak ambil KRS
-- ============================================================

CALL bagian_a('Sitti Rahma', 'IK2411048', 4, 'Informatika');
CALL bagian_b(21, 4.00, 'LUNAS', 4);
CALL bagian_c('Sitti Rahma', 'IK2411048', 4, 'Informatika', 21, 4.00, 'LUNAS');
CALL bagian_d(
    'Sitti Rahma',   'IK2411048', 4, 21, 4.00, 'LUNAS',
    'Azizah Cahya', 'IK2411042', 4, 21, 3.50, 'LUNAS'
);


-- ============================================================
-- SKENARIO 2 - TIDAK VALID (UKT Belum Lunas)
-- ============================================================

CALL bagian_a('Nur Afni Ishar', 'IK2411046', 4, 'Informatika');
CALL bagian_b(21, 2.80, 'BELUM LUNAS', 4);
CALL bagian_c('Nur Afni Ishar', 'IK2411046', 4, 'Informatika', 21, 2.80, 'BELUM LUNAS');
CALL bagian_d(
    'Nur Afni Ishar', 'IK2411046', 4, 21, 2.80, 'BELUM LUNAS',
    'Sitti Rahma',  'IK2411048', 4, 21, 4.00, 'LUNAS'
);


-- ============================================================
-- SKENARIO 3 - TIDAK VALID (SKS = 0 dan semester = 0)
-- ============================================================

CALL bagian_a('Ade Fanjaya', 'IK2411033', 0, 'Informatika');
CALL bagian_b(0, 1.75, 'LUNAS', 0);
CALL bagian_c('Ade Fanjaya', '2IK2411033', 0, 'Informatika', 0, 1.75, 'LUNAS');
CALL bagian_d(
    'Ade Fanjaya', 'IK2411033', 0,  0, 1.75, 'LUNAS',
    'Dzubyan Fauzan', 'IK2411005', 2, 12, 2.80, 'BELUM LUNAS'
);