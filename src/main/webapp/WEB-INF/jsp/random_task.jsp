<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/daterangepicker-bs3.css" rel="stylesheet">

    <title>Random task generator</title>

    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/vendor/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/dataTables.bootstrap.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/daterangepicker.js"></script>

    <script type="text/javascript" charset="utf-8">
        $(document).ready(function() {

            // common selectors
            var generateTasksBtn = $('#generator #generateTasksBtn');


            // find customer button handler
            generateTasksBtn.click(function (event) {

                //stop submit the form, we will post it manually.
                event.preventDefault();

                $("#question > p").empty();
                $("#exercise > p").empty();
                $("#error > p").empty();
                $("#question").hide();
                $("#exercise").hide();
                $("#error").hide();

                $("#find_loader").show();

                // disabled the submit button
                generateTasksBtn.prop("disabled", true);

                // get random question
                $.ajax({
                    type: 'get',
                    url: '/task_generator/tasks/random?taskType=QUESTION',
                    dataType: 'json',
                    timeout: 600000,
                    success: function (data) {
                        $("#question").show();
                        $("#question > p").append(data.description);
                        generateTasksBtn.prop("disabled", false);
                    },
                    error: function (e) {
                        $("#error").show();
                        $("#error > p").append(e.responseText);
                        generateTasksBtn.prop("disabled", false);
                    }
                });

                //get random exercise
                $.ajax({
                    type: 'get',
                    url: '/task_generator/tasks/random?taskType=EXERCISE',
                    dataType: 'json',
                    timeout: 600000,
                    success: function (data) {
                        $("#exercise").show();
                        $("#exercise > p").append(data.description);
                        generateTasksBtn.prop("disabled", false);
                    },
                    error: function (e) {
                        $("#error").show();
                        $("#error > p").append(e.responseText);
                        generateTasksBtn.prop("disabled", false);
                    }
                });

            $("#find_loader").hide();
            });

        });
    </script>
</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="random_task">Random Task Generator</a>
        </div>
        <div class="navbar-header navbar-brand" >
           |
        </div>
        <div class="navbar-header">
             <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"></button>
             <a class="navbar-brand" href="questions">Questions</a>
        </div>
        <div class="navbar-header navbar-brand" >
           |
        </div>
        <div class="navbar-header">
             <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"></button>
             <a class="navbar-brand" href="exercises">Exercises</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">

        <div class="col-sm-9 col-sm-offset-3 col-md-8 col-md-offset-2 main">
            <h2 class="sub-header">
                Random Task Generator
            </h2>

            <p>Welcome to the Task Generator. Please click on the Generate tasks button</p>

            <form:form id="generator" method="post" enctype="multipart/form-data" action="random_task/">
                <p></p>
                <input type="button" id="generateTasksBtn" class="btn btn-primary" value="Generate tasks"/>
            </form:form>

            <div id="find_loader" style="display:none">
                <p></p>
                <p>Finding tasks....</p>
                <p><img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif" alt="wait"></p>
            </div>

            <p></p>
            <div id = "question" style="display:none">
                <font color="#337ab7">Question:
                </font>
                <p></p>
            </div>

            <p></p>
            <div id = "exercise" style="display:none">
                <font color="#337ab7">Exercise:
                </font>
                <p></p>
            </div>

            <p></p>
            <div id = "error" style="display:none">
                <font color="#337ab7">Error:
                </font>
                <p></p>
            </div>

         </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
