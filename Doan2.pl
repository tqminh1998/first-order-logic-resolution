Domains
Person, Child,Gender,Date_borned,Date_died, Husband,Wife,Parent,GP,GC,GM,GF,GS,GD,Sibling,NiNe,AuUn,Person1,Person2,X,Y

.
%Queen Elizebeth II
female('Queen Elizabeth II').
birthday('Queen Elizabeth II',1926).
%Prince Phillip
male('Prince Phillip').
birthday('Prince Phillip',1921).
%Princess Diana
female('Princess Diana').
birthday('Princess Diana',1961).
deadday('Princess Diana',1997).
%Prince Charles
male('Prince Charles').
birthday('Prince Charles',1948).
%Camilla Parker Bowles
female('Camilla Parker Bowles').
birthday('Camilla Parker Bowles',1947).
%Captain Mark Phillips
male('Captain Mark Phillips').
birthday('Captain Mark Phillips',1948).
%Princess Anne
female('Princess Anne').
birthday('Princess Anne',1950).
%Timothy Laurence
male('Timothy Laurence').
birthday('Timothy Laurence',1955).
%Sarah Ferguson
female('Sarah Ferguson').
birthday('Sarah Ferguson',1959).
%Prince Andrew
male('Prince Andrew').
birthday('Prince Andrew',1960).
%Sophie Rhys-jones
female('Sophie Rhys-jones').
birthday('Sophie Rhys-jones',1965).
%Prince Edward
male('Prince Edward').
birthday('Prince Edward',1964).
%Prince William
male('Prince William').
birthday('Prince William',1982).
%Kate Middleton
female('Kate Middleton').
birthday('Kate Middleton',1982).
%Prince Harry
male('Prince Harry').
birthday('Prince Harry',1984).
%Autumn Kelly
female('Autumn Kelly').
birthday('Autumn Kelly',1978).
%Peter Phillips
male('Peter Phillips').
birthday('Peter Phillips',1977).
%Zara Phillips
female('Zara Phillips').
birthday('Zara Phillips',1981).
%Mike Tindall
male('Mike Tindall').
birthday('Mike Tindall',1978).
%Princess Beatrice
female('Princess Beatrice').
birthday('Princess Beatrice',1988).
%Princess Eugenie
female('Princess Eugenie').
birthday('Princess Eugenie',1990).
%James, Viscount Severn
male('James, Viscount Severn').
birthday('James, Viscount Severn',2007).
%Lady Louise Mountbattern-Windsor
female('Lady Louise Mountbattern-Windsor').
birthday('Lady Louise Mountbattern-Windsor',2003).
%Prince George
male('Prince George').
birthday('Prince George',2013).
%Princess Charlotte
female('Princess Charlotte').
birthday('Princess Charlotte',2015).
%Savannah Phillips
female('Savannah Phillips').
birthday('Savannah Phillips',2010).
%Isla Phillips
female('Isla Phillips').
birthday('Isla Phillips',2012).
%Mia Grace Tindall
male('Mia Grace Tindall').
birthday('Mia Grace Tindall', 2014).
%!  %%%%%%%%
%!  Married%
%!  %%%%%%%%
married('Queen Elizabeth II','Prince Phillip').
married('Prince Phillip','Queen Elizabeth II').
married('Prince Charles','Camilla Parker Bowles').
married('Camilla Parker Bowles','Prince Charles').
married('Princess Anne','Timothy Laurence').
married('Timothy Laurence','Princess Anne').
married('Sophie Rhys-jones','Prince Edward').
married('Prince Edward','Sophie Rhys-jones').
married('Prince William','Kate Middleton').
married('Kate Middleton','Prince William').
married('Autumn Kelly','Peter Phillips').
married('Peter Phillips','Autumn Kelly').
married('Zara Phillips','Mike Tindall').
married('Mike Tindall','Zara Phillips').
married('Princess Diana','Prince Charles').
married('Prince Charles','Princess Diana').
married('Princess Anne','Captain Mark Phihllips').
married('Captain Mark Phillips','Princess Anne').
married('Sarah Ferguson','Prince Andrew').
married('Prince Andrew','Sarah Ferguson').

