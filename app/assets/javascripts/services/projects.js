angular.module('todoList')
.factory('projects', [
'$http',
'$q',
'Flash',
function($http, $q, Flash) {
  return {
    getAll: function() {
      return $http.get('/projects.json').then(function(response) {
        return response.data;
      });
    },

    create: function() {
      return $http.post('/projects.json').then(function(response) {
        return response.data;
      }, function(response) {
        Flash.create('danger', response.data, 3000, {}, true);
        return $q.reject(response.data);
      });
    },  

    update: function(id, title) {
      return $http.put('/projects/' + id + '.json', { title: title })
        .then(function(response) {
        }, function(response) { 
          Flash.create('danger', response.data, 3000, {}, true);
          return $q.reject(response.data);
        });
    },

    delete: function(id) {
      return $http.delete('/projects/' + id + '.json').then(function(response) {
      }, function(response) { 
        Flash.create('danger', "Can't find task", 3000, {}, true);
        return $q.reject(response.data);
      });
    }
  };
}]);