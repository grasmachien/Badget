
var HomeView = require('../views/HomeView.js');
var FotoCollection = require('../collections/FotoCollection.js');

var Application = Backbone.Router.extend({


	routes: {
		//pagina: functie

		"home": "home",
		"*actions": "default"
		
	},

	empty: function(){
		//container clearen
		$('.container').empty();
	},

	default: function(){
		
		this.navigate("home", {trigger: true});
		
	},

	home: function(){

		this.empty();
		this.home = new HomeView();
		$('.container').append(this.home.render().el);
	}




});

module.exports = Application;