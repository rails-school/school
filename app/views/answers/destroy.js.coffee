$(".answers .list").html("<%= escape_javascript(render :partial => "answers/list", :locals => {:poll => @answer.poll}) %>")
