create table UsersRoles(
	user_id int not null references Users(user_id)
		on delete cascade
		on update cascade,
	role_id smallint not null references Roles(role_id)
		on delete cascade
		on update cascade,
	constraint PK_UsersRoles primary key(user_id, role_id)	
)