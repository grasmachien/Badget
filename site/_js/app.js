var Handlebars = require("hbsfy/runtime");
var Application = require("./classes/routers/Application.js");

function init() {

	//nieuwe router aanmaken:
	Window.Application = new Application();

	//backbone gaat router opstarten:
	Backbone.history.start();

    $.get( "http://192.168.1.6/2014-2015/MAIV/Badget/Badget/site/api/data/totalbier", function(data) {

            var score = data["SUM(score)"];
            var punten = document.querySelector(".bier").innerHTML = score + "cl";


    });

    $.get( "http://192.168.1.6/2014-2015/MAIV/Badget/Badget/site/api/data/selectTotalPunten", function(data) {


            var bier = data["SUM(score)"];
            var punten1 = document.querySelector(".punten").innerHTML = bier;


    });

    $.get( "http://192.168.1.6/2014-2015/MAIV/Badget/Badget/site/api/data/selectTotalPhotos", function(data) {

            var fotos = data["COUNT(id)"];
            var punten2 = document.querySelector(".aantalfotos").innerHTML = fotos;


    });


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

}

init();