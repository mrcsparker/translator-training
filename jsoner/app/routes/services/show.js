import Ember from 'ember';

export default Ember.Route.extend({

  generateChart: function(type, columns) {
    return {
        columns: columns,
        type: type
    }
  },

  columns: function() {
    return [
      ['data1', 30, 200, 100, 400, 150, 250],
      ['data2', 130, 100, 140, 200, 150, 50]
    ]
  },
  model: function(params) {
    return this.store.find("service", params.service_id);
  },
  setupController: function(controller, model) {

    var columns = this.columns();

    console.log(this.generateChart("bar", columns));

    controller.set('model', model);
    controller.set('data_bar', this.generateChart("bar", columns));
    controller.set('data_line', this.generateChart("line", columns));
    controller.set('data_pie', this.generateChart("pie", columns));
    controller.set('data_donut', this.generateChart("donut", columns));
    controller.set('data_area', this.generateChart("area", columns));
  }
});
