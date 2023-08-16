/*=============== top =================*/





/*=============== main =================*/
$(document).ready(function() {
	/*$('.dropdown-content').hide();*/
	/*============== top ============== */
	/*$('.dropbtn').on('click',function(){
		console.log('position',$(this).position());
		console.log('offset',$(this).offset());
	 	let p = $(this).offset();
	 	$('.dropdown-content').css({
			'z-index':'100000000',	
			'left':p.left-$('.dropdown-content').width()*0.9,
			'top':p.top+20,
			'position':'absolute',
			'background':'white',
			'box-shadow': 'rgba(0, 0, 0, 0.05) 0px 6px 24px 0px, rgba(0, 0, 0, 0.08) 0px 0px 0px 1px'
	}).fadeToggle();
	});*/
	
	
	for(var i=0; i<$('.box').length;i++) {
		$('.quick>ul').append('<li></li>');
	}
	/*let $width = $(document).width()*0.549-$('.quick').width();*/
	/*$('.quick').css('left', $width+"px");*/
	$('.quick li').eq(0).addClass('on');
	
	function quick_button(idx) {
		$('.quick li').eq(idx).addClass('on').siblings(".on").removeClass("on");
	}
	
	function quick_click(idx) {
		$('.quick li').on('click', function(e) {
			e.preventDefault();
			idx = $(this).index();
			quick_button(idx);
			$('.container').animate({
				left: -array[idx]
			}, 500);
			ani_setTime(idx);
		});
	}
	function ani_setTime(idx) {
		if(idx==0) {
				$('.first .Title-line').removeClass('Title-effect');
				setTimeout(function() {
	  	 		$('.first .Title-line').addClass('Title-effect');
				},1);
			}else if(idx==1){
				$('.second .Title-line').removeClass('Title-effect');
				setTimeout(function() {
	  	 		$('.second .Title-line').addClass('Title-effect');
				},1);
			}else if(idx==2){
				$('.third .Title-line').removeClass('Title-effect');
				setTimeout(function() {
	  	 		$('.third .Title-line').addClass('Title-effect');
				},1);
			}else if(idx==3){
				$('.fourth .Title-line').removeClass('Title-effect');
				setTimeout(function() {
	  	 		$('.fourth .Title-line').addClass('Title-effect');
				},1);
			}else {
				alert('해당 페이지 인덱스는 사용할 수 없습니다.');
			}		
	}
	
	
/*===================================================================*/
	console.log($('.quick').outerWidth());
	$('.dropbtn2').on('click', function(){	
		let p = $(this).offset();
	 	$('.dropdown-content2').css({
			'left':p.left-$('.dropdown-content2').width()*0.9,
			'top':p.top+20	
		});
		$('.dropdown-content2').toggleClass('display-show');
	});
	
	$('.submenu2').on('click',function(){
		if($('.submenu2').index(this)==0) {
			location.href="/mypage";
		}
		else if($('.submenu2').index(this)==1) {
			location.href="/member/question";
		}
		else if($('.submenu2').index(this)==2) {
			location.href="/member/logout";
		}
		else {
			alert('잘못 입력되었습니다.');
		}
	});
	
	/*=========== button ==============*/
	$('.blob-btn').on('click', function(){
		if($('.blob-btn').index(this)==0) {
			location.href="/trainning/trainningHome";
		}else if($('.blob-btn').index(this)==1) {
			location.href="/recipe/main";
		}else if($('.blob-btn').index(this)==2) {
			location.href="/board/ptList";
		}else if($('.blob-btn').index(this)==3) {
			location.href="/boardList";
		}else {
			alert($('.blob-btn').index(this)+'해당클릭은 아무것도 연결되어있지 않습니다.');
		}
	});
	
	/*============== main ==============*/
	let d_width = 0; // 브라우저 가로
	let d_height = 0; // 문서 전체의 높이

	function tmp() {
		// container의 가로사이즈(화면가로 * box 개수)
		let con_width = $(window).outerWidth() * $('.box').length;

		$('.container').css({ width: con_width, height: '100vh', position: 'fixed', top: 0, left: 0 });
		$('.box').css({ width: con_width / $('.box').length, height: '100vh', float: 'left' });
		// box들을 위로 끌어올렸기 때문에 body의 높이는 100vh나 마찬가지인 상태. 
		// 그래서 억지로 전체 box들의 세로크기 만큼 body에 줘야한다.(스크롤 내리기위함) 
		// 이때 높이는 가로영역의 비율과 동일하게 준다. (이후 리미트를 주게 됨으로써 비율의 값이 정해진다.)
		$('body').css({ height: '100vh' }); let w_width = $(window).width();
		let w_height = $(window).height();

		// 스크롤 될때의 리미트
		d_width = con_width - w_width; // 전체 가로값 - 현재 화면의 가로값
		d_height = $('body').height() - w_height // 전체 세로값 - 현재 화면의 세로값
		console.log('d_width', d_width);
		console.log('d_height', d_height);
	}
	tmp();

	let array = [];
	for (let i = 0; i < $('.box').length; i++) {
		 array[i] = $('.box').eq(i).offset().left; 
	}
	
	let idx = 0;
	let chk = true;
	$('.box').on('mousewheel DOMMouseScroll', function() {
		// 휠 일정시간동안 막기
		if (chk) {
			chk = false; setTimeout(function() {
				chk = true;
			}, 500)

			// 휠 방향 감지(아래: -120, 위: 120)
			let w_delta = event.wheelDelta / 120;
			console.log('w_delta', w_delta);
			// 휠 아래로
			if (w_delta < 0 && $(this).next().length > 0) {
				$('.container').animate({
					left: -array[$(this).index() + 1]
				}, 500)
				idx=$(this).index() + 1;
			}

			// 휠 위로
			else if (w_delta > 0 && $(this).prev().length > 0) {
				$('.container').animate({
					left: -array[$(this).index() - 1]
				}, 500)
				idx = $(this).index() - 1;
			}
			console.log('idx',idx);
			quick_button(idx);
			ani_setTime(idx)
		}
	});
	
	quick_click(idx);
	
	
	//브라우저를 resize했을시를 대비해 박스의 크기는 다시 구해준다.
	$(window).resize(function() {
		for (let i = 0; i < $('.box').length; i++) {
			array[i] = $('.box').eq(i).offset().left
		} 
		tmp();		
	});
	
	
});



