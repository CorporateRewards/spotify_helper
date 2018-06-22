TUNEUP = {
    common: {
        init: function () {
          var searchform = $('#search-form');
          var search = $('#search');
          var nextresults = $('#next-results');
          var searchsubmit = $('#searchsubmit');

          // Set offset and re-search when click on next page //
          //////////////////////////////////////////////////////

          nextresults.on( "click", function() {
            if (typeof localStorage[localStorage.pageCount] !== 'undefined') {
                localStorage[localStorage.pageCount] =  parseInt(localStorage[localStorage.pageCount]) + 10;
                var offset = localStorage[localStorage.pageCount];
              } else if (search.val() == "") {
                localStorage[localStorage.pageCount] = 'undefined';
                var offset = 0
              } else {
                localStorage[localStorage.pageCount] = 0;
            }
            console.log(offset)
            console.log("after local")
            console.log("clicked next");
            
            // Send the request
            $.get("/search",
            {
              search: search.val(), offset: offset
            }, 
            function( data ) {
              if(search.val() == "") {
                console.log("no search");
                localStorage[localStorage.pageCount] = 'undefined';
                $("#results").html(""); }
              else {
              $("#results").html( data );}
            })
          });



          // Set page count to 0 and perform initial search on search form submission //
          //////////////////////////////////////////////////////////////////////////////

          // searchsubmit.on( "click", function() {
          searchform.on( "submit", function(e) {

            e.preventDefault();
            console.log('submitted');
            localStorage[localStorage.pageCount] = 0;

            $.get("/search",
            {
              search: search.val()
            }, 
            function( data ) {
              if(search.val() == "") {
                localStorage[localStorage.pageCount] = 'undefined';
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

