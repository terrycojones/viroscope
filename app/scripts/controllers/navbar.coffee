'use strict'

angular.module('viroscope-app')
  .controller 'NavbarCtrl', ($scope, $location) ->
    $scope.menu = [
      title: 'About'
      link: '/'
    ]

    $scope.isActive = (route) ->
      route is $location.path()
