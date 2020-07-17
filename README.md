## springboot-restapi-postgresql-expensetracker

![java-logo](https://img.icons8.com/color/96/000000/java-coffee-cup-logo.png)
![soring-boot-logo](https://img.icons8.com/color/96/000000/spring-logo.png)
![restapi](https://img.icons8.com/nolan/96/api-settings.png)
![postgresql](https://img.icons8.com/color/96/000000/postgreesql.png)
![database](https://img.icons8.com/fluent/96/000000/database.png)

This is REST API application developed in Java with Spring Boot Framework.
For the testing of APIs, you can use <b>Postman, Insomnia</b>, all free softwares that can tests all HTTP Methods on this 
REST API

### Initialization (Docker-container's startup)
Install <b>docker</b> and <b>docker-compose</b> on your machine </li>
<br>

You can visit https://docs.docker.com/get-docker/ for documentation of your OS's install setup
<br>

Run this command on your shell for download locally postresql's container
```bash
$ docker container run --name postgresql -e POSTGRES_PASSWORD=admin -d -p 5432:5432 postgres
```

### Create PostgreSQL database
Now, clone the repository with command:
```bash
$ git clone https://github.com/vscalcione/springboot-restapi-postgresql-expensetracker.git
$ cd springboot-restapi-postgresql-expensetracker/src/main/resources
$ docker cp create_db.sql postgresdb:/
$ docker container exec -it postgresdb bash
$ psql -U postgres --file create_db.sql
```

### Add user 
<b>GET http://localhost:8080/api/users/register </b><br>
```json 
{ 
    "firstName": "David", 
    "lastName": "Smith",
    "email": "d.smith@gmail.com",
    "password": "test123"
}
```
Return this response:
```json
{
    "message": "registered successfully"
}
```
If you type an email with invalid format, the response is like the 1st part of json and, If type the same email for 2 or
more times, the response is like the last part of json :
```json
{
    "status": 401,
    "error": "Unauthorized",
    "message": "Invalid email format",
    "path": "/api/users/register"
}
```
```json
{
    "status": 401,
    "error": "Unauthorized",
    "message": "Email already in use",
    "path": "/api/users/register"
}
```

For verify the executed query, type this command on the bash:
```bash
$ docker container exec -it postgresdb psql -U postgres
$ \connect expensetrackerdb;
$ select * from expensetracker_users;
```

### Login and hashes password
For a correct use of the <b>Add-User/Login</b> functionality, use different data for the registration of an user or run this command:
```sql
delete from expensetracker_users;
select * from expensetracker_users;
```

<b>POST http://localhost:8080/api/users/login </b><br>
```json 
{ 
    "email": "d.smith@gmail.com",
    "password": "test123"
}
```
Return this response:
```json
{
    "message": "logged in successfully"
}
```
If you pass on request an email or password that not are equals of users validated, the response is like:
```json
{
    "timestamp": "2020-07-16T21:49:19.815+00:00",
    "status": 401,
    "error": "Unauthorized",
    "trace": "message",
    "message": "Invalid email/password",
    "path": "/api/users/login"
}
```
Now password are stored with hash encryption, but the user can do login with entered password by this.

