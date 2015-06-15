var Foto = require('../models/Foto.js');

var FotoCollection = Backbone.Collection.extend({

	model: Foto,
	url: 'api/photos',


	sync: function(method, model, options) {
		if(model.methodUrl && model.methodUrl(method.toLowerCase())) {
			options = options || {};
			options.url = model.methodUrl(method.toLowerCase());
		}
    Backbone.Collection.prototype.sync.apply(this, arguments);
	}

});

module.exports = FotoCollection;