import Ember from 'ember';

export default Ember.Route.extend({

  generateChart: function(type, columns) {
    return {
        columns: columns,
        type: type
    }
  },

  columns: function(model) {
    var json = JSON.parse(model.get('json'));
    var a = Object.keys(json).map(function(x) {
      var newJson = json[x];
      newJson.unshift(x);
      return newJson;
    })
    return a;
    return [
      ['2012', 10, 20],
      ['2013', 100, 200]
    ]
  },
  model: function(params) {
    return this.store.find("service", params.service_id);
  },
  setupController: function(controller, model) {

    var columns = this.columns(model);
    controller.set('model', model);
    controller.set('data_bar', this.generateChart("bar", columns));
    controller.set('data_line', this.generateChart("line", columns));
    controller.set('data_pie', this.generateChart("pie", columns));
    controller.set('data_donut', this.generateChart("donut", columns));
    controller.set('data_area', this.generateChart("area", columns));
  }
});
