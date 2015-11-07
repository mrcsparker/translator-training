import Ember from 'ember';

export default Ember.Route.extend({
  generateChart: function(type, columns) {
    return {
      columns: columns,
      type: type
    };
  },
  columns: function(json) {
    return Object.keys(json).map(function(x) {
      var newJson = json[x];
      newJson.unshift(x);
      return newJson;
    });
  },
  aggregate: function(json) {
    return Object.keys(json).map(function(x) {
      var ratingCounter = [x, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      json[x].forEach(function(rating){
        ratingCounter[rating / 0.5]++;
      });
      return ratingCounter;
    });
  },
  model: function(params) {
    return this.store.find("service", params.service_id);
  },
  setupController: function(controller, model) {
    var json = JSON.parse(model.get('json'));
    var columns = this.columns(json);
    var aggregate = this.aggregate(json);
    controller.set('model', model);
    controller.set('data_bar', this.generateChart("bar", columns));
    controller.set('data_line', this.generateChart("line", columns));
    controller.set('data_pie', this.generateChart("pie", columns));
    controller.set('data_donut', this.generateChart("donut", columns));
    controller.set('data_area', this.generateChart("area", columns));
    controller.set('data_movie_aggregate', this.generateChart("bar", aggregate));
    controller.set('score_axis', {x: {type: 'category', categories: ['0', '0.5', '1', '1.5', '2', '2.5', '3', '3.5', '4', '4.5', '5']}});
  }
});
