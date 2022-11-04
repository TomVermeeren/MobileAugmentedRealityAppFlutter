var World = {
    loaded: false,
    videoLink: "",


    newData: function newDataFn(videoId) {
        switch(videoId){
            case 1:
                console.log("de videoId is " + videoId)
                World.videoLink = "assets/aanwijzingsbordenvideo.mp4"
                break;
            case 2:
                World.videoLink = "assets/verbodsbordenvideo.mp4"
                break;
            case 3:
                World.videoLink = "assets/voorrangsbordenvideo.mp4"
                break;
            case 4:
                World.videoLink = "assets/gebodsbordenvideo.mp4"
                break;
            case 5:
                World.videoLink = "assets/aanwijzingsbordenvideo.mp4"
                break;
            default:
                break;
        }
        
        console.log("de videoLink is " + World.videoLink)
    },

    createOverlays: function createOverlaysFn() {
        /*
            First a AR.TargetCollectionResource is created with the path to the Wikitude Target Collection(.wtc) file.
            This .wtc file can be created from images using the Wikitude Studio. More information on how to create them
            can be found in the documentation in the TargetManagement section.
            Each target in the target collection is identified by its target name. By using this
            target name, it is possible to create an AR.ImageTrackable for every target in the target collection.
         */
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/tracker.wtc", {
            onError: World.onError
        });

        /*
            This resource is then used as parameter to create an AR.ImageTracker. Optional parameters are passed as
            object in the last argument. In this case a callback function for the onTargetsLoaded trigger is set. Once
            the tracker loaded all of its target images this callback function is invoked. We also set the callback
            function for the onError trigger which provides a sting containing a description of the error.

            To enable simultaneous tracking of multiple targets 'maximumNumberOfConcurrentlyTrackableTargets' has
            to be set.
            to be set.
         */
        this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
            maximumNumberOfConcurrentlyTrackableTargets: 5, // a maximum of 5 targets can be tracked simultaneously
            /*
                Disables extended range recognition.
                The reason for this is that extended range recognition requires more processing power and with multiple
                targets the SDK is trying to recognize targets until the maximumNumberOfConcurrentlyTrackableTargets
                is reached and it may slow down the tracking of already recognized targets.
             */
            extendedRangeRecognition: AR.CONST.IMAGE_RECOGNITION_RANGE_EXTENSION.OFF,
            onError: World.onError
        });

        /*
            Pre-load models such that they are available in cache to avoid any slowdown upon first recognition.
         */

        /*
            Note that this time we use "*" as target name. That means that the AR.ImageTrackable will respond to
            any target that is defined in the target collection. You can use wildcards to specify more complex name
            matchings. E.g. 'target_?' to reference 'target_1' through 'target_9' or 'target*' for any targets
            names that start with 'target'.
         */
        // Create overlay for page one


            var imgOne = new AR.ImageResource("assets/testknop.png");
            var overlayOne = new AR.ImageDrawable(imgOne, 0.7, {
                translate: {
                    y: 0.7
                },
                onclick: function(target){
                    AR.platform.sendJSONObject({
                        "image_scanned" : target.name
                    });
                }
            });

            var video = new AR.VideoDrawable((World.videoLink).toString(), 1, {
                translate: {
                    y: 1.4
                }});


            var pageOne = new AR.ImageTrackable(this.tracker, "*", {
                drawables: {
                    cam: [overlayOne, video]
                },
                onImageRecognized: function onImageRecognizedFn(target) {
                    if (this.hasVideoStarted) {
                        video.resume();
                    }
                    else {
                        this.hasVideoStarted = true;
                        video.play(-1);
                    }
                    AR.platform.sendJSONObject({
                        "image_scanned" : target.name
                    });
                },
                onImageLost: function onImageLostFn() {
                    video.pause();
                },
            });
    },

    onError: function onErrorFn(error) {
        alert(error);
    },
};
