<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/train/test_train.css">

<script type="text/javascript" language="JavaScript">
   function hideDiv (){
      document.getElementById("hideVideo").style.display="none";
   }
   self.setTimeout("hideDiv()",5000); // 초 지정

</script>
<div class="video-Form">
   <div class="subject-text"><h2>${vo.module_title}</h2></div>
   <div class="video-frm">
      <div class="video-1" id="hideVideo">
         <div><h3>　</h3></div>
         <div><video class="ready-video" src="/train_model/countdown5s.mp4" autoplay muted style="width:90%"></video></div>
      </div>
      <div class="video-2">
         <div><h3> 　</h3></div>
         <canvas id="canvas" style="width:90%"></canvas>
         <!-- <div id="label-container"></div> -->
      </div>
      <div class="video-3">
         <P id="display"></P>
         <div><h3> 　</h3></div>
         <div>
            <video id="video1" src="/train_model/moduleVod/${vo.module_title }.mp4" autoplay controls loop muted style="width:100%"></video>
         </div>
         <div class="video-3-1">
            <div class="video-3-2">
               <h3>자세측정률</h3>
               <div id="label-container"></div>
            </div>
            <div class="video-3-2">
               <h3>횟수</h3>
               <div class="count-font" id="count"></div>
            </div>
         </div>
      </div>
   </div>
   <div>
      <button class="end-btn" onclick="save_train()">운동 끝내기</button>
   </div>
</div>
    

<!-- <button type="button" onclick="init()">시작하기</button> -->
<!-- <div><canvas id="canvas"></canvas></div> -->
<!-- <div id="label-container"></div> -->
<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/pose@0.8/dist/teachablemachine-pose.min.js"></script>
<script type="text/javascript">

    const URL = "/train_model/module/";
    let model, webcam, ctx, labelContainer, maxPredictions;
    
   var module_title = "${vo.module_title}";
   const start = new Date()
   
    async function init() {
        const modelURL = URL + module_title + "_model.json";
        const metadataURL = URL + module_title + "_metadata.json";

        
        model = await tmPose.load(modelURL, metadataURL);
        maxPredictions = model.getTotalClasses();


        const size = 1000; //웹캠 사이즈
        const size2 = 1000;
        const flip = true;
        webcam = new tmPose.Webcam(size, size2, flip); 
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
        
       //two에서 one이 돼야 운동 한 거
        if (p1 >= 0.9){   //어깨접기
           if(status=="two"){
              count++;
              /* document.getElementById('hs').innerHTML = '횟수';  */
              document.getElementById('count').innerHTML = count;
              console.log(count);
           }
              status = "one";
        }else if(p2>=0.9){//앞으로
           status = "two";
        }
        
        for (let i = 0; i < maxPredictions-1; i++) {
            const classPrediction =
                "자세 정확도 " + ": " + prediction[i].probability.toFixed(2)*100 + "%";
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
        init();
    }, 4000);
    // init();
    
    function save_train(){
       const end = new Date()
       var train_count = parseInt((end - start)/1000);
       var module_title = "${vo.module_title}";
       console.log(train_count);
       
       if (confirm("운동을 그만 하시겠습니까??")) {
    	   location.href = "/trainning/save_user_count?train_count=" + train_count + "&module_title=" + module_title;
       } else {
           alert("취소되었습니다.");
       }
       
       /* location.href = "/trainning/save_user_count?train_count=" + train_count + "&module_title=" + module_title; */
    }
</script>
    