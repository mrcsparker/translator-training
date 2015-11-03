import DS from 'ember-data';

export default DS.Model.extend({
  chartType: DS.attr('string'),
  name: DS.attr('string'),
  json: DS.attr('string'),

  prettyJson: function() {
    return JSON.stringify(JSON.parse(this.get('json')), undefined, 2);
  }.property('json')
});
