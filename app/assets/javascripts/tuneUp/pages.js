TUNEUP.searches = {
	index: function() {
		          var search = $('#search');

          var next = $('#next');
          var offset = 0;
          next.on( "click", function() {

            console.log("clicked next");
            offset += 1,
          $.get("/search",
          {
            search: search.val(), offset: offset
          }, 
          function( data ) {
            if(search.val() == "") {
              console.log("no search");
              $("#results").html(""); }
            else {
            console.log(data);
            $("#results").html( data );}
      })
    });
	}
}
