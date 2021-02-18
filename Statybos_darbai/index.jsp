<!DOCTYPE html>
<title>Statybos!</title>
<head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<style>
 label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
body {
	background-image: url('https://i.pinimg.com/originals/0c/84/9f/0c849f8b64bceaac0872d96b6d45ccdb.jpg');
	font-family: arial black;
	background-repeat: no-repeat;
	background-size:cover;
	background-attachment:fixed;
	background-position:center;
	background-color:black;
}
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: powderblue;
  color: white;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>
  $( function() {
    var dialog, form,
 
      // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
      emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
      name = $( "#name" ),
      email = $( "#email" ),
      password = $( "#password" ),
      allFields = $( [] ).add( name ).add( email ).add( password ),
      tips = $( ".validateTips" );
 
    function updateTips( t ) {
      tips
        .text( t )
        .addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
 
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
        o.addClass( "ui-state-error" );
        updateTips( "Length of " + n + " must be between " +
          min + " and " + max + "." );
        return false;
      } else {
        return true;
      }
    }
 
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
        o.addClass( "ui-state-error" );
        updateTips( n );
        return false;
      } else {
        return true;
      }
    }
 
    function addUser() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
 
      valid = valid && checkLength( name, "username", 3, 16 );
      valid = valid && checkLength( email, "email", 6, 80 );
      valid = valid && checkLength( password, "password", 5, 16 );
 
      valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( email, emailRegex, "eg. ui@jquery.com" );
      valid = valid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
 
      if ( valid ) {
        $( "#users tbody" ).append( "<tr>" +
          "<td>" + name.val() + "</td>" +
          "<td>" + email.val() + "</td>" +
          "<td>" + password.val() + "</td>" +
        "</tr>" );
        dialog.dialog( "close" );
      }
      return valid;
    }
 
    dialog = $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 400,
      width: 350,
      modal: true,
      buttons: {
        "Pridėti": addUser,
        "Atšaukti": function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
        allFields.removeClass( "ui-state-error" );
      }
    });
 
    form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addUser();
    });
 
    $( "#create-user" ).button().on( "click", function() {
      dialog.dialog( "open" );
    });
  } );
  </script>
<script>
function Redagavimas() {
  alert("Reik iššokančio lango");
}
</script
</head>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "statybos";
String userid = "root";
String password = "";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<html>
<body>
<center>
<h1 style="color:powderblue;"><b>Darbai</b></h1>
<table id="customers" border="1">
<tr>
<th>Id</td>
<th style="text-align: center; vertical-align: middle;">Tipas</th>
<th style="text-align: center; vertical-align: middle;">Pavadinimas</th>
<th style="text-align: center; vertical-align: middle;">Kvadratūrą_kv_m</th>
<th style="text-align: center; vertical-align: middle;">Numatomi_darbai</th>
<th style="text-align: center; vertical-align: middle;">Pradžia</th>
<th style="text-align: center; vertical-align: middle;">Numatoma_pabaiga</th>
<th colspan=2></th>
</tr>
<%
try{
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");	
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="SELECT * FROM `darbai` WHERE 1";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("id") %></td>
<td><%=resultSet.getString("tipas") %></td>
<td><%=resultSet.getString("pav") %></td>
<td><%=resultSet.getString("kvadratūrą_kv_m") %></td>
<td><%=resultSet.getString("numatomi_darbai") %></td>
<td><%=resultSet.getString("pradžia") %></td>
<td><%=resultSet.getString("numatoma_pabaiga") %></td>
<td><input type="button" class="record_edit" value="&#9998;" onClick="Redagavimas()"></td>
<td><input type="button" class="delete" value="&#10007;" onClick="Trinti()"></td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
<div id="dialog-form" title="Pridėti planuojamus darbus">
  <p class="validateTips">Privaloma užpildyti visus laukelius</p>
 
  <form>
    <fieldset>
      <label for="name">Tipas</label>
      <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Pavadinimas</label>
      <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Kvadratūrą_kv_m</label>
      <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Numatomi_darbai</label>
      <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Pradžia</label>
      <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Numatoma_pabaiga</label>
      <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all">
	  
 
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>
<button id="create-user">Pridėti planuojamus darbus</button>
</body>
</html>