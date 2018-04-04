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

    <title>Exercises</title>

    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/vendor/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/dataTables.bootstrap.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/daterangepicker.js"></script>

</head>
<body>


    <script type="text/javascript">
    $(document).ready(function($)
    {
        //ajax row data
        var ajax_data = $.ajax({
            type: 'get',
            url: 'tasks?taskType=EXERCISE',
            dataType: 'json',
            async: false,
            timeout: 50000
        }).responseJSON;

        //--->create data table > start
        var tbl = '';
        tbl +='<table id="tasks_table" class="table table-hover table-bordered">'

            //--->create table header > start
            tbl +='<thead>';
                tbl +='<tr align="center">';
                tbl +='<th>Name</th>';
                tbl +='<th>Description</th>';
                tbl +='<th>Topic</th>';
                tbl +='<th>Options</th>';
                tbl +='</tr>';
            tbl +='</thead>';
            //--->create table header > end


            //--->create table body > start
            tbl +='<tbody class="table_tbody">';

                //--->create table body rows > start
                $.each(ajax_data, function(index, val)
                {
                    //you can replace with your database row id
                    var row_id = val.id;

                    //loop through ajax row data
                    tbl +='<tr row_id="'+row_id+'" id="'+row_id+'">';
                        tbl +='<td ><div class="row_data" edit_type="click" col_name="name">'+val.name+'</div></td>';
                        tbl +='<td ><div class="row_data" edit_type="click" col_name="description">'+val['description']+'</div></td>';
                        tbl +='<td ><div class="row_data" edit_type="click" col_name="topic">'+val['topic']+'</div></td>';

                        //--->edit options > start
                        tbl +='<td align="center">';

                            tbl +='<span class="btn_edit" > <a href="#" class="btn btn-success" row_id="'+row_id+'" > Edit</a> </span>';
                            tbl +='<span class="btn_delete" > <a href="#" class="btn btn-danger" row_id="'+row_id+'" > Delete</a> </span>';

                            //only show this button if edit button is clicked
                            tbl +='<span class="btn_save"> <a href="#" class="btn btn-success"  row_id="'+row_id+'"> Save</a> | </span>';
                            tbl +='<span class="btn_cancel"> <a href="#" class="btn btn-warning" row_id="'+row_id+'"> Cancel</a>  </span>';

                        tbl +='</td>';
                        //--->edit options > end

                    tbl +='</tr>';
                });

                //--->create table body rows > end

            tbl +='</tbody>';
            //--->create table body > end

        tbl +='</table>'
        //--->create data table > end



        //out put table data
        $(document).find('.tbl_task_data').html(tbl);

        $(document).find('.btn_save').hide();
        $(document).find('.btn_cancel').hide();



        //--->add new row > start
        var addBtn = $('#add_new_task #btnAdd');

        addBtn.click(function (event) {
            var name = document.getElementById('nameId').value;
            var description = document.getElementById('descriptionId').value;
            var topic = document.getElementById('topicId').value;
            var post_data = JSON.stringify({"name" : name,
                                            "description" : description,
                                            "topic" : topic,
                                            "type" : "EXERCISE"
                                            });

            //stop submit the form, we will post it manually.
            event.preventDefault();

            // disabled the submit button
            addBtn.prop("disabled", true);

                //---> add new task on server > start
                $.ajax({
                    type: 'post',
                    url: 'tasks',
                    dataType: 'json',
                    data: post_data,
                    processData: false,
                    contentType: "application/json",
                    cache: false,
                    timeout: 5000,
                    success: function (data) {
                            //---> add row to table
                            var task_row_id = data.id;
                            var task_name = data.name;
                            var task_description = data.description;
                            var task_topic = data.topic;
                                    var tr = '';
                                    tr +='<tr row_id="'+task_row_id+'" id="'+task_row_id+'">';
                                    tr +='<td ><div class="row_data" edit_type="click" col_name="name">'+task_name+'</div></td>';
                                    tr +='<td ><div class="row_data" edit_type="click" col_name="description">'+task_description+'</div></td>';
                                    tr +='<td ><div class="row_data" edit_type="click" col_name="topic">'+task_topic+'</div></td>';

                                    //--->edit options > start
                                    tr +='<td align="center">';

                                        tr +='<span class="btn_edit" > <a href="#" class="btn btn-success" row_id="'+task_row_id+'" > Edit</a> </span>';
                                        tr +='<span class="btn_delete" > <a href="#" class="btn btn-danger" row_id="'+task_row_id+'" > Delete</a> </span>';

                                        //only show this button if edit button is clicked
                                        tr +='<span class="btn_save"> <a href="#" class="btn btn-success"  row_id="'+task_row_id+'"> Save</a> | </span>';
                                        tr +='<span class="btn_cancel"> <a href="#" class="btn btn-warning" row_id="'+task_row_id+'"> Cancel</a>  </span>';

                                    tr +='</td>';
                                    //--->edit options > end

                                tr +='</tr>';
                                $(document).find('.table_tbody').append(tr);
                                $(document).find('.btn_save').hide();
                                $(document).find('.btn_cancel').hide();


                            //---> add row to table
                        addBtn.prop("disabled", false);
                     },
                    error: function (e) {
                        addBtn.prop("disabled", false);
                    }
                });
                //----> add new tesk on server > end

        });
        //--->add new row > end


        //--->make div editable > start
        $(document).on('click', '.row_data', function(event)
        {
            event.preventDefault();

            if($(this).attr('edit_type') == 'button')
            {
                return false;
            }

            //make div editable
            $(this).closest('div').attr('contenteditable', 'true');
            //add bg css
            $(this).addClass('text-primary').css('padding','5px');

            $(this).focus();
        })
        //--->make div editable > end


        //--->save single field data > start
        $(document).on('focusout', '.row_data', function(event)
        {
            event.preventDefault();

            if($(this).attr('edit_type') == 'button')
            {
                return false;
            }

            var row_id = $(this).closest('tr').attr('row_id');
            var type = 'EXERCISE';

            var row_div = $(this)
            .removeAttr('contenteditable') //make div editable
            .removeClass('text-primary') //add bg css
            .css('padding','')

            var col_name = row_div.attr('col_name');
            var col_val = row_div.html();

            var arr = {};
            arr[col_name] = col_val;

            //use the "arr"	object for your ajax call
            //$.extend(arr, {row_id:row_id});
            $.extend(arr, {type: type});

            //out put to show
            $('.post_msg').html( '<pre class="bg-success">'+JSON.stringify(arr, null, 2) +'</pre>');

            //---> patch ajax call > start
                var json_data = JSON.stringify(arr, null, 2);

                $.ajax({
                    type: 'patch',
                    url: 'tasks/' + row_id,
                    dataType: 'json',
                    data: json_data,
                    processData: false,
                    contentType: "application/json",
                    timeout: 5000,
                    success: function (data) {
                    },
                    error: function (e) {
                    }
                });
                //---> ajax task call > end

        })
        //--->save single field data > end


        //--->button > delete > start
        $(document).on('click', '.btn_delete', function(event)
        {
        var row_id = $(this).closest('tr').attr('row_id');
        var row =  $(this).closest('tr').hide();

            $.ajax({
                    type: 'delete',
                    url: '/task_generator/tasks/' + row_id,
                    dataType: 'json',
                    timeout: 5000,
                    async: false,
                    success: function (data) {

                    },
                    error: function (e) {

                    }
                });

        });
        //--->button > delete > end


        //--->button > edit > start
        $(document).on('click', '.btn_edit', function(event)
        {
            event.preventDefault();
            var tbl_row = $(this).closest('tr');

            var row_id = tbl_row.attr('row_id');

            tbl_row.find('.btn_save').show();
            tbl_row.find('.btn_cancel').show();

            //hide edit/delete button
            tbl_row.find('.btn_edit').hide();
            tbl_row.find('.btn_delete').hide();

            //make the whole row editable
            tbl_row.find('.row_data')
            .attr('contenteditable', 'true')
            .attr('edit_type', 'button')
            .addClass('text-primary')
            .css('padding','3px')

            //--->add the original entry > start
            tbl_row.find('.row_data').each(function(index, val)
            {
                //this will help in case user decided to click on cancel button
                $(this).attr('original_entry', $(this).html());
            });
            //--->add the original entry > end

        });
        //--->button > edit > end


        //--->button > cancel > start
        $(document).on('click', '.btn_cancel', function(event)
        {
            event.preventDefault();

            var tbl_row = $(this).closest('tr');

            var row_id = tbl_row.attr('row_id');

            //hide save and cacel buttons
            tbl_row.find('.btn_save').hide();
            tbl_row.find('.btn_cancel').hide();

            //show edit / delete button
            tbl_row.find('.btn_edit').show();
            tbl_row.find('.btn_delete').show();

            //make the whole row editable
            tbl_row.find('.row_data')
            .attr('edit_type', 'click')
            .removeAttr('contenteditable')
            .removeClass('text-primary')
            .css('padding','')

            tbl_row.find('.row_data').each(function(index, val)
            {
                $(this).html( $(this).attr('original_entry') );
            });
        });
        //--->button > cancel > end


        //--->save whole row entery > start
        $(document).on('click', '.btn_save', function(event)
        {
            event.preventDefault();
            var tbl_row = $(this).closest('tr');

            var row_id = tbl_row.attr('row_id');
            var type = 'EXERCISE';

            //hide save and cacel buttons
            tbl_row.find('.btn_save').hide();
            tbl_row.find('.btn_cancel').hide();

            //show edit / delete button
            tbl_row.find('.btn_edit').show();
            tbl_row.find('.btn_delete').show();


            //make the whole row editable
            tbl_row.find('.row_data')
            .attr('edit_type', 'click')
            .removeAttr('contenteditable')
            .removeClass('text-primary')
            .css('padding','')

            //--->get row data > start
            var arr = {};
            tbl_row.find('.row_data').each(function(index, val)
            {
                var col_name = $(this).attr('col_name');
                var col_val  =  $(this).html();
                arr[col_name] = col_val;
            });
            //--->get row data > end

            //use the "arr"	object for your ajax call
            //$.extend(arr, {row_id:row_id});
            $.extend(arr, {type: type});

            //out put to show
            $('.post_msg').html( '<pre class="bg-success">'+JSON.stringify(arr, null, 2) +'</pre>')

                //---> update ajax call > start
                var json_data = JSON.stringify(arr, null, 2);

                $.ajax({
                    type: 'put',
                    url: 'tasks/' + row_id,
                    dataType: 'json',
                    data: json_data,
                    processData: false,
                    contentType: "application/json",
                    timeout: 5000,
                    success: function (data) {
                    },
                    error: function (e) {
                    }
                });
                //---> update ajax call > end
        });
        //--->save whole row entery > end

    });
    </script>

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
        <div>
          <p></p>
          <div class="panel-heading"><b>Form for adding a new task</b> </div>
          <div>
            <form method="post" class="form-inline" id="add_new_task">
                <div>
                    <input type="text" id="nameId" name="name" placeholder="Name" class="form-control">
                    <input type="text" id="descriptionId" name="description" placeholder="Description" class="form-control" size="58">
                    <input type="text" id="topicId" name="topic" placeholder="Topic" class="form-control">
                    <button type="button" class="btn btn-info" id="btnAdd">Add New</button>
                </div>
            </form>
          </div>
        </div>

        <div>
          <div class="panel-heading">
          <p></p>
          <p></p>
          <b>All exercises: </b> </div>

          <div>

            <div class="tbl_task_data"></div>

          </div>

        </div>


        <div style="display:none">
          <div class="panel-heading"><b>HTML Table Edits/Upates</b> </div>
          <div>
            <p>All the changes will be displayed below</p>
            <div class="post_msg"> </div>
          </div>
        </div>
    </div>
    </div>
</div>
</body>

</html>