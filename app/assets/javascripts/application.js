// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

window.onload = function() {
	var new_tweet_field = document.getElementsByTagName('textarea')[0];

	if (typeof new_tweet_field !== 'undefined'){
		var letters_left_indicator = document.createElement('div');
		letters_left_indicator.className = 'letters_left';
		letters_left_indicator.innerHTML = 140;
		var textChange = function(){
			console.log('Change event fired!')
			var letters_left = 140 - this.value.length;
			//console.log('this.value.length: ' + this.value.length);
			letters_left_indicator.innerHTML = letters_left;
			letters_left_indicator.className = (letters_left < 0) ? "letters_left tooMany" : "letters_left";
		};

		if (new_tweet_field.addEventListener){
			new_tweet_field.addEventListener('input', textChange);
		} else if (new_tweet_field.attachEvent){
			new_tweet_field.attachEvent('onpropertychange', textChange);
		}
		new_tweet_field.parentNode.appendChild(letters_left_indicator);
	}
}

// Cross-browser addEvent function

var addEvent = function(elem, evt, func) {
	if (typeof(window.event) !== 'undefined'){
		elem.attachEvent("on" + evt, func);
	} else {
		elem.addEventListener(evt, func, true);
	}
}