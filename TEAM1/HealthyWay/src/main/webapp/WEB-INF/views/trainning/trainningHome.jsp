<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="/css/train/train.css">
 <section class="training-view">  




    <ul id="menu">
        <li><a class="active" href="/trainning/trainningHome">트레이닝 센터</a></li>
        <li><a class="li-a" href="/trainning/myTrainning">나만의 운동</a></li>
        <!-- <li><a class="li-a" href="/trainning/recommendTrainning">추천 운동 목록</a></li> -->
    </ul>
    
<div class="divC">   
    <div>
    	<h2 id="current_date"></h2>
		<script>
		date = new Date();
		year = date.getFullYear();
		month = date.getMonth() + 1;
		day = date.getDate();
		document.getElementById("current_date").innerHTML = "Today : " + year + "년 " + month + "월 " + day + "일";
		</script>
        <h2>오늘도 트레이닝 센터에서 열심히 운동하세요!</h2>
        <form action="/trainning/trainningHome/" id="searchFrm" method="get" onsubmit="false">
	        <ul>
	            <li id="train_menu">
	            <select name="module_type" id="category">
	                <option value="">카테고리 선택</option>
	                <option>헬스</option>
	                <option>요가</option>
	                <option>필라테스</option>
	            </select></li>
	            <li id="train_menu">
	            <select name="module_part" id="target">
	                <option value="">운동부위 선택</option>
	                <option>가슴</option>
	                <option>등</option>
	                <option >어깨</option>
	                <option >하체</option>
	                <option >팔</option>
	                <option >복근</option>
	            </select></li>
	            <li id="train_menu">
	            <select name="module_difficulty" id="difficulty">
	                <option value="">난이도 선택</option>
	                <option >상</option>
	                <option >중</option>
	                <option >하</option>
	            </select></li>
	            <li id="train_menu"><button class="search-btn" onclick="search()">검색</button></li>
	        </ul>
        </form>
        <br><br><br>
        <ul class="train_scroll">
 
            <c:forEach var='vo' items="${vo}">
      		    <li id="train_yoso" class="train-frm"><a class="li-a2" href="/trainning/start_train?module_num=${vo.module_num}">
      		    <img class="train-img" name="module_img" src="/train_model/moduleImg/${vo.module_img}">
                <p class="train-subject" name="module_title">${vo.module_title}</p>
                <p class="train-keyword" name="module_content">${vo.module_content }</p></a>
                <button class="add-btn" onclick="add_train(${vo.module_num})">담기</button></li>
            </c:forEach>
      	
        </ul>

<br><br><br><hr><br>

    </div>
    <div>
        <h2>나만의 운동</h2>
        <select name="" id="selectMyTrain" style="width: 300px; text-align: center;">
        	<option value="">내가 저장한 운동 목록 ▼</option>
        	<c:forEach var='selectvo' items='${selectvo}'>
        		<option value="${selectvo.train_num}">${selectvo.train_title}</option>
        	</c:forEach>
        	<option value="0">나만의 운동 추가하기</option>
        </select>

        <form action="/trainning/add_mytrain_list" method="post" id="mytrainFrm">
        	<div ="my-list-Div">
        		<!-- 운동 담은 리스트 -->
       		    <ul id="my_train"></ul>
	            
	        	<ul id="my_train2"></ul>
        	</div>
        	<br>
        	<div>
        		<input class="my-input1" type="text" name="train_title" 
	            		placeholder="저장할 운동 루틴 이름을 입력하세요." 
	            		style="margin: 0; padding: 0">
	            <input class="search-btn" type="submit" value="저장하기">
        	</div>
        </form>
        
<br><br><br><hr><br>

    </div>
    <div>
        <h2>추천 운동</h2>
        <div>
            <ul>
            	<c:if test="${not empty rvo}">
	                <c:forEach var='vo' items="${rvo}">
	      		    <li id="train_yoso" class="train-frm"><a class="li-a2" href="/trainning/start_train?module_num=${vo.module_num}">
	      		    <img class="train-img" name="module_img" src="/train_model/moduleImg/${vo.module_img}">
	                <p class="train-subject" name="module_title">${vo.module_title}</p>
	                <p class="train-keyword" name="module_content">${vo.module_content }</p></a>
	            	</c:forEach>
            	</c:if>
            	<c:if test="${empty rvo}">
            		<p> 맞춤 운동을 설정하시면 추천 운동 목록을 보여드립니다! </p>
            		<p><button class="add-btn" onclick="location.href='/member/question'">설정 하기</button></p>
            	</c:if>
            </ul>
            <br><br><br><br><br>
        </div>
    </div>
</div>
 </section>    
<script>
function del_train(module_num){
	$.ajax({
        url: "/trainning/del_mytrain",
        type: "post",
        data: "module_num="+module_num,
        success : function(result){
        	if(result > 0){
        		alert('담은 운동이 삭제되었습니다.');
        		train_set();
        	}    
     	},
     	error: function(e){
            console.log(e.responseText);
        }
     });
}

function train_set(){
	var tag=""
	$("#my_train").html("");
	$.ajax({
        url: "/trainning/train_set",
        type: "post",
        data: "train_num=0",
        success : function(result){
        	if(result.length > 0){
        		var tag="";
                $(result).each(function(){
                    tag += '<li class="only-li"><p></p><img src="/train_model/moduleImg/'+ this.module_img +'" alt=""><p>' + this.module_title + '</p><p>'+this.module_content+'</p><input type="button" value="삭제하기" class="deldel-btn" onclick="del_train(\''+this.module_num+'\');"/></li>'
                    
                });
                
                $("#my_train").append(tag);
        	} 
     	},
     	error: function(e){
            console.log(e.responseText);
        }
     });
}

function add_train(module_num){
    $.ajax({
        url: "/trainning/mytrain_list",
        type: "post",
        data: "module_num="+module_num,
        success : function(result){
            var tag="";
            $(result).each(function(){
                tag += '<li class="only-li"><p></p><img src="/train_model/moduleImg/'+ this.module_img +'" alt=""><p>' + this.module_title + '</p><p>'+this.module_content+'</p><input type="button" value="삭제하기" class="deldel-btn" onclick="del_train(\''+this.module_num+'\');"/></li>'
                $("#my_train").append(tag);
            });
        },
        error: function(e){
            console.log(e.responseText);
        }
    });
}

$(function(){   
	 $("#selectMyTrain").on('change',function() {
       //옵션 value 가져오기
       var data = "train_num="+$("#selectMyTrain").val();
       $("#my_train2").html("")
       $.ajax({
          url: '/trainning/get_train_list',
          data: data,
          type: 'post',
          
          success: function(result){
        	  	var tag="";
        	  	
             	$(result).each(function(){
                tag = '<li id="train_yoso" class="train-frm"><a class="li-a2" href="/trainning/start_train?module_num='+this.module_num+'"><img class="train-img" src="/train_model/moduleImg/'+ this.module_img +'"><p class="train-subject">' + this.module_title + '</p><p class="train-keyword">'+this.module_content+'</p></a></li>';
                	
                $("#my_train2").append(tag);
             });
             	
          },
          error: function(e){
             console.log(e.responseText);
          }
       })
     });
});  
</script>