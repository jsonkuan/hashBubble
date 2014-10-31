$("button").click(function() {

	$.getJSON( "json_data.json", function(obj) { 
	$.each(obj, function(key, value) { 
		$("ul").append("<li>"+value.name+"</li>");
	});

	});
});
/*	
    $.ajax({
        type: 'POST',
        url: 'hi.htm',
        data: $('#cityDetails').serialize(),
        dataType:"json", //to parse string into JSON object,
        success: function(data){ 
            if(data){
                var len = data.length;
                var txt = "";
                if(len > 0){
                    for(var i=0;i<len;i++){
                        if(data[i].city && data[i].cStatus){
                            txt += "<tr><td>"+data[i].city+"</td><td>"+data[i].cStatus+"</td></tr>";
                        }
                    }
                    if(txt != ""){
                        $("#table").append(txt).removeClass("hidden");
                    }
                }
            }
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert('error: ' + textStatus + ': ' + errorThrown);
        }
    });
    return false;//suppress natural form submission
});

 */
