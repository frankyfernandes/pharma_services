<html>
<?php
include_once('connection.php');
?>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="style/css/bootstrap.min.css">
<script src="style/js/bootstrap.min.js"></script>
<script src="js/jquery-3.4.js"></script>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />

<style>
h2 {
  text-align: center;
}

table caption {
	padding: .5em 0;
}

@media screen and (max-width: 767px) {
  table caption {
    border-bottom: 1px solid #ddd;
  }
}

.p {
  text-align: center;
  padding-top: 140px;
  font-size: 14px;
}
</style>
<script>
function displayRecords()
{
	var date_chosen = $('#datepicker').val();
	var yourdate = date_chosen.split("-").reverse();
	var tmp = yourdate[2];
	yourdate[2] = yourdate[1];
	yourdate[1] = tmp;
	yourdate = yourdate.join("-");
	
	$.ajax({
	  url: "request_data.php",
	  type: "POST",
	  data: "date="+yourdate,
	}).done(function(data){
            // console.log(data); 
			$('.table-bordered').html(data);	
        })
        .fail(function() {
         
            // just in case posting your form failed
            alert( "Posting failed." );
             
        });
}
</script>
</head>
<h2>Company Details</h2>
<div class="row" style="height:30px;"></div>
<div class="container">

<div class="row">
<div class = "col-md-3"></div>
<div class = "col-md-2"><label >Select Date:</label></div>
<div class="col-md-2">
 <input type="text" class="form" id="datepicker" width="276" onchange="displayRecords();"/>
<script>
        $('#datepicker').datepicker({
			format: 'mm-dd-yyyy',
			autoclose:true,
			disableDates:  function (date) {
				var today = new Date();
				if(date > today)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
		});
</script>
</div>
</div>

  <div class="row">
   
      <div class="table-responsive">
        <table class="table-bordered">
          
		  </div>
        </table>
      
  
  </div>
</div>
</html>