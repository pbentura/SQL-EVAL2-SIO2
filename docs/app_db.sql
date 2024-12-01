-- Création de la table Voitures
CREATE TABLE Voitures
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    marque         VARCHAR(100) NOT NULL,
    modele         VARCHAR(100) NOT NULL,
    annee          INT          NOT NULL,
    disponible     BOOLEAN DEFAULT TRUE,
    en_maintenance BOOLEAN DEFAULT FALSE
);

-- Création de la table Clients
CREATE TABLE Clients
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    nom             VARCHAR(100)       NOT NULL,
    permis_conduire VARCHAR(20) UNIQUE NOT NULL,
    age             INT                NOT NULL
);

-- Création de la table Réservations
CREATE TABLE Réservations
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    client_id    INT  NOT NULL,
    voiture_id   INT  NOT NULL,
    date_debut   DATE NOT NULL,
    date_fin     DATE NOT NULL,
    nombre_jours INT,
    FOREIGN KEY (client_id) REFERENCES Clients (id),
    FOREIGN KEY (voiture_id) REFERENCES Voitures (id)
);

-- Création de la table HistoriqueRéservations
CREATE TABLE HistoriqueRéservations
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT         NOT NULL,
    date_action    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut         VARCHAR(50) NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES Réservations (id)
);

-- Insertion des données initiales dans la table Voitures
INSERT INTO Voitures (marque, modele, annee)
VALUES ('Toyota', 'Corolla', 2020),
       ('Ford', 'Focus', 2019),
       ('Volkswagen', 'Golf', 2021),
       ('Renault', 'Clio', 2018),
       ('Peugeot', '208', 2019);

-- Insertion des données initiales dans la table Clients
INSERT INTO Clients (nom, permis_conduire, age)
VALUES ('Marie Dubois', 'PERMIS12345', 25),
       ('Jean Martin', 'PERMIS67890', 19),
       ('Lucas Petit', 'PERMIS54321', 30),
       ('Emma Leroy', 'PERMIS09876', 22);