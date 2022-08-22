var video = document.querySelector("#videoElement");
                navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUsermedia 
                    || navigator.mozGetUserMedia || navigato.msGetUserMedia || navigator.oGetUserMedia;

                    if(navigator.getUserMedia){
                      navigator.getUserMedia({video:true}, handleVideo, videoError)      
                    }

                    function handleVideo(stream){
                    video.srcObject = stream;
                    video.play();
                    }

                    

                    function videoError(e){}


                    let disconnect = document.getElementById('disconnect');

                    disconnect.addEventListener('click', function(){

                      video.srcObject = null;
                    })


                    let connect = document.getElementById('connect');

                    connect.addEventListener('click', function(){

                      var video = document.querySelector("#videoElement");
                navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUsermedia 
                    || navigator.mozGetUserMedia || navigato.msGetUserMedia || navigator.oGetUserMedia;

                    if(navigator.getUserMedia){
                      navigator.getUserMedia({video:true}, handleVideo, videoError)      
                    }

                    function handleVideo(stream){
                    video.srcObject = stream;
                    video.play();
                    }

                    

                    function videoError(e){}
                    })

                    let mute = document.getElementById('mute');
                    let muteStatus = false;

                    mute.addEventListener('click', function(){
                      if(muteStatus == false){
                      $('#mute').addClass('btn-danger');
                      $('#mute').removeClass('btn-secondary');
                      muteStatus = true;
                      }

                      else{
                      $('#mute').addClass('btn-secondary');
                      $('#mute').removeClass('btn-danger');
                      muteStatus = false;
                      }

                    })

                    


                    

                    

                   

