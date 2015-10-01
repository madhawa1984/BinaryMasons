<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
  		<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  		<style type="text/css">
  			.container-fluid{border-width: 1px; border-style: solid;margin: 5px; padding: 5px;}
  			.boder{border-width: 1px; border-style:solid;}
  			#droppableArea{height: 1007px}
  			.dragable{};
  		</style>	
	</head>
	<body>
	<div class="container-fluid row">
		<div class="col-md-9" id="editorContainer">
			<div class="col-md-3 boder">
				<ul class="list-group">
				  <li class="list-group-item">
					<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title">Buttons</h3>
					  </div>
					  <div class="panel-body">
					  	<ul class="list-group">
				  			<li class="list-group-item" id="draggableButtonContainer-1">
				  				<div id="draggableButton-0" class="btn btn-default dragable" type="submit">Button</div>  
				  			</li>
				  			<li class="list-group-item" id="draggableLinkContainer-1">
				  				<a id="draggableLink-0" class="btn btn-link dragable" data-toggle="popover" data-placement="bottom" data-content="Content">Link</a>  
				  			</li>
				  		</ul>
					  </div>
					</div>	
				  </li>
				  <li class="list-group-item">
					<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title">lables</h3>
					  </div>
					  <div class="panel-body">
					  	<ul class="list-group">
				  			<li class="list-group-item" id="draggableLableContainer-1">
				  				<div id="draggableLable-0" class="dragable" ><h1>Default lable</h1></div> 
				  			</li>
				  			<li class="list-group-item" id="draggableLableContainer-2">
				  				<div id="draggableLable-0" class="dragable" ><h2>Default lable</h2></div> 
				  			</li>
				  			<li class="list-group-item" id="draggableLableContainer-3">
				  				<div id="draggableLable-0" class="dragable" ><h3>Default lable</h3></div> 
				  			</li>
				  			<li class="list-group-item" id="draggableLableContainer-4">
				  				<div id="draggableLable-0" class="dragable" ><h4>Default lable</h4></div> 
				  			</li>
				  		</ul>
					  </div>
					</div>
				  </li>
				  <li class="list-group-item">
					<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title">Input Feilds</h3>
					  </div>
					  <div class="panel-body">
					  	<ul class="list-group">
				  			<li class="list-group-item" id="draggableInputTextContainer-1">
				  				<div id="draggableInputText-0" >
					  				<form>
										<input type="text" class="form-control" placeholder="Input Text">
					  				</form>
				  				</div>
				  			</li>
				  			<li class="list-group-item" id="draggableInputTextAreaContainer-1">
				  				<div id="draggableInputTextArea-0" >
					  				<form>
										<textarea class="form-control" rows="3" placeholder="Input Text Area"></textarea>
					  				</form>
				  				</div>
				  			</li>
				  		</ul>
					  </div>
					</div>	
				  </li>
				</ul>

			</div>
			<div class="boder col-md-9" id="droppableArea">
			</div>
	
		</div>
		<div class="col-md-3 boder" style="height:1007px;" id="chatContainer">
		&nbsp;&nbsp;
		</div>
	</div>





		<script type="text/javascript" src="scripts/jquery-2.1.4.min.js" ></script>
		<script type="text/javascript" src="scripts/jquery-ui.js" ></script>
		<script type="text/javascript" src="scripts/bootstrap.min.js" ></script>
		<script src="http://cdn.jsdelivr.net/sockjs/1.0.0/sockjs.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
		<script type="text/javascript" src="/scripts/operations.js"></script>
		<script type="text/javascript">
             String.prototype.contains = function(it) { return this.indexOf(it) != -1; };
			 $(function() {
			    $( ".dragable").draggable({revert: "invalid"});
			    $("#draggableInputText-0").draggable({ cancel: null },{revert: "invalid"});
			    $("#draggableInputTextArea-0").draggable({ cancel: null },{revert: "invalid"});
			    $( "#droppableArea" ).droppable({
			    	drop: function( event, ui ){
			    		//console.log(ui.draggable);
			    		var parentElementID = ui.draggable.parent().attr('id');
			    		var idElements = ui.draggable.attr('id').split('-');
			    		var iDIndex = (parseInt(idElements[1]) + 1 );

			    		if(parentElementID.contains("draggableButtonContainer")){
				    		$('<div id="draggableButton-' + iDIndex +'"  class="btn btn-default dragable">Button </div>').appendTo("#" + parentElementID).draggable({revert: "invalid"}).resizable({
					    		start:function(event,ui){
						            ui.element.css('position','relative');
						        }}
					    	);
							$("#droppableArea").append(ui.draggable.context);
                            sendOperation();
			    		}
			    		else if(parentElementID.contains("draggableLinkContainer")){
				    		$('<a id="draggableLink-' + iDIndex +'"  class="btn btn-link dragable">Link </a>').appendTo("#" + parentElementID).draggable({revert: "invalid"});
				    		$('[data-toggle="popover"]').popover();   
							$("#droppableArea").append(ui.draggable.context);
			    		}
			    		else if(parentElementID.contains("draggableLableContainer")){
			    				var parentIdElements = parentElementID.split('-');
			    				var parentIDIndex = parseInt(parentIdElements[1]);
							$('<div id="draggableLable-' + iDIndex +'"  class="dragable"><h'+ parentIDIndex +'>Default lable</h'+ parentIDIndex +'></div>').appendTo("#" + parentElementID).draggable({revert: "invalid"})
							$("#droppableArea").append(ui.draggable.context)
			    		}
			    		else if(parentElementID.contains("draggableInputTextContainer")){
				    		$('<div id="draggableInputText-' + iDIndex +'" ><form><input type="text" class="form-control" placeholder="Input"></form></div>').appendTo("#" + parentElementID).draggable({ cancel: null },{revert: "invalid"});
				    		console.log(ui.draggable.context);
							$("#droppableArea").append(ui.draggable.context);
			    		}
			    		else if(parentElementID.contains("draggableInputTextAreaContainer")){
				    		$('<div id="draggableInputTextArea-' + iDIndex +'" ><form><textarea class="form-control" rows="3" placeholder="Input Text Area"></textarea></form></div>').appendTo("#" + parentElementID).draggable({ cancel: null },{revert: "invalid"});
				    		console.log(ui.draggable.context);
							$("#droppableArea").append(ui.draggable.context);
			    		}

			    	}
			    });
			});
		</script>
	</body>
</html>