var StudentCollection = require('../collections/FotoCollection.js');
var template = require('../../../_hbs/home.hbs');
var FotoView = require('./FotoView.js');

var HomeView = Backbone.View.extend({

	template: template,
	
	
	events: {

	},

	initialize: function(){

		this.collection = new StudentCollection();
		this.listenTo(this.collection, 'sync', this.renderFotos);
		this.collection.fetch();		
	},

	renderFotos: function(){

		this.$fotos.empty();
		this.collection.forEach(this.renderFoto, this);
	},

	renderFoto: function(item){

		var view = new FotoView({
			model: item
		});

		this.$fotos.append(view.render().el);

	},

	render: function(){

		this.$el.html(this.template());
		this.$fotos = this.$el.find('.bla');
		return this;

	}

});

module.exports = HomeView;