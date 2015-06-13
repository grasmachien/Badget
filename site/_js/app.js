var Handlebars = require("hbsfy/runtime");
var Application = require("./classes/routers/Application.js");

function init() {

	//nieuwe router aanmaken:
	Window.Application = new Application();

	//backbone gaat router opstarten:
	Backbone.history.start();

}

init();