<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/recipeWrite.css" type="text/css" />
<script src="/js/recipeScript.js"></script>

<div>
	<!-- 재료 모달창 -->
	<div class="modal fade" id="ingredModal">
		<div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
			<div class="modal-header">
	        <h4 class="modal-title">Ingredient List</h4>
	        <button type="button" class="close" data-dismiss="modal" onclick="ingredReset();">&times;</button>
		</div>
		
	    <div class="modal-body">
	    	<!-- 재료 리스트 -->
	    	<div id="ingredView">
	    		<form method="post" action="/recipe/searchIngred" id="ingredSearch">
		    		<select name="searchKey">
		    			<option>재료명</option>
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
	    		<input type="hidden" name="board_num" id="ingredBoardNum" value="${vo[0].board_num}"/>
	    		<input type="hidden" name="gred_kcal" id="ingredKcal" value=""/>
				<ul id="measurement">
					<li onclick="mesureClick('100');"><img src="/recipeImg/mesure.png"><p class="g1">100g</p></li>
					<li onclick="mesureClick('200');"><img src="/recipeImg/mesure.png"><p class="g2">200g</p></li>
					<li onclick="mesureClick('300');"><img src="/recipeImg/mesure.png"><p class="g3">300g</p></li>
				</ul>
				<p style="font-size:0.8em; margin:0; color:gray;">*정확한 칼로리 계산을 위해 <br/>직접 입력하시는 것을 추천드립니다.</p>
	    		<div id="ingredInfo">
	    			<input type="number" name="gred_gram" id="ingredGram" placeholder="직접입력"/>&nbsp;g
	    			<p id="gKcal">kcal: <p/>
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
	<form method="post" action="/recipe/editRecipe" id="writeFrm" enctype="multipart/form-data">
		
		<div id="imgDiv">
			<!-- 이미지 첨부 -->
			<input type="file" name="file" id ="file" value="none"/>
			<input type="hidden" name="originRecipeImg" value="${vo[0].recipe_img_file}" id="originRecipeImg"/>
			<input type="hidden" name="recipe_img_file" value="${vo[0].recipe_img_file}" id="imgFile"/>
			<a href="javascript:void(0);"><img src="/recipeImg/upload/${vo[0].recipe_img_file}" id="preview"/></a>
		</div>
		
		<div id="recipeInfo">
			<input type="hidden" name="board_num" id="board_num" value="${vo[0].board_num}"/>
			
			<!-- title -->
			<p id="title">레시피명&nbsp;&nbsp;<input type="text" name="title" value="${vo[0].title}"/></p>
	
			<!-- 재료 리스트 -->
			<p>재료
				<button type="button" onclick="deleteAllIngred(${vo[0].board_num});" style="margin-left:10px; background-color: #ddd;" title="모든 재료 삭제">삭제</button>
				<button type="button" data-toggle="modal" data-target="#ingredModal">추가</button>
			</p>
			<ul id="ingredList">
				<c:forEach var="list" items="${gredList}">
					<li id="${list.gred_num}" onclick="deleteIngred(${list.gred_num}, ${list.board_num}, ${list.gred_gram});">
						${list.gred_name}&nbsp;${list.gred_gram}g
						<span class="times">&times;</span>
					</li>
				</c:forEach>
			</ul>
			
			<!-- 레시피 설명 -->
			<p>레시피 설명 <span id="totalKcal">Total: ${vo[0].total_kcal}kcal</span></p>
			<textarea name="content" id="content">${vo[0].content}</textarea>
			<input type="hidden" name="total_kcal" id="total_kcal" value="${vo[0].total_kcal}"/>
			
			<!-- 버튼 -->
			<div id="recipeBtn">
				<input type="reset" value="취소"/>
				<input type="submit" value="수정" style="margin-right:30px;"/>
			</div>
		</div>
	</form>
</div>