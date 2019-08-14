$(document).ajaxComplete(function() {
  // Page through track search results //
  ///////////////////////////////////////

  var searchform = $("#search-form");
  var search = $("#search");
  var nextresults = $("#next-results");
  var previousresults = $("#previous-results");
  var searchsubmit = $("#searchsubmit");
  var closeresults = $("#close-search");

  // Set offset and re-search when click on next page //
  //////////////////////////////////////////////////////

  nextresults.on("click", function(e) {
    var inprogress = true;
    e.preventDefault();
    localStorage.searchVal = search.val();

    // If we have a page count, increment by 10
    if (localStorage.pageCount) {
      localStorage.pageCount = parseInt(localStorage.pageCount) + 10;
    } else {
      localStorage.pageCount = 0;
    }

    console.log(localStorage.pageCount);
    console.log("clicked next");

    // Send the request
    $.get(
      "/search",
      {
        search: localStorage.searchVal,
        offset: localStorage.pageCount
      },
      function(data) {
        $("#search-results").html(data);
        $('#previous-results').removeClass('hidden');
      }
    );
  });

  previousresults.on("click", function(e) {
    var inprogress = true;
    e.preventDefault();
    localStorage.searchVal = search.val();

    // If we have a page count, decrement by 10
    if (localStorage.pageCount) {
      localStorage.pageCount = parseInt(localStorage.pageCount) - 10;
    } else {
      localStorage.pageCount = 0;
    }

    console.log(localStorage.pageCount);
    console.log("clicked previous");

    // Send the request
    $.get(
      "/search",
      {
        search: localStorage.searchVal,
        offset: localStorage.pageCount
      },
      function(data) {
        $("#search-results").html(data);
        if (localStorage.pageCount == 0) {
          $('#previous-results').addClass('hidden');
        }
      }
    );
  });

  closeresults.on("click", function(e) {
    $("#search-results").html("");
    $("#recommended").removeClass('hidden')
    e.preventDefault();
    localStorage.pageCount = 0;
  });
});
