
### Trigger de Mise à Jour de la Disponibilité des Voitures après une Réservation
#### Nom du Trigger : `update_dispo_voiture`
#### Événement : `AFTER INSERT` sur la table `Réservations`
#### Objectif :
- mettre la voiture en indisponible apres une reservation
#### Code SQL :
```
DELIMITER //
create trigger update_dispo_voiture
after insert
on Réservations
for each row
begin
update Voitures
set disponible = 0
where id = new.voiture_id;
end;
//
```


### Trigger de Vérification de la Validité du Permis de Conduire avant la création d'un nouveau client
#### Nom du Trigger : `verif_age_client`
#### Événement : `BEFORE INSERT` sur la table `Clients`
#### Objectif :
- vérifier l'âge du client et renvoyer un message d'erreur si celui-ci a moins de 21 ans
#### Code SQL :
```
DELIMITER //
create trigger verif_age_client
before insert
on Réservations
for each row
begin
if NEW.client_id not in (select Clients.id from Clients where age >= 21) then
signal sqlstate '45000'
set message_text = 'Le client doit avoir au moins 21 ans';
end if;
end;
//
```


### Trigger de vérification de validité du permis de conduire avant la création d'un nouveau client
#### Nom du Trigger : `verif_permis_client`
#### Événement : `BEFORE INSERT` sur la table `Clients`
#### Objectif :
- Vérifier le permis de conduire du client et renvoyer un message d'erreur selon la non-validité du permis
#### Code SQL :
```
DELIMITER //
create trigger verif_permis_client
before insert
on Clients
for each row
begin
if NEW.permis_conduire = '' then
signal sqlstate '45000'
set message_text = 'Le client doit avoir un permis de conduire';
end if;
if LENGTH(NEW.permis_conduire) <> 15 then
signal sqlstate '45000'
set message_text = 'Le permis de conduire doit avoir une longueur de 15 caractères';
end if;
if not NEW.permis_conduire REGEXP '^[A-Z0-9]{15}$' THEN
signal sqlstate '45000'
set message_text =
'Le numéro de permis de conduire doit être composé uniquement de caractères alphanumériques.';
end if;
end;
//
```


### Trigger de Vérification de la Disponibilité de la Voiture avant une Réservation
#### Nom du Trigger : `verif_dispo_voiture`
#### Événement : `BEFORE INSERT` sur la table `Réservations`
#### Objectif :
- vérifier la disponibilité de la voiture et renvoyer un message d'erreur si celle-ci n'est pas disponible
#### Code SQL :
```
DELIMITER //
create trigger verif_dispo_voiture
before insert
on Réservations
for each row
begin
declare dispo BOOLEAN;
select Voitures.disponible
into dispo
from Voitures
where id = new.voiture_id;
    if dispo = false then
        signal sqlstate '45000'
            set message_text = 'La voiture est indisponible';
    end if;
end
//
```


### Trigger pour Éviter les Chevauchements de Réservations sur la Mème Voiture
#### Nom du Trigger : `evite_chevauchement`
#### Événement : `BEFORE INSERT` sur la table `Réservations`
#### Objectif :
- vérifier s'il y'a un chevauchement de période de date de réservation de voiture
#### Code SQL :
```
DELIMITER //
create trigger evite_chevauchement
before insert on Réservations
for each row
begin
if exists(
select 1
from Réservations
where voiture_id = new.voiture_id
and date_debut < new.date_fin
and date_fin > new.date_debut
) then
signal sqlstate '45000'
set message_text = 'La voiture est indisponible (chevauchement dates)';
end if;
end //
```