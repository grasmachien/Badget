var Handlebars = require("hbsfy/runtime");
var Application = require("./classes/routers/Application.js");

var playvideo = document.querySelector('.button_video');
var hiddenvideo = document.querySelector('.videoverlay');
var sluit = document.querySelector('.sluit');

function init() {

	//nieuwe router aanmaken:
	Window.Application = new Application();

	//backbone gaat router opstarten:
	Backbone.history.start();


    playvideo.addEventListener('click', clickhandlervideo);
    sluit.addEventListener('click', sluitvideo);


	window.addEventListener('scroll', function(e){

		var distanceY = window.pageYOffset || document.documentElement.scrollTop,
            shrinkOn = 700,
            header = document.querySelector(".header");
            nav = document.querySelector(".nav");

        if (distanceY > shrinkOn && distanceY <= 999) {
         
        	console.log("remove");

        	nav.classList.remove("display_non");

        }

        if (distanceY < shrinkOn && distanceY >= 600) {
         
        	console.log("add");

        	nav.classList.add("display_non");

        }



	});


	$(".challengess").click(function() {
		event.preventDefault();
        $('html, body').animate({
            scrollTop: $(".challenges").offset().top - 80
        }, 1000);
    });

	$(".appp").click(function() {
		event.preventDefault();
        $('html, body').animate({
            scrollTop: $(".app").offset().top
        }, 1000);
    });

    $(".fotoo").click(function() {
		event.preventDefault();
        $('html, body').animate({
            scrollTop: $(".geuploade_fotos").offset().top - 80
        }, 1000);
	});	


    function clickhandlervideo(e){
        e.preventDefault();

        console.log("klik");

        

        hiddenvideo.style.display = "inline";
        hiddenvideo.style.opacity = 0;
        
        window.setTimeout(function() {
          $( hiddenvideo ).fadeTo( "fast", 1 );
        }, 300);
    }

    function sluitvideo(e){
        e.preventDefault();

         $( hiddenvideo ).fadeTo( "fast", 0 );

        
        
        window.setTimeout(function() {
            hiddenvideo.style.display = "none";
        }, 500);

    }

}

init();