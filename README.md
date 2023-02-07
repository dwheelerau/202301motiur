# 202301motiur  
A docker image of the hawkweed yolo based detection model for running these on windows.  

# Introduction  
Clone this repo.  
```
git clone https://github.com/dwheelerau/202301motiur.git
```
Change into the repo directory 
```
cd 202301motiur
```

Copy the yolov5 directory from Motiur to this current directory, it should look like this:  
```
-Dockerfile
-README.md
-test-cpu.sh
-test-gpu.sh
yolov5
```   

Copy the two test scripts `test-cpu.sh` and `test-gpu.sh` into the yolov5 directory.  
```
cp test-* yolov5/
```

Build the container.  

```
sudo docker build -f Dockerfile . -t dwheelerau/hawkweed:ubuntu2004
```

# Quickstart
The following should mount your current directory and save the test results to it.

## CPU test script   
```
sudo docker run -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && bash /build/202301motiur/yolov5/test-cpu.sh"
```  

## GPU test script  
You will need a reasonably large RAM GPU.  
```
sudo docker run --gpus all -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && bash /build/202301motiur/yolov5/test-gpu.sh"
```

# Running inference using the python script on the test data

```
# cpu
sudo docker run -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && python /build/202301motiur/yolov5/detect.py --device cpu --weights /build/202301motiur/yolov5/runs/train/exp72/weights/best.pt --img 5320 7968 --conf 0.45 --iou 0.35 --source /build/202301motiur/Test_Images_MacGregorsCreek --name DetectedTest_Images_MacGregorsCreek_cpu --project /project/"

# or GPU  
sudo docker run --gpus all -it -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004 /bin/bash -c "cd /project && python /build/202301motiur/yolov5/detect.py --device gpu --weights /build/202301motiur/yolov5/runs/train/exp72/weights/best.pt --img 5320 7968 --conf 0.45 --iou 0.35 --source /build/202301motiur/Test_Images_MacGregorsCreek --name DetectedTest_Images_MacGregorsCreek_gpu --project /project/"
```

# Running inference using the python script on your own images
This assumes you have your images in a folder called `images` located in your current working directory.    

Start the container in detached mode `-d` after mounting your cwd.  

```
# -it is interactive tty
# -d detached so keep running after command is executed
 sudo docker run -it -d -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004
```
See what it is called.  
```
sudo docker ps -a
CONTAINER ID   IMAGE                            COMMAND       CREATED         STATUS         PORTS     NAMES
04f40d0ae645   dwheelerau/hawkweed:ubuntu2004   "/bin/bash"   7 seconds ago   Up 6 seconds             dazzling_moser
```
Execute a command on the running container (the `projects` directory will already be mounted in your cwd).  

```
# change the name based on the above output from `ps -a`
# if GPU available: --gpus all
# if GPU available: --device gpu
sudo docker exec -it dazzling_moser /bin/bash -c "cd /project && python /build/202301motiur/yolov5/detect.py --device cpu --weights /build/202301motiur/yolov5/runs/train/exp72/weights/best.pt --img 5320 7968 --conf 0.45 --iou 0.35 --source /project/images --name iamges_out --project /project/"
```

# Running the container interactively  
Start the container in detached mode after mounting your cwd.  

```
# -it is interactive tty
# -d detached so keep running after command is executed
 sudo docker run -it -d -v `pwd`:/project dwheelerau/hawkweed:ubuntu2004
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
