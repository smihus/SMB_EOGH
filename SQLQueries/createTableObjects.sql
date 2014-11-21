create table Objects(
	object_id int not null identity (1, 1) primary key,
	parent_id int null references Objects(object_id),
	name varchar(100) not null,
	label varchar (100) not null,
	constraint unique_parent_id_and_name unique (parent_id, name)
)