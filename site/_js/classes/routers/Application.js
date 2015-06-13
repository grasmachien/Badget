
var Application = Backbone.Router.extend({


	routes: {
		//pagina: functie

		"*actions": "default"
		
	},

	empty: function(){
		//container clearen
		$('.container-fluid').empty();
	},

	default: function(){
		
		this.navigate("home", {trigger: true});
		
	},




});

module.exports = Application;