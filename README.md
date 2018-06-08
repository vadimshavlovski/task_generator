### Application
It is a simple web application for tasks generation :sunglasses: :sunny: 

### Technologies
- Java 8
- Hibernate 5
- Spring Framework  4 (DI & IoC, MVC)
- MySql
- jQery, Ajax

### REST API

CRUD API + */random?taskType={taskType}*  endpoint:

| URI                             | Method     | Description                            |
| ---------------------           | ----       | ------------------------               |
|*/tasks/{taskId}*                | **GET**    | Get  task by id                        | 
|*/tasks/*                        | **POST**   | Add new task                           | 
|*/tasks/{taskId}*                | **PUT**    | Modify task by id                      | 
|*/tasks/{taskId}*                | **PATCH**  | Merge task by id                       | 
|*/tasks/{taskId}*                | **DELETE** | Delete task by id                      | 
|*/random?taskType={taskType}*    | **GET**    | Get random task by task type (exercise or question)| 
|                                 |            |                                        |  

### User Interface

**1. Random Task Generator page:**

   **Generate tasks** button generates one question and exercise that are taken from DB randomly 

   <img src="https://github.com/vadimshavlovski/task_generator/blob/master/src/main/webapp/resources/images/task_generator.png" width="700">


**2. Questions page:**

   Page for adding, modifying and deleting **questions**
    
   <img src="https://github.com/vadimshavlovski/task_generator/blob/master/src/main/webapp/resources/images/questions.png" width="700">
   
   There is in-place editing feature (the PATCH method of REST API was used):
   
   <img src="https://github.com/vadimshavlovski/task_generator/blob/master/src/main/webapp/resources/images/in_place_editing.png" width="700">
   
 
 **3. Exercises page:**
 
   Page for adding, modifying and deleting **exercises**
    
   <img src="https://github.com/vadimshavlovski/task_generator/blob/master/src/main/webapp/resources/images/exercises.png" width="700">
