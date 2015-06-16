var Foto = Backbone.Model.extend({

	defaults: {
		"username": "Brodelet",
		"path": "assets/img/test_foto.jpg",
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