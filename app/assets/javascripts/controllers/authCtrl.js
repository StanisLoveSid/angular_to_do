angular.module('todoList')
.controller('AuthCtrl', [
'$scope',
'$state',
'$location',
'Auth',
'Flash',
function($scope, $state, $location, Auth, Flash){
  $scope.logout = function () {
    Auth.logout().then(function() {
      $location.path('/login');
    });
  };

  $scope.login = function() {
    Auth.login($scope.user).then(function(){
      $location.path('/');
    }, function(response){
      Flash.create('danger', response.data.error, 3000, {class: 'auth'}, true);
    });
  };

  $scope.register = function() {
    Auth.register($scope.user).then(function(){
      $location.path('/');
    }, function(response){
      msg = "Password" + response.data.errors.password;
      if (response.data.errors.email) {
        msg = "Email " + response.data.errors.email;
      } 
      Flash.create('danger', msg, 3000, {class: 'auth'}, true);
    });
  };
}]);