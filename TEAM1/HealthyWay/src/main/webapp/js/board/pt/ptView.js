$(function(){
	$("#menu_info").click(function(){
		$(".all_content").css("display", "none");
		$(".recu_status_wrap").css("display", "block");
		$(".content_wrap").css("display", "block");
		
		$(".all_menu").css("background-color", "#FCFCFC");
		$(".all_menu").css("color", "gray");
		$(".all_menu").css("border", "1px solid #E4E5E5").css("border-bottom", "1px solid gray").css("border-left", "none");
		
		$(this).css("border", "1px solid gray").css("border-bottom", "none");
		$(this).css("background-color", "#fff").css("color","#000");
		$("#menu_manage").children('span').text("lock");
		$("#menu_qna").children('span').text("lock");
	});
	
	$("#menu_member").click(function(){
		$(".all_content").css("display", "none");
		$(".member_wrap").css("display", "block");
		
		$(".all_menu").css("background-color", "#FCFCFC");
		$(".all_menu").css("color", "gray");
		$(".all_menu").css("border", "1px solid #E4E5E5").css("border-bottom", "1px solid gray").css("border-left", "none");
		$("#menu_info").css("border-left", "1px solid #E4E5E5");
		
		$(this).css("border", "1px solid gray").css("border-bottom", "none");
		$(this).css("background-color", "#fff").css("color","#000");
		$("#menu_manage").children('span').text("lock");
		$("#menu_qna").children('span').text("lock");
	});	

});

