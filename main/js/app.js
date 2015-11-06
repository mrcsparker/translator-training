function MainController() {
  var vm = this;

  vm.title = "Translator Training";

  vm.menuItems = [
    {
      title: "Load and Explore",
      icon: "glyphicon-hdd",
      sections: [
        {
          name: "Download file",
          description: "",
          icon: 'glyphicon-cloud-download',
          link: "./foo"
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
          icon: 'glyphicon-cloud',
          link: '/json-server/services'
        },
        {
          name: 'Web App (Charting)',
          icon: 'glyphicon-globe',
          link: '/json-client'
        }
      ]
    }
  ];
}

angular
  .module('app', [])
  .controller('MainController', MainController);