%!  %%%%%%%%%
%!  Divorced%
%!  %%%%%%%%%
divorced('Princess Diana','Prince Charles').
divorced('Princess Anne','Captain Mark Phihllips').
divorced('Sarah Ferguson','Prince Andrew').
%!  %%%%%%%%%%%%%%%
%!  Parent%%%%%%%%%
%!  %%%%%%%%%%%%%%%
parent('Queen Elizabeth II','Prince Charles').
parent('Prince Phillip','Prince Charles').
parent('Queen Elizabeth II','Princess Anne').
parent('Prince Phillip','Princess Anne').
parent('Prince Phillip','Prince Andrew').
parent('Queen Elizabeth II','Prince Andrew').
parent('Prince Phillip','Prince Edward').
parent('Queen Elizabeth II','Prince Edward').
parent('Princess Diana','Prince William').
parent('Prince Charles','Prince William').
parent('Princess Diana','Prince Harry').
parent('Prince Charles','Prince Harry').
parent('Captain Mark Phillips','Peter Phillips').
parent('Princess Anne','Peter Phillips').
parent('Captain Mark Phillips','Zara Phillips').
parent('Princess Anne','Zara Phillips').
parent('Sarah Ferguson','Princess Beatrice').
parent('Prince Andrew','Princess Beatrice').
parent('Sarah Ferguson','Princess Eugenie').
parent('Prince Andrew','Princess Eugenie').
parent('Prince Edward','James, Viscount Severn').
parent('Sophie Rhys-jones','James, Viscount Severn').
parent('Prince Edward','Lady Louise Mountbatten Windsor').
parent('Sophie Rhys-jones','Lady Louise Mountbatten Windsor').
parent('Prince William','Prince George').
parent('Kate Middleton','Prince George').
parent('Prince William','Princess Charlotte').
parent('Kate Middleton','Princess Charlotte').
parent('Autumn Kelly','Savannah Phillips').
parent('Peter Phillips','Savannah Phillips').
parent('Peter Phillips','Isla Phillips').
parent('Autumn Kelly','Isla Phillips').
parent('Zara Phillips','Mia Grace Tindall').
parent('Mike Tindall','Mia Grace Tindall').

%!  %%%%%%%%%%%%%%%
%!  Add Predicates%
%!  %%%%%%%%%%%%%%%
%
husband(Person,Wife):-married(Person,Wife),male(Person).
wife(Person,Husband):-husband(Husband,Person).
father(Person,Child):-parent(Person,Child),male(Person).
mother(Person,Child):-parent(Person,Child),female(Person).
child(Person,Parent):-parent(Parent,Person).
son(Child,Parent):-child(Child,Parent),male(Child).
daughter(Child,Parent):-child(Child,Parent),female(Child).
grandparent(GP,GC):-parent(GP,X),parent(X,GC).
grandmother(GM,GC):-grandparent(GM,GC),female(GM).
grandfather(GF,GC):-grandparent(GF,GC),male(GF).
grandchild(GC,GP):-grandparent(GP,GC).
grandson(GS,GP):-grandchild(GS,GP),male(GS).
granddaughter(GD,GP):-grandchild(GD,GP),female(GD).
sibling(Person1,Person2):-parent(X,Person1),parent(X,Person2).
brother(Person,Sibling):-sibling(Person,Sibling),male(Person).
sister(Person,Sibling):-sibling(Person,Sibling),female(Person).
aunt(Person,NiNe):-sibling(Person,X),parent(X,NiNe),female(Person).
uncle(Person,NiNe):-sibling(Person,X),parent(X,NiNe),male(Person).
niece(Person,AuUn):-child(Person,X),sibling(X,AuUn),female(Person).
nephew(Person,AuUn):-child(Person,X),sibling(X,AuUn),male(Person).