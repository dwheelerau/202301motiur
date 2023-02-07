# results save in run/detect
python /build/202301motiur/yolov5/detect.py --device cpu --weights /build/202301motiur/yolov5/runs/train/exp72/weights/best.pt --img 5320 7968 --conf 0.45 --iou 0.35 --source /build/202301motiur/Test_Images_MacGregorsCreek --name DetectedTest_Images_MacGregorsCreek_cpu --project /project/
