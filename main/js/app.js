function MainController($http) {
  var vm = this;

  vm.csvMovies = [];

  vm.showMovies = function() {
    $http.get('./json/movies.json').success(function(response) {
      $('#myModal').modal('show');
      vm.csvMovies = response;

      console.log(response);
    });
  }

  vm.title = "Translator Training";

  vm.menuItems = [
    {
      title: "Load and Explore",
      icon: "glyphicon-hdd",
      sections: [
        {
          name: "View file",
          description: "",
          icon: 'glyphicon-eye-open',
          type: 'ng-click',
          link: "vm.showMovies()"
        },
        {
          name: "Download file",
          description: "",
          icon: 'glyphicon-cloud-download',
          type: 'link',
          link: "./csv/movies.csv"
        },
        {
          name: "Upload file",
          description: "",
          icon: 'glyphicon-cloud-upload',
          link: "./foo"
        },
        {
          name: "Spark notebook",
          description: "",
          icon: 'glyphicon-play',
          type: 'link',
          link: "./foo"
        }
      ]
    },
    {
      title: "Cleanse & Transform",
      icon: 'glyphicon-repeat',
      sections: [
        {
          name: 'Before & After Cleansing',
          description: '',
          icon: 'glyphicon-list-alt',
          type: 'link',
          link: '/schema-spy'
        }
      ]
    },
    {
      title: 'Analytics',
      icon: 'glyphicon-cog',
      sections: [
        {
          name: 'RStudio',
          description: '',
          icon: 'glyphicon-leaf',
          type: 'link',
          link: '/rstudio'
        }
      ]
    },
    {
      title: 'Integration & Visualization',
      icon: 'glyphicon-link',
      sections: [
        {
          name: 'Web Services (JSON)',
          description: '',
          icon: 'glyphicon-cloud',
          type: 'link',
          link: '/json-server/services'
        },
        {
          name: 'Web App (Charting)',
          description: '',
          icon: 'glyphicon-globe',
          type: 'link',
          link: '/json-client'
        }
      ]
    }
  ];
}

angular
  .module('app', [])
  .controller('MainController', MainController);

