import Ember from 'ember';

export default Ember.Route.extend({

  generateChart: function(type, columns) {
    return {
        columns: columns,
        type: type
    };
  },

  columns: function(model) {
    var json = JSON.parse(model.get('json'));
    return Object.keys(json).map(function(x) {
      var newJson = json[x];
      newJson.unshift(x);
      return newJson;
    });
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
    controller.set('pattern', {pattern:['#90CAF9', '#A5D6A7', '#FFE082', '#FFAB91', '#F48FB1']});
  }
});
