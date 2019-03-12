angular.module('todoList')
.controller('ProjectCtrl', [
'$scope',
'projects',
function($scope, projects) {
  projects.getAll().then(function(data) {
    $scope.projects = data;
  });
  
  $scope.createProject = function() {
    projects.create().then(function(response) {
      $scope.projects.push(response);
    });
  };

  $scope.updateProject = function(scope) {
    projects.update(scope.project.id, scope.title).then(function() {
      scope.project.title = scope.title;
    });
    scope.editSwitch = false;
  };

  $scope.deleteProject = function(project) {
    projects.delete(project.id).then(function() {
      $scope.projects.splice($scope.projects.indexOf(project), 1)
    });
  };

  $scope.edit = function(scope) {
    scope.title = scope.project.title;
    scope.editSwitch = true;
  };
}]);