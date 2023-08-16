<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/train/test_train.css">
<script type="text/javascript" language="JavaScript">
	function hideDiv (){
		document.getElementById("hideVideo").style.display="none";
	}
	self.setTimeout("hideDiv()",5000); // 초 지정
</script>
<div>사이드 레터럴 레이즈</div>
<div class="video-frm">
	<div class="item" id="hideVideo">

		<div><video class="ready-video" src="/train_model/countdown5s.mp4" autoplay muted style="width:800px"></video></div>

		<div><canvas id="canvas" style="width:800px"></canvas></div>
		<div id="label-container"></div>
	</div>
	
	<div class="item">
		<P id="display"></P>
		영상 띄워 놓는곳
		<video id="video1" src="/train_model/moduleVod/사이드 컬.mp4" autoplay controls loop muted style="width:800px"></video>
	</div>
</div>

<!-- <button type="button" onclick="init()">시작하기</button> -->



<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/pose@0.8/dist/teachablemachine-pose.min.js"></script>
<script type="text/javascript">

    const URL = "/train_model/module/";
    let model, webcam, ctx, labelContainer, maxPredictions;

    async function init() {
        const modelURL = URL + "사이드 컬_model.json";
        const metadataURL = URL + "사이드 컬_metadata.json";

        
        model = await tmPose.load(modelURL, metadataURL);
        maxPredictions = model.getTotalClasses();


        const size = 600; //웹캠 사이즈
        const flip = true;
        webcam = new tmPose.Webcam(size, size, flip); 
        await webcam.setup(); // request access to the webcam
        await webcam.play();
        window.requestAnimationFrame(loop);

        // append/get elements to the DOM
        const canvas = document.getElementById("canvas");
        canvas.width = size; canvas.height = size;
        ctx = canvas.getContext("2d");
        labelContainer = document.getElementById("label-container");
        for (let i = 0; i < maxPredictions; i++) { // and class labels
            labelContainer.appendChild(document.createElement("div"));
        }
    }

    async function loop(timestamp) {
        webcam.update(); // update the webcam frame
        await predict();
        window.requestAnimationFrame(loop);
    }
    var count = 0;
    var status = "one";
    async function predict() {

        const { pose, posenetOutput } = await model.estimatePose(webcam.canvas);

        const prediction = await model.predict(posenetOutput);

        var p1 = prediction[0].probability.toFixed(2);
        var p2 = prediction[1].probability.toFixed(2);
        var p3 = prediction[2].probability.toFixed(2);
        
       //two에서 one이 돼야 운동 한 거
        if (p1 == 1.0){   //어깨접기
           if(status=="two"){
              count++;
              console.log(count);
           }
              status = "one";
        }else if(p2==1.0){//앞으로
           status = "two";
        }else if(p3==1.0){
           status = "three";
           console.log("자세 제대로 해");
        }
        
        for (let i = 0; i < maxPredictions; i++) {
            const classPrediction =
                prediction[i].className + ": " + prediction[i].probability.toFixed(2);
            labelContainer.childNodes[i].innerHTML = classPrediction;
        }

        // finally draw the poses
        drawPose(pose);
    }

    function drawPose(pose) {
        if (webcam.canvas) {
            ctx.drawImage(webcam.canvas, 0, 0);
            // draw the keypoints and skeleton 키포인트와 골격을 그려줌
            if (pose) {
                const minPartConfidence = 0.5;
                tmPose.drawKeypoints(pose.keypoints, minPartConfidence, ctx);
                tmPose.drawSkeleton(pose.keypoints, minPartConfidence, ctx);
            }
        }
    }
    setTimeout(() => {
        init()
    }, 4000);
    // init();
</script>
    <div>
    	<button onclick="save_train()">운동 끝내기</button>
    </div>