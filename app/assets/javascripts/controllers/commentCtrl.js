angular.module('todoList')
.controller('CommentCtrl', [
'$scope',
'$window',
'comments',
'FileUploader',
'Flash',
function($scope, $window, comments, FileUploader, Flash) {
  var csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  $scope.createUploader = function(scope) {
    scope.uploader = new FileUploader({
      url: 'comments/' + scope.comment.id + '.json',
      headers: {'X-CSRF-TOKEN': csrf_token },
      queueLimit: 1,
      formData: [{ "id": scope.comment.id }],
      autoUpload: true,
      removeAfterUpload: true,
      method: 'put'
    });

    scope.uploader.onAfterAddingFile  = function(item) {
      scope.item = item;
    };

    scope.uploader.onErrorItem  = function(item, response) {
       Flash.create('danger', response.file, 3000, {}, true);
    };

    scope.uploader.onSuccessItem = function(item, response) {
      scope.comment.attachment = response;
      scope.item = "";
      scope.fileSwitch = false;
    };

    return scope.uploader;
  }

  $scope.createComment = function(scope) {
    comments.create(scope.commentTitle, scope.task.id).then(function(response) {
      scope.task.comments.push(response);
      scope.commentTitle = "";
    });
  };

  $scope.deleteComment = function(scope) {
    comments.delete(scope.comment.id).then(function() {
      scope.task.comments.splice(scope.task.comments.indexOf(scope.comment), 1)
      scope.uploader.destroy;
    });
  };

}]);