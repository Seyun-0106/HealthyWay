
$(function(){	
	//이미지 첨부되면 실행
	$("#file").change(function() {
		setImage(this, "#preview");
		var file = $("#file").val();
		var idx = file.lastIndexOf("\\")+1;
		var img = $("#imgFile").val(file.substring(idx));
		$("#imgFile").val(file.substring(idx));
	});
	
	$("#preview").click(function(){
		if(confirm("이미지를 수정하시겠습니까?")==true){
			$("#file").click();
		}
	});
	
	//취소 버튼
    $("#recipeBtn>input[type=reset]").click(function(){
    	if(confirm("글 수정을 취소하시겠습니까?")==true){
    		deleteAllIngred(0);
			location="/recipe/list";
		}
    });
  
	//재료 검색
	$("#ingredSearch").submit(function(){
		event.preventDefault();
		
		//유효성 검사
		if($("#searchValue").val()==""){
			alert("검색어를 입력하세요.");
			$("#searchValue").focus();
			return false;
		}
		
		var params = $("#ingredSearch").serialize();
		$.ajax({
			url: '/recipe/searchIngred',
			data: params,
			type: 'post',
			success: function(result){
				var tag ="";
				$(".list-group").html("");
		
				if(result.length==0){//존재하지 않는 경우
					$(".list-group").append("<br/><p>검색하신 재료가 존재하지 않습니다.</p><br/>");
				}
				
				var pageNum = $("#pageNum").val();
				var onePageRecord = 8;//한 페이지에 출력할 레코드 수
				var onePageCount = 5;//페이지 수
				paging(pageNum, result.length);//페이징 리스트 설정 함수 호출
				
				//리스트 출력
				for(var i=(pageNum-1)*onePageRecord; i<=(onePageRecord-1)+(pageNum-1)*onePageRecord; i++){
					if(result[i]!=null){
						tag = "<a href='javascript:addIngred("+JSON.stringify(result[i])+")' class='list-group-item list-group-item-action'>"+result[i].gred_name+"</a>";
						$(".list-group").append(tag);
					}
				}
				$("#pageNum").val(1);	//페이지 변수값 변경
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	});
	
	//gram 직접 입력
	$("#ingredGram").on("propertychange change keyup paste input", function(){
		var kcal = $("#ingredKcal").val();
		var gram = $(this).val();
		var result = kcal/100*gram;
		$("#gKcal").text("kcal: "+result.toFixed(0)+"kcal");
	});
	
	//재료 추가(db insert)
	$("#ingredFrm").submit(function(){
		
		event.preventDefault();
		
		//유효성 검사
		if($("#ingredNum").val()==""){
			alert("재료를 선택하세요.");
			return false;
		}
		if($("#ingredGram").val()==""){
			alert("아이콘 선택 또는 g을 입력해 주세요.");
			$("#ingredGram").focus();
			return false;
		}
		var kcal = $("#gKcal").text();
		var idx =  kcal.lastIndexOf(":")+2;
		var idx2 = kcal.lastIndexOf("kcal");
		kcal = kcal.substring(idx,idx2);
		$("#ingredKcal").val(kcal);
		
		//재료 추가 매핑
		var params = $("#ingredFrm").serialize();
		
		$.ajax({
			url: '/recipe/insertIngred',
			data: params,
			type: 'post',
			success: function(result){
				if(result<0){
					alert("재료가 추가되지 않았습니다.");
				}
				alert("재료가 추가되었습니다.");
				ingredList($("#ingredBoardNum").val());	//재료 리스트 출력
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	});
	
	//글 수정 submit 이벤트
	$("#writeFrm").submit(function(){
		event.preventDefault();

		//유효성 검사------------------------------
		if($("#title>input").val()==""){//title
			alert("레시피 제목을 입력하세요.");
			$("#title>input").focus();
			return false;
		}
		if($("#ingredList>li").length<=0){//재료
			alert("재료를 추가하세요.");
			return false;
		}
		if($("#content").val()==""){//content
			alert("레시피 설명을 입력하세요.");
			$("#content").focus();
			return false;
		}
		/*
		if ($("#file").val() == '') {//input file
			alert("이미지를 첨부하세요.");
			return false;
		}
		*/
		var params = new FormData($("#writeFrm")[0]);
		var board_num = $("#board_num").val();
		$.ajax({
			url: '/recipe/update',
			data: params,
			method:"post",
			processData: false,
			contentType: false,
			success:function(result){
				if(result>0){
					alert("레시피가 수정되었습니다.");
					location="/recipe/view?board_num="+board_num;
				}
			},
			error:function(e){
				console.log(e.responseText);
				alert("레시피가 수정 실패하였습니다.");
			}
		});
	});
});

//이미지 미리보기
function setImage(input, preview) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$(preview).attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
};
//재료 리스트 클릭 이벤트
function addIngred(obj){
	ingredReset();
	$("#ingredNum").val(obj.gred_num);
	$("#ingredKcal").val(obj.gred_kcal);
	$("#ingredName").html(obj.gred_name);
	
	//그릇 아이콘
	if(obj.gred_type=="곡류"){
		$("#measurement>li>img").attr("src","/recipeImg/bowl.png");
		$(".g1").html("0.5인분(105g)");
		$(".g1").parent().attr("onclick","mesureClick('105');");
		$(".g2").html("1인분(210g)");
		$(".g2").parent().attr("onclick","mesureClick('210');");
		$(".g3").html("2인분(420g)");
		$(".g3").parent().attr("onclick","mesureClick('420');");
	}
	//컵 아이콘
	else if(obj.gred_type=="우유/유제품류" || obj.gred_type=="차류" || obj.gred_type=="주류" || obj.gred_type=="음료류"){
		$("#measurement>li>img").attr("src","/recipeImg/cup.png");
		$(".g1").html("0.5컵(100ml)");
		$(".g1").parent().attr("onclick","mesureClick('100');");
		$(".g2").html("1컵(200ml)");
		$(".g2").parent().attr("onclick","mesureClick('200');");
		$(".g3").html("2컵(420gml)");
		$(".g3").parent().attr("onclick","mesureClick('420');");
	}
	//스푼 아이콘
	else if(obj.gred_type=="조미료류" || obj.gred_type=="유지류" || obj.gred_type=="당류"){
		$("#measurement>li>img").attr("src","/recipeImg/spoon.png");
		$(".g1").html("1작은 술(5cc)");
		$(".g1").parent().attr("onclick","mesureClick('5');");
		$(".g2").html("1큰 술(15cc)");
		$(".g2").parent().attr("onclick","mesureClick('15');");
		$(".g3").html("1.5큰 술(20cc)");
		$(".g3").parent().attr("onclick","mesureClick('20');");
	}
	
}
//초기화
function ingredReset(){
	$("#ingredNum").val("");
	$("#ingredKcal").val("");
	$("#ingredGram").val("");
	$("#ingredName").html("재료");
	$("#gKcal").html("kcal: ");
	$("#measurement>li>img").attr("src","/recipeImg/mesure.png");
	$(".g1").html("100g");
	$(".g2").html("200g");
	$(".g3").html("300g");
	
	$("#pageNum").val(1);	//페이지 변수값 변경
}
//계량 아이콘 클릭했을 때
function mesureClick(gram){
	$("#ingredGram").val(gram);
	var kcal = $("#ingredKcal").val();
	var result = kcal/100*gram;
	$("#gKcal").text("kcal: "+result.toFixed(0)+"kcal");
}
//페이지 클릭 이벤트
function setPageNum(num){
	$("#pageNum").val(num);	//페이지 변수값 변경
	$("#searchSubmit").trigger("click");	//검색 버튼 강제 클릭
}
//페이징 설정
function paging(pageNum, totalRecord){
	var pageNum = parseInt(pageNum);// 현재 페이지
	var onePageRecord = 8;//한 페이지에 출력할 레코드 수
	var onePageCount = 4;//페이지 수
	var totalRecord = parseInt(totalRecord);//검색된 레코드 수
	var totalPage;// 총 페이지 수
	var offsetIndex = parseInt(onePageCount*(pageNum)-1);// 오프셋
	var startPage = Math.floor((pageNum-1)/(onePageCount))*onePageCount+1;
	
	if (totalRecord % onePageRecord == 0) {// 나머지 레코드 없는 경우
		totalPage = totalRecord / onePageRecord;
	}else if(totalRecord<onePageRecord){
		totalPage=1;
	}else {// 나머지 레코드 있는 경우
		totalPage = parseInt(totalRecord / onePageRecord + 1);
	}
	
	var pagingTag = "";
	if(pageNum==1){
		pagingTag += "<a href='javascript:alert(\"이전 페이지가 없습니다.\");'><li>◀</li></a>";
	}else if(pageNum>1){
		var prevPage = pageNum-1;
		pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+prevPage+")';><li>◀</li></a>";
	}
	
	for(var i=startPage; i<=startPage+onePageCount-1; i++){
		if(i<=totalPage){
			if(i==pageNum){
				pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+i+");'><li class='active_list'>";
			}else{
				pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+i+");'><li>";
			}
			pagingTag += i+"</li></a>";
		}
	}

	if(pageNum==totalPage){
		pagingTag += "<a href='javascript:alert(\"다음 페이지가 없습니다.\");'><li>▶</li></a>";
	}else{
		var nextPage = pageNum+1;
		pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+nextPage+")';><li>▶</li></a>";
	}
	$(".paging").html(pagingTag);
	
}

//재료 리스트 출력
function ingredList(boardNum){
	$.ajax({
		url: "/recipe/ingredList",
		type: "post",
		data: "board_num="+boardNum,
		success: function(result){
			var tag="";
			var kcal=0;
			$("#ingredList").html("");
			$(result).each(function(){
				tag += '<li id="'+this.gred_num+'"onclick="deleteIngred(\''+this.gred_num+'\', \''+this.board_num+'\', \''+this.gred_gram+'\');">'+this.gred_name+'&nbsp;'+this.gred_gram+'g&nbsp;<span class="times">&times;</span></li>';
				kcal+=this.gred_kcal;
			});
			
			$("#ingredList").html(tag);
			$("#total_kcal").val(kcal);
			$("#totalKcal").text("Total Kcal : "+kcal+"kcal");
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
}

function deleteIngred(gredNum, boardNum, gredGram){
	
	if(confirm("재료를 삭제하시겠습니까?")==false){
		return false;
	}
	$.ajax({
		url: "/recipe/deleteIngred",
		data: "gred_num="+gredNum+"&board_num="+boardNum+"&gred_gram="+gredGram,
		type: "post",
		success: function(result){
			if(result<0){
				("재료 삭제 실패");
			}
			("재료 삭제 성공");
			ingredList(boardNum);
		},
		error: function(e){
			(e.responseText);
		}
	});
}
function deleteAllIngred(boardNum){
	
	if(confirm("추가하신 재료를 모두 삭제하시겠습니까?\n(기존에 있던 재료는 삭제되지 않습니다.)")==false){
		return false;
	}
	
	$.ajax({
		url: "/recipe/deleteAllIngred",
		data: "board_num="+boardNum,
		type: "post",
		success: function(result){
			if(result<0){
				("재료 삭제 실패");
			}
			$("#totalKcal").text("Total : 0kcal");
			$("#ingredList").html("");	//재료 리스트 초기화
			ingredList(boardNum);
		},
		error: function(e){
			(e.responseText);
		}
	});
}