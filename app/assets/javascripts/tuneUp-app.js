TUNEUP = {
    common: {
        init: function () {
          var search = $('#search');
          search.on( "keyup", function() {
          $.get("/search",
          {
            search: search.val()
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
};

