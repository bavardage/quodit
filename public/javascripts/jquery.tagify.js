 jQuery.fn.popupDiv = function (divToPop){
    var pos=$(this).offset();
    var h=$(this).height();
    var w=$(this).width();

	$(divToPop).css({ left: pos.left, top: pos.top });
	$(divToPop).slideDown();
};

(function( $ ){

	var users = [
	{ label: 'Dima Breshnev',
	  value: 1 },
	{ label: 'Ben Duffield',
	  value: 2 },
	{ label: 'Quentin Spencer-Harper',
	  value: 3 }
	];

	var state = {
		tagtext: "",
		isTagging: false,
		currentTagID: 0
	}

	var internal = {
        updateTagSuggestions : function (jsonURL) {
			if (!state.tagtext) return;
			
			$.getJSON(jsonURL + state.tagtext, function(users) {
				$("ul#tags_drop_down").html("");
			
				// Search for options
				var createUser = $('<li id="createNew" class="option_create_new"><a href="#">Add <span class="tagname"></span> to group</a></li>');
				var close = $('<li id="close" class="option_close"><a href="#">Close</a></li>');
				var userTemplate = '<li id="userOption" class="option_user" value="{value}" label="{label}"><a href="#">{label}</a></li>';
				for (var i in users)
				{
					var user = users[i];
					if (user.label.toLowerCase().indexOf(state.tagtext.toLowerCase()) >= 0)
					{
						var html = userTemplate.replace(/{label}/g, user.label).replace(/{value}/g, user.value);
						$("ul#tags_drop_down").append($(html));
					}
				}
				
				// $("ul#tags_drop_down").append(createUser);
				$("ul#tags_drop_down").append(close);
				$("ul#tags_drop_down").children().first().addClass('selected');
				$(".tagname").text(state.tagtext);
			});
			

        },
        selectTagSuggestion: function(box, element) {
			if (element.is(".option_create_new"))
			{
				internal.tokenize(box, {label: state.tagtext, value: 'new:' + state.tagtext});
			}
			else if (element.is(".option_user"))
			{
				internal.tokenize(box, {label: element.attr('label'), value: element.attr('value')});
			}
			else if (element.is(".option_close"))
			{
				internal.endTagging();
			}
		},
		setTagText: function(text, jsonURL)
		{
			state.tagtext = text;
			internal.updateTagSuggestions(jsonURL);
		},
		getSelectedOption: function()
		{
			return $("ul#tags_drop_down li.selected").first();
		},

		endTagging: function()
		{
			state.tagtext = "";
			state.isTagging = false;
			$("#tags_drop_down_container").slideUp();
		},
		tokenize: function(box, user)
		{
				if (state.tagtext)
				{
					var nodeHTML = "<span id='tag"+state.currentTagID+"' class='tag' contenteditable='false' value='" + user.value + "' href='#'>"+user.label+"</span>";
					box.html(box.html().replace("@" + state.tagtext, nodeHTML));
					box.focus();
					$("#tag"+state.currentTagID).textSelect('movetoend');
					internal.endTagging();
					state.currentTagID++;
				}
		}
    };

  $.fn.tagify = function(jsonURL) {
	this.attr('contenteditable', true);

	var ul = $("<ul>").attr("id", "tags_drop_down");
	var container = $("<div>").attr("id", "tags_drop_down_container").hide().append(ul);
	var parent = $("<div>").attr("id", "tags_drop_down_container_parent").append(container);
    
	$(this).after(parent);
	
		$("#tags_drop_down_container").hide();

	this.live("keydown",function(e) 
	{
		if (e.keyCode == 8 && state.isTagging) // Backspace
		{
			if (state.tagtext)
			{
				internal.setTagText(state.tagtext.substring(0, state.tagtext.length - 1), jsonURL);
			}
			else
			{
				internal.endTagging();
			}
		} else if (e.keyCode == 8)
		{
			var range = $.textSelect('getRange');
			// If the cursor is in front of a token, then delete the whole token..
			if (range.startElement.length < 2)
			{
				console.log("Delete!!");
				console.log($(range.startElement));
			}
			//console.log(range.startElement);

		}
	});
	this.live("keydown",function(e) 
	{
		if (e.keyCode == 38 && state.isTagging)
		{
			// Up
			var selectedOption = internal.getSelectedOption();
			if (selectedOption.prev() && selectedOption.prev().is('ul#tags_drop_down li'))
			{
				selectedOption.removeClass('selected');
				selectedOption.prev().addClass('selected');
			}
			return false;
		} else if (e.keyCode == 40 && state.isTagging)
		{
			// Down
			var selectedOption = internal.getSelectedOption();
			if (selectedOption.next() && selectedOption.next().is('ul#tags_drop_down li'))
			{
				selectedOption.removeClass('selected');
				selectedOption.next().addClass('selected');
			}
			return false;
		}
	});
	this.bind("click", function () {
		internal.endTagging();
	});

	this.live("keypress",function(e) 
	{
		//$(this).text(String.fromCharCode(e.which));
		if (!state.isTagging && String.fromCharCode(e.which) == "@")
		{
			if (!$("#tags_drop_down_container").is(":visible"))
			{
				$("#tags_drop_down_container_parent").popupDiv("#tags_drop_down_container");
			}
			internal.setTagText("", jsonURL);
			state.isTagging = true;
		}
		else if (state.isTagging)
		{
			// Enter
			if (e.keyCode == 13)
			{
				internal.selectTagSuggestion($(this), internal.getSelectedOption());
				return false;
			}
			else if (String.fromCharCode(e.which) == ":")
			{
				internal.selectTagSuggestion($(this), internal.getSelectedOption());
			}
			else if (e.keyCode != 8) // Not backspace
			{
				internal.setTagText(state.tagtext + String.fromCharCode(e.which), jsonURL);
			}
		}
	});
	var box = this;

	$("ul#tags_drop_down li").live("click",function() 
	{
		internal.selectTagSuggestion(box, $(this));
	});

  };
  
  $.fn.getTagifiedText = function () {
		var copy = this.clone();
		copy.find("span.tag").each(function () 
		{	
			$(this).replaceWith("@" + $(this).attr('value')); 
		});
		copy.find("div").each(function () 
		{	
			$(this).replaceWith($(this).text() + "\n") 
		});
		return copy.text();
  }
})( jQuery );