// TUNEUP = {
//     common: {
//         init: 
//         // setInterval(
//           function () {
//           $.ajax({
//             type:"GET",
//             url:"currently_playing",
//             dataType:"json",
//             success:function(result){
//               $('#artistname').html('');
//               $('#albumimage').attr('src', result.album.images[0]['url']);
//               $.each(result.artists, function(i, artist) {
//                 console.log(artist.name);
//                 $('#artistname').append("<p>" + artist.name + "</p>");
//               });
//               $('#trackname').html(result.name);
//               $('#albumname').html(result.album.name);
//               $('#releasedate').html(result.album.release_date); 
//             },
//             // complete: $.ajax({
//             //   type:"GET",
//             //   url:"progress",
//             //   dataType:"json",
//             //   success:function(track){
//             //     console.log('track');
//             //     console.log(track);
//             //   }
//             // })

//           });

//     }
//     // , 30000)
//   }
// }







// $(document).ready(function () {
//           var timeout;
//           var tracklength;
//           var trackprogress;
//           function () {
//             // $.get("/progress",
//             //     function( data ) {
//             //       console.log(data);
//             //       trackprogress = data
//             //       // $("#results").html( data );
//             //     });
//             $.ajax({
//               cache: false,
//               type:"GET",
//               url:"currently_playing",
//               dataType:"json",
//               success:function(result){
//                 tracklength = result.duration_ms;
//                 $('#artistname').html('');
//                 $('#albumimage').attr('src', result.album.images[0]['url']);
//                 $.each(result.artists, function(i, artist) {
//                   console.log(artist.name);
//                   $('#artistname').append("<p>" + artist.name + "</p>");
//                 });
//                 $('#trackname').html(result.name);
//                 $('#albumname').html(result.album.name);
//                 $('#releasedate').html(result.album.release_date); 
//                 }
//               //   ,
//               // complete: $.get("/progress",
//               //     function( data ) {
//               //       console.log('remainig');
//               //       console.log(tracklength - trackprogress);
//               //       timeout = tracklength - tracklength;
//               //     })
//             })
//           };
//           // setInterval(update_tile, 50000)
// });


// // setInterval(function hello() {
// //   console.log('world');
// //   return hello;
// // }(), 5000);