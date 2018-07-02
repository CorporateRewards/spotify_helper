TUNEUP = {
    common: {
        init: function () {
          var searchform = $('#search-form');
          var search = $('#search');
          var nextresults = $('#next-results');

          // Set page count to 0 and perform initial search on search form submission //
          //////////////////////////////////////////////////////////////////////////////

          searchform.on( "submit", function(e) {
            e.preventDefault();
            localStorage.pageCount = 0;

          // Only send the request if the search has a value
            if(search.val() == "") {
              localStorage.pageCount = 'undefined';
              console.log("no search");
              $("#results").html(""); 
            } else {
              $.get("/search",
                {
                  search: search.val(), 
                  offset: localStorage.pageCount
                }, 
                function( data ) {
                  // console.log(data);
                  $("#results").html( data );
                })
              } 
            });
          }
        }
      }

