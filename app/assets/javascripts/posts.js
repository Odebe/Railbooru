// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener("DOMContentLoaded", function(){
	var tag_lis = document.getElementsByClassName('tag_li');
	Array.prototype.forEach.call(tag_lis, function(li){
		var name = li.getElementsByClassName('tag-link')[0].innerText;
		li.getElementsByClassName('add_button')[0].onclick = function(){
			document.getElementById('searchForm').value += " " + name;
		};
	});
});

