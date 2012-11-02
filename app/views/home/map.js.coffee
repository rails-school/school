
$(".the_map").replaceWith("<%= escape_javascript(render :partial => "shared/maps", :locals => {:places = @places}) %>")
