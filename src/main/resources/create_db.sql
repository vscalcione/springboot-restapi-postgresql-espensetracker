drop database expensetrackerdb;
drop user expensetracker;
create user expensetracker with password 'password';
create database expensetrackerdb with template=template0 owner=expensetracker;
\connect expensetrackerdb;
alter default privileges grant all on tables to expensetracker;
alter default privileges grant all on sequences to expensetracker;

create table expensetracker_users(
    user_id integer primary key not null,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    email varchar(20) not null,
    password text not null
);

create table expensetracker_catgories(
    category_id integer primary key not null,
    user_id integer not null,
    title varchar(20) not null,
    description varchar(50) not null
);

alter table expensetracker_catgories add constraint  category_users_fk
foreign key (user_id) references expensetracker_users(user_id);

create table expensetracker_transactions(
    transaction_id integer primary key not null,
    category_id integer not null,
    user_id integer not null,
    amount numeric(10,2) not null,
    note varchar(50) not null,
    transaction_date bigint not null
);

alter table expensetracker_transactions add constraint transaction_category_fk
foreign key (category_id) references expensetracker_catgories(category_id);

alter table expensetracker_transactions add constraint transaction_users_fk
foreign key (user_id) references expensetracker_users(user_id);

create sequence expensetracker_users_sequence increment 1 start 1;
create sequence expensetracker_categories_sequence increment 1 start 1;
create sequence expensetracker_transactions_sequence increment 1 start 1000;