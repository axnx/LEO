
CREATE TABLE EXPORTDMS (
	id INT IDENTITY NOT NULL PRIMARY KEY,
	filename VARCHAR(50) NOT NULL,
	mandant VARCHAR(50) NOT NULL,
	belegkat VARCHAR(50) NOT NULL,
	belegtyp VARCHAR(50) NOT NULL,
	belegnr VARCHAR(50) NOT NULL,
	belegdatum DATE NOT NULL,
	belegEmf VARCHAR(50) NOT NULL
);

INSERT INTO EXPORTDMS
(filename, mandant, belegkat, belegtyp, belegnr, belegdatum, belegEmf)
VALUES
('RE1234_1.pdf','ABC GmbH','Kunden','Rechnungen','RE1234',GETDATE(),'DEF Kunden-Service GmbH'),
('RE1234_2.pdf','ABC GmbH','Kunden','Rechnungen','RE1234',GETDATE(),'DEF Kunden-Service GmbH'),
('RE1235_1.pdf','ABC GmbH','Kunden','Rechnungen','RE1235',GETDATE(),'DEF Kunden-Service GmbH'),
('RE1236_1.pdf','ABC GmbH','Kunden','Rechnungen','RE1236',GETDATE(),'DEF Kunden-Service GmbH'),
('RE1237_1.pdf','ABC GmbH','Kunden','Rechnungen','RE1237',GETDATE(),'DEF Kunden-Service GmbH');