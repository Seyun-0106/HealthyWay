$(function(){
	$("#recu_btn").hover(function(){
		$(this).css("color", "#000").css("background-color", "#fff").css("border", "1px solid #ddd");
	}, function(){
		$(this).css("color", "#fff").css("background-color", "#FF5454").css("border", "1px solid #FF5454");
	});
	
	$("#completed_btn").hover(function(){
		$(this).css("color", "#fff").css("background-color", "#FF5454").css("border", "1px solid #FF5454");
	}, function(){
		$(this).css("color", "#000").css("background-color", "#fff").css("border", "1px solid #ddd");
	});
	
	$("#write_btn").hover(function(){
		$(this).css("color", "#000").css("background-color", "#fff").css("border", "1px solid #ddd");
	}, function(){
		$(this).css("color", "#fff").css("background-color", "#FF5454").css("border", "1px solid #FF5454");
	});
	
	$(".pt_post_wrap").hover(function(){
		$(this).css("border", "1.5px solid #a9a9a9");
	}, function(){
		$(this).css("border", "1.5px solid #e9e9e9");
	});
	
	$("#searchBtn").click(function(){
		if($("#searchWord").val() == ''){
			alert("검색어를 입력하세요.");
			location.href="/board/ptList";
			return false;
		}
		$("#searchFrm").submit();
	});
	
	$("#recu_btn").click(function(){
		$("#recuFrm").submit();
	});
	
	$("#completed_btn").click(function(){
		$("#compleFrm").submit();
	});
});