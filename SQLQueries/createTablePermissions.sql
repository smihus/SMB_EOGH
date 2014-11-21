create table Permissions(
	role_id smallint not null references Roles(role_id) 
		on delete cascade
		on update cascade,
	object_id int not null references Objects(object_id)
		on delete cascade
		on update cascade,
	c bit not null default 0,
	r bit not null default 0,
	u bit not null default 0,
	d bit not null default 0,
	constraint PK_Permissions primary key(role_id, object_id)
)