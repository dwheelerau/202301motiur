# 202301motiur  
A docker image of the hawkweed yolo based detection model for running these on windows.  

# Introduction  
XXXX

# Quickstart
Pull the container from the docker hub by search for `dwheelerau/hawkweed`.  

The following should mount your current directory and save the test rusults to it.

# CPU  
```
sudo docker run -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && bash /build/202301motiur/yolov5/test-cpu.sh"
```
## GPU
You will need a reasonably large RAM GPU.  
```
sudo docker run --gpus all -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && bash /build/202301motiur/yolov5/test-gpu.sh"
```

# Running inference on real data
What path do I use for the infile???

 
```
# fix --source /build/202301motiur/Test_Images_MacGregorsCreek I think it should be --source /build/Test_Images_MacGregorsCreek
sudo docker run --gpus all -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && python /build/202301motiur/yolov5/detect.py --device cpu --weights /build/202301motiur/yolov5/runs/train/exp72/weights/best.pt --img 5320 7968 --conf 0.45 --iou 0.35 --source /build/202301motiur/Test_Images_MacGregorsCreek --name DetectedTest_Images_MacGregorsCreek_gpu
"

# Running the container interactively  
Start the container in detached mode after mounting your cwd.  
```
# -it is interactive tty
# -d detached so keep running after command is executed
 sudo docker run -it -d -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash
```
See what it is called.
```
sudo docker ps -a
##CONTAINER ID   IMAGE                            COMMAND       CREATED         STATUS         PORTS     NAMES
##2414a542a929   dwheelerau/hawkweed:ubuntu2004   "/bin/bash"   4 seconds ago   Up 3 seconds             determined_haibt
```
Now you can log in.
```
sudo docker exec -it determined_haibt /bin/bash
```
You should be able to interact with this container via the command line and /build/ is mounted in your cwd on the host.  

# Creating the image and running the container without pulling from docker hub
To build this file:  

```
sudo docker build -f Dockerfile . -t dwheelerau/hawkweed:ubuntu2004
```
```
