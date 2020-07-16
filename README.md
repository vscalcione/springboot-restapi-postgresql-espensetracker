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
    "trace": "it.vscalcione.springboot.restapi.exceptions.EtAuthException: Invalid email/password\n\tat it.vscalcione.springboot.restapi.repositories.UserRepositoryImpl.findByEmailAndPassword(UserRepositoryImpl.java:50)\n\tat it.vscalcione.springboot.restapi.repositories.UserRepositoryImpl$$FastClassBySpringCGLIB$$1741ae0.invoke(<generated>)\n\tat org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n\tat org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\n\tat org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\n\tat org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:139)\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n\tat org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\n\tat org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\n\tat it.vscalcione.springboot.restapi.repositories.UserRepositoryImpl$$EnhancerBySpringCGLIB$$8cf7573f.findByEmailAndPassword(<generated>)\n\tat it.vscalcione.springboot.restapi.services.UserServiceImpl.validateUser(UserServiceImpl.java:23)\n\tat it.vscalcione.springboot.restapi.services.UserServiceImpl$$FastClassBySpringCGLIB$$d2d8b455.invoke(<generated>)\n\tat org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n\tat org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\n\tat org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\n\tat org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:367)\n\tat org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n\tat org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\n\tat org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\n\tat it.vscalcione.springboot.restapi.services.UserServiceImpl$$EnhancerBySpringCGLIB$$c84f39cf.validateUser(<generated>)\n\tat it.vscalcione.springboot.restapi.resources.UserResource.loginUser(UserResource.java:27)\n\tat sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n\tat sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n\tat sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n\tat java.lang.reflect.Method.invoke(Method.java:498)\n\tat org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\n\tat org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n\tat org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\n\tat org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\n\tat org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\n\tat org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n\tat org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\n\tat org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\n\tat org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\n\tat org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\n\tat javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\n\tat org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\n\tat javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n\tat org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n\tat org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n\tat org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n\tat org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n\tat org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n\tat org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\n\tat org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\n\tat org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n\tat org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n\tat org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\n\tat org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\n\tat org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n\tat org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n\tat org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\n\tat org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\n\tat org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n\tat org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n\tat org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\n\tat org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n\tat org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\n\tat org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n\tat org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n\tat org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n\tat org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n\tat org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\n\tat org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\n\tat org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\n\tat org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\n\tat org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n\tat org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\n\tat java.lang.Thread.run(Thread.java:748)\n",
    "message": "Invalid email/password",
    "path": "/api/users/login"
}
```
Now password are stored with hash encryption, but the user can do login with entered password by this.

