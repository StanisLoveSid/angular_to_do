angular.module('todoList')
.factory('tasks', [
'$http',
'$q',
'Flash',
function($http, $q, Flash) {
  return {
    create: function(title, project_id) {
      var params = { title: title, project_id: project_id };
      return $http.post('/tasks.json', params).then(function(response) {
        return response.data;
      }, function(response) {
        Flash.create('danger', response.data, 3000, {}, true);
        return $q.reject(response.data);
      });
    },  

    update: function(id, params) {
      return $http.put('/tasks/' + id + '.json', params).then(function(response) {
      }, function(response) { 
        Flash.create('danger', response.data, 3000, {}, true);
        return $q.reject(response.data);
      });
    },

    delete: function(id) {
      return $http.delete('/tasks/' + id + '.json').then(function(response) {
      }, function(response) { 
        Flash.create('danger', "Can't find task", 3000, {}, true);
        return $q.reject(response.data);
      });
    },

    reorder: function(id, direction) {
      return $http.put('/tasks/' + id + '/reorder.json', {direction: direction});
    }
  };
}]);