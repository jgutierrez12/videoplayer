ffmpeg -rtsp_transport tcp \
    -i "rtsp://admin:5219E4766d@192.168.1.88:554/H264&ch=1&subtype=0" \
    -i "rtsp://admin:5219E4766d@192.168.1.88:554/H264&ch=2&subtype=0" \
    -filter_complex "
        nullsrc=size=960x1080 [base];
        [0:v] setpts=PTS-STARTPTS, scale=960x540 [upperleft];
        [1:v] setpts=PTS-STARTPTS, scale=960x540 [lowerleft];
        [base][upperleft] overlay=shortest=1 [tmp1];
        [tmp1][lowerleft] overlay=shortest=1:y=540
      " \
	-c:v libx264 -preset superfast -crf 18 -r 500/21 -f matroska - | ffplay -
