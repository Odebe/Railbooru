// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


///*
window.onload = function() {
	addTagsMagick();
	addReplyMagick();
	dropDownMagick();
}

function addTagsMagick() {
	var tag_lis = document.getElementsByClassName('tag_li');
	Array.prototype.forEach.call(tag_lis, function(li){
		var tag= li.getElementsByClassName('tag-link')[0].innerText;
		li.getElementsByClassName('add_button')[0].onclick = function(){
			addTag(tag);
		};
	});
};

function addReplyMagick() {
	var comments = document.getElementsByClassName('comment');
	Array.prototype.forEach.call(comments, function(comment){
		var comment_id = comment.getElementsByClassName('comment_id')[0].innerText;
		var reply_link = comment.getElementsByClassName('reply_link')[0];
		reply_link.onclick = function() {
			reply(comment_id);
		};
	});
}
function send_ajax(xhr,search){
		var last = search.value.split(' ');//.pop();
		xhr.open('GET', 'posts/autocomplete?tags='+last, false);
		xhr.send();
		if (xhr.status != 200) {
  	// обработать ошибку
  	//alert( xhr.status + ': ' + xhr.statusText ); // пример вывода: 404: Not Found
  		return nil;
		} else {
		  // вывести результат
		  //alert( xhr.responseText ); // responseText -- текст ответа.
		 	return xhr.responseText;
		}
}
function show_list(search, res){

}

function hide_list(){}

function add_to_list(res){
	var data_list = document.getElementsByTagName("datalist")[0];
	//.getElementById("autocomp");
	//alert(typeof res);
	data_list.innerText = '';
	var options = '';
	for(var i = 0; i< res.length; i++){
		//var op = Array.prototype.join.call()
		console.log(res[i]);
		options += '<option value="'+res[i].join(" ")+'" />';
	}
	data_list.innerHTML = options;
}


function dropDownMagick(){
	var xhr = new XMLHttpRequest();
	var search = document.getElementById('searchForm');
	var res;
	search.onchange = function(){
		res = JSON.parse(send_ajax(xhr, search));
		add_to_list(res);
	}
	search.onfocus = function(){
		//show_list(search, res);
	}
	search.onblur = function(){
		//hide_list();
	}
}

//*/
/*
$(document).ready(magick)
$(document).on('page:load', magick)

function magick() {
	addTagsMagick();
	addReplyMagick();
	dropDownMagick();
}


function addTagsMagick(){
	var tag_lis = $(".tag_li")
	$.each(tag_lis, function(index, li){
		var name = $(li).find("a.tag-link").get(0).innerText;
		$(li).click(function() {
			addTag(name);
		});
	});
}

function addReplyMagick(){
	$.each($(".comment"), function(index, comment){
		var comment_id = $(comment).find(".comment_id").get(0).innerText;
		var reply_link = $(comment).find(".reply_link").get(0);
		$(reply_link).click(function(){
			reply(comment_id);
		});
	});
}
*/
function addTag(tag){
	var search = document.getElementById('searchForm');
	search.value = [search.value, tag].join(" ");
}

function reply(comment_id) {
	var comment_field = document.getElementById('new_comment_field');
	comment_field.value += '>>' + comment_id + '\n';
}
