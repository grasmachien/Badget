var Foto = Backbone.Model.extend({

	defaults: {
		"username": "Brodelet",
		"path": "uploads/5575be50c1363.png",
	},

	urlRoot: 'api/photos',
	
	sync: function(method, model, options) {
		if(model.methodUrl && model.methodUrl(method.toLowerCase())) {
			options = options || {};
			options.url = model.methodUrl(method.toLowerCase());
		}
    Backbone.Collection.prototype.sync.apply(this, arguments);
	}

});

module.exports = Foto;