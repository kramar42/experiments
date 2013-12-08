'use strict';

angular.module('angularApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  })
  .controller('UploadCtrl', function ($scope) {
    $scope.upload = function() {

    }
    $scope.test = 'test';
  });
