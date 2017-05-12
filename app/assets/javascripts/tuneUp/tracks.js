TUNEUP.tracks = {
  show: function() {
    var search = $('#search');
    search.on( "keyup", function() {
      $.get("/search",
      {
            search: search.val()
      }, 
      function( data ) {
        console.log(data);
        $("#results").html( data );
      })
    });
  }
}