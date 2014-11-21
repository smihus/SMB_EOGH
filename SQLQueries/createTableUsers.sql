create table Users(
	user_id int not null identity (1, 1) primary key,
	login_name varchar(50) not null unique	
)