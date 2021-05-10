create table task (
    id bigserial not null constraint task_pkey primary key,
	name varchar(255),
	type varchar(255),
	description text,
	topic varchar(255)
);

