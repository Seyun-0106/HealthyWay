<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/recipeWrite.css" type="text/css" />
<script>
$(function(){
	
	//이미지 첨부되면 실행
	$("#file").change(function() {
		setImage(this, "#preview");
	});
	
	//취소 버튼
    $("#recipeInfo>input[type=reset]").click(function(){
    	if(confirm("글 작성을 취소하시겠습니까?")==true){
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
		$(".gKcal").text("칼로리: "+result.toFixed(1)+"kcal");
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
				ingredList();	//재료 리스트 출력
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	});
	
	//글 등록 submit 이벤트
	$("#writeFrm").submit(function(){
		event.preventDefault();
		
		//유효성 검사
		if($("#title").val()==""){
			alert("레시피 제목을 입력하세요.");
			$("#title").focus();
			return false;
		}
		if($("#ingredList>li").length<=0){
			alert("재료를 추가하세요.");
			return false;
		}
		if($("#contnet").val()==""){
			alert("레시피 설명란을 입력하세요.");
			$("#contnet").focus();
			return false;
		}
		
		return false;
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
	$(".gKcal").val("칼로리: ");
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
	$(".gKcal").text("칼로리: "+result.toFixed(1)+"kcal");
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
function ingredList(){
	$.ajax({
		url: "/recipe/ingredList",
		type: "get",
		success: function(result){
			var tag="";
			$(result).each(function(){
				tag = '<li id="'+this.gred_num+'"onclick="deleteIngred(\''+this.gred_num+'\');">'+this.gred_name+'&nbsp;'+this.gred_gram+'g&nbsp;<span class="times">&times;</span></li>';
				$("#ingredList").append(tag);
			});
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
}

function deleteIngred(gredNum){
	
	if(confirm("재료를 삭제하시겠습니까?")==false){
		return false;
	}
	$.ajax({
		url: "/recipe/deleteIngred",
		data: "gred_num="+gredNum,
		type: "post",
		success: function(result){
			if(result<0){
				alert("재료 삭제 실패");
			}
			alert("재료 삭제 완료");
			$("#"+gredNum).html("");
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
}
</script>
<div>
	<!-- 재료 모달창 -->
	<div class="modal fade" id="ingredModal">
		<div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
			<div class="modal-header">
	        <h4 class="modal-title">Ingredient List</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		
	    <div class="modal-body">
	    	<!-- 재료 리스트 -->
	    	<div id="ingredView">
	    		<form method="post" action="/recipe/searchIngred" id="ingredSearch">
		    		<select name="searchKey">
		    			<option>음식명</option>
		    			<option>분류</option>
		    		</select>
		    		<input type="text" name="searchValue" id="searchValue"/>
		    		<input type="hidden" name="pageNum" id="pageNum" value="1"/>
		    		<input type="submit" value="검색" id="searchSubmit"/>
	    		</form><hr/>
	    		<p>재료 선택</p>
				<div class="list-group">
					<br/><p>재료를 검색하세요.</p><br/>
				</div>
				<!-- 페이징 -->
				<ul class="paging">
				</ul>
	    	</div>
	    	<!-- 재료 추가 폼 -->
	    	<form method="post" action="/recipe/insertIngred" id="ingredFrm">
	    		<br/><p id="ingredName" style="font-size:15pt;">재료</p>
	    		<input type="hidden" name="gred_num" id="ingredNum" value=""/>
	    		<input type="hidden" name="board_num" value="0"/><!-- 임의로 설정 -->
	    		<input type="hidden" name="gred_kcal" id="ingredKcal" value=""/>
				<ul id="measurement">
					<li onclick="mesureClick('100');"><img src="/recipeImg/mesure.png"><p class="g1">100g</p></li>
					<li onclick="mesureClick('200');"><img src="/recipeImg/mesure.png"><p class="g2">200g</p></li>
					<li onclick="mesureClick('300');"><img src="/recipeImg/mesure.png"><p class="g3">300g</p></li>
				</ul>
				<p style="font-size:9pt; margin:0; color:gray;">*정확한 칼로리 계산을 위해 <br/>직접 입력하시는 것을 추천드립니다.</p>
	    		<div id="ingredInfo">
	    			<input type="number" name="gred_gram" id="ingredGram" placeholder="직접입력"/>&nbsp;g
	    			<p class="gKcal">칼로리: <p/>
	    		</div>
	    		<div id="ingredBtn">
		   			<input type="submit" value="추가"/>
		   			<input type="reset" value="취소" onclick="ingredReset();"/>
	   			</div>
	    	</form>
	    </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" id="closeBtn" data-dismiss="modal" onclick="ingredReset();">닫기</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<form method="post" action="/recipe/wirte" id="writeFrm" enctype="multipart/form-data">
		<div id="imgDiv">
			<button type="button" data-toggle="modal" data-target="#ingredModal">+재료추가</button>
			<!-- 이미지 첨부 -->
			<input type="file" name="filename" id ="file"/>
			<input type="hidden" name="imgFile" value="" id="imgFile"/>
			<a href="javascript:document.getElementById('file').click();"><img src="/recipeImg/sampleimg.png" id="preview"/></a>
		</div>
		<div id="recipeInfo">
			<!-- title -->
			<p>레시피 이름&nbsp;&nbsp;<input type="text" name="title" id="title"/></p>
			
			<!-- 재료 리스트 -->
			<p>재료</p>
			<ul id="ingredList">
			</ul>
			
			<!-- 레시피 설명 -->
			<p>레시피 설명</p>
			<textarea name="content" id="content"></textarea>
			
			<!-- 버튼 -->
			<input type="reset" value="취소"/>
			<input type="submit" value="등록"/>
		</div>
	</form>
</div>