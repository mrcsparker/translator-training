import DS from 'ember-data';

export default DS.Model.extend({
  chartType: DS.attr('string'),
  name: DS.attr('string'),
  json: DS.attr('string')
});
