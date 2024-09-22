CREATE DATABASE QuanLyGiaoVu
--Tao bang khoa
CREATE TABLE KHOA
(
	MAKHOA varchar(4) primary key, 
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
);
--Tao bang mon hoc
CREATE TABLE MONHOC
(
	MAMH varchar(10) primary key,
	TENMH varchar(40),
	TCLT tinyint, 
	TCTH tinyint, 
	MAKHOA varchar(4),
	FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);
--Tao bang dieu kien
CREATE TABLE DIEUKIEN
(
	MAMH varchar(10), 
	MAMH_TRUOC varchar(10),
	primary key (MAMH, MAMH_TRUOC),
	FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH), 
	FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);
--Tao bang giao vien
CREATE TABLE GIAOVIEN
(
	MAGV char(4) primary key, 
	HOTEN varchar(40), 
	HOCVI varchar(10),
	HOCHAM varchar(10), 
	GIOITINH varchar(3),
	NGSINH smalldatetime, 
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money, 
	MAKHOA varchar(4),
	FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);
--Tao bang lop
CREATE TABLE LOP
(
	MALOP char(3) primary key,
	TENLOP varchar(40), 
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4),
	FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV)
);
--Tao bang hoc vien
CREATE TABLE HOCVIEN
(
	MAHV char(5) primary key,
	HO varchar(40),
	TEN varchar(10), 
	NGSINH smalldatetime,
	GIOITINH varchar(3), 
	NOISINH varchar(40),
	MALOP char(3), 
	GHICHU varchar(100),
	DIEMTB numeric(4,2),
	XEPLOAI varchar(20),
	FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);
--Tao bang giang day
CREATE TABLE GIANGDAY
(
	MALOP char(3), 
	MAMH varchar(10),
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
	primary key (MALOP, MAMH),
	FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
	FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);
--Tao bang ket qua thi
CREATE TABLE KETQUATHI
(
	MAHV char(5),
	MAMH varchar(10),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10),
	primary key (MAHV, MAMH, LANTHI),
	FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
	FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);
--Them khoa ngoai bo sung
ALTER TABLE KHOA
ADD FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE LOP
ADD FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV);

--Cau 3
ALTER TABLE HOCVIEN
ADD CONSTRAINT check_GIOITINH CHECK(GIOITINH IN ('Nam','Nu'));

--Cau 4:
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_DIEM CHECK (DIEM >=0 AND DIEM <=10);

--Cau 5:
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_KQ CHECK ((DIEM >=5 AND KQUA = 'Dat') OR (DIEM < 5 AND KQUA = 'Khong dat'));

--Cau 6:
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_LANTHI CHECK (LANTHI <= 3);

--Cau 7:
ALTER TABLE GIANGDAY
ADD CONSTRAINT check_HOCKY CHECK (HOCKY BETWEEN 1 AND 3);

--Cau 8:
ALTER TABLE GIAOVIEN
ADD CONSTRAINT check_HOCVI CHECK (HOCVI IN ('CN', 'KS','Ths', 'TS', 'PTS'));


