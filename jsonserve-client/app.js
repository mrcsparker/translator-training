function barChart() {
  nv.addGraph(function() {
    var chart = nv.models.discreteBarChart()
      .x(function(d) {
        return d.label
      }) //Specify the data accessors.
      .y(function(d) {
        return d.value
      })
      .staggerLabels(true) //Too many bars and not enough room? Try staggering labels.
      //.tooltips(false)        //Don't show tooltips
      .showValues(true) //...instead, show the bar value right on top of each bar.
      //.transitionDuration(350)
    ;

    d3.select('#chart svg')
      .datum(exampleData())
      .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}

function pieChart() {
  //Regular pie chart example
  nv.addGraph(function() {
    var chart = nv.models.pieChart()
      .x(function(d) {
        return d.label
      })
      .y(function(d) {
        return d.value
      })
      .donut(true)
      .showLabels(true);

    d3.select("#chart svg")
      .datum(exampleData())
      .transition().duration(350)
      .call(chart);

    return chart;
  });
}

function donutChart() {
  nv.addGraph(function() {
    var chart = nv.models.pieChart()
      .x(function(d) {
        return d.label
      })
      .y(function(d) {
        return d.value
      })
      .showLabels(true) //Display pie labels
      .labelThreshold(.05) //Configure the minimum slice size for labels to show up
      .labelType("percent") //Configure what type of data to show in the label. Can be "key", "value" or "percent"
      .donut(true) //Turn on Donut mode. Makes pie chart look tasty!
      .donutRatio(0.35) //Configure how big you want the donut hole size to be.
    ;

    d3.select("#chart2 svg")
      .datum(exampleData())
      .transition().duration(350)
      .call(chart);

    return chart;
  });
}

pieChart();

//Each bar represents a single discrete quantity.
function exampleData() {
  return  [
      { 
        "label": "One",
        "value" : 29.765957771107
      } , 
      { 
        "label": "Two",
        "value" : 0
      } , 
      { 
        "label": "Three",
        "value" : 32.807804682612
      } , 
      { 
        "label": "Four",
        "value" : 196.45946739256
      } , 
      { 
        "label": "Five",
        "value" : 0.19434030906893
      } , 
      { 
        "label": "Six",
        "value" : 98.079782601442
      } , 
      { 
        "label": "Seven",
        "value" : 13.925743130903
      } , 
      { 
        "label": "Eight",
        "value" : 5.1387322875705
      }
    ];
}
