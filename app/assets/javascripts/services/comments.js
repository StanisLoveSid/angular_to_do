angular.module('todoList')
.factory('comments', [
'$http',
'$q',
'Flash',
function($http, $q, Flash) {
  return {
    create: function(title, task_id) {
      var params = { comment: { title: title, task_id: task_id } };
      return $http.post('/comments.json', params).then(function(response) {
        return response.data;
      }, function(response) {
        Flash.create('danger', response.data, 3000, {}, true);
        return $q.reject(response.data);
      });
    },  

    delete: function(id) {
      return $http.delete('/comments/' + id + '.json').then(function(response) {
      }, function(response) { 
        Flash.create('danger', "Can't find task", 3000, {}, true);
        return $q.reject(response.data);
      });
    }
  };
}]);