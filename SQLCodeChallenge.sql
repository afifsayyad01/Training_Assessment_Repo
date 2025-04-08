create database Pet_Pals;

use pet_pals;


create table if not exists pets( petId INT primary key, name varchar(50), age int, breed varchar(30), Type varchar(30), AvailableForAdoption bit,ownerID int);
insert into pets(petid, name, age, breed, type, AvailableForAdoption, ownerId )
values(01,'Husky',11,'abc','cat',1,010),(02,'Bull',12,'def','Dog',0,020),(03,'Lab',13,'mno','Dog',1,030),(04,'French',14,'xyz','Cat',1,040),(05,'Percian',15,'ghi','Cat',0,050);


create table shelters(shelterID int primary key, name varchar(30), location varchar(30));
insert into shelters(shelterID, name, location)
values(111, 'abc', 'Chennai'), (222, 'def', 'Mumbai'),(333, 'lmn', 'Pune'),(444, 'opq', 'Hyderabad'),(555, 'mno', 'Nashik');

create table donations(DonationId int primary key, DonarName varchar(30), DonationType varchar(30), DonationAmount decimal(10,2), DonationItem varchar(30), DonationDate Datetime);
insert into donations(DonationId, DonarName, DonationType, DonationAmount, DonationItem, DonationDate)
values(123, 'Afif', 'cash', 50.000, 'Food', '2025-3-11 10:00:45'),(133, 'Utkarsh', 'cash', 30.000, 'Food', '2025-3-11 5:00:00'),(134, 'Sujal', 'cash', 15.000, 'Food', '2025-3-12 4:00:00'),(233, 'Uttam', 'online', 51.000, 'Cash', '2025-3-11 9:00:00'),
(163, 'Kaustubh', 'online', 60.000, 'Cash', '2025-3-11 9:00:00');

create table AdoptionEvents(EventID int primary key, EventName varchar(30), EventDate datetime, Location varchar(30));
insert into adoptionEvents(EventID, EventName, EventDate, Location)
values(12345, 'Adoption1', '2025-3-11','Chennai'),(23456, 'Adoption2', '2025-3-11','Mumbai'),(34567, 'Adoption2', '2025-3-11','Pune'),
(45678, 'Adoption3', '2025-3-11','Nashik'),(56789, 'Adoption4', '2025-3-11','Bangalour');

create table participants(participantID int primary key, participantName varchar(30), ParticipantType varchar(30), eventID int, Foreign Key (eventId) references AdoptionEvents(eventID));
insert into participants(participantID, participantName, ParticipantType,eventID)
values(135, 'Abc','Men',12345),(139, 'bcd','Men',23456);



select name, age, breed, type
from pets
where AvailableForAdoption = 1;

-------------------------------------------------

select p.participantname, p.participantType
from participants p
join adoptionevents e
on p.eventId = e.eventId
where e.eventId =?;

--------------------------------------------------

select s.name as sheltername, sum(d.DonationAmount) as total_donation
from shelters s
left join donations d
on s.shelterID = d.donationID
group by s.Name;

select * from donations;

------------------------------------------------------

select name, age, breed, type
from pets
where ownerId is null;

-------------------------------------------

select date_format(donationDate, '%M Y%') as monthyear,
coalesce(sum(donationAmount),0) as totalDonation
from donations
group by monthyear;

------------------------------------------------

select distinct breed
from pets
where age between 1 and 3 or age >5;

-----------------------------------------------

select p.name, p.breed, p.type, s.name as sheltername
from pets p
join shelters s 
on p.ownerid = s.shelterid
where p.AvailableForAdoption =1;

--------------------------------------------------

select breed 
from pets
where age between 1 and 5;

----------------------------------------------

select name, age, breed, type
from pets
where ownerId is null;

------------------------------------

select p.name as petname, pa.participantname as adopterName
from pets p
join participants pa 
on p.ownerid = pa.participantid;

--------------------------------------------------
select s.name as shelter_name, count(p.petid) as availablepets
from shelters s
left join pets p
on s.shelterid = p.petid and p.AvailableForAdoption = 1

--------------------------------------------------

select p1.name as pet1, p2.name as pet2, p1.breed, s.name as sheltername
from pets p1
join pets p2 
on p1.breed=p2.breed and p1.petid < p2.petid
join shelters s
on p1.petID=s.shelterid
group by s.name;

-----------------------------------
select s.name as shelterName, e.eventname
from shelters s
cross join adoptionevents e;

------------------------------------

select s.name as shelterName, count(p.petID) as adoptedPets
from shelters s 
join pets p
on s.shelterID = p.petID
where p.AvailableForAdoption = 0
group by s.name
order by Adoptedpets desc
limit 1;

-----------------------------------------------------
