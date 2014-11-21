create table Roles(
	role_id smallint not null identity (1, 1) primary key,
	name varchar(50) not null unique
)