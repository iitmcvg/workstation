# README

## Getting Started with Docker 

Firstly, download a compatible version of docker from here:

* For installation of Docker in Windows - https://download.docker.com/win/stable/DockerToolbox.exe 
* For installation of Docker in Linux(Ubuntu) - https://docs.docker.com/install/linux/docker-ce/ubuntu/   
* For installation of Docker in Mac -   
https://download.docker.com/mac/stable/Docker.dmg 


### Installation

* Before installation, additional software packages like Kitematic and Virtualbox can be unchecked. 
* The installer adds Docker Toolbox to your Applications folder.   
* On your Desktop, find the Docker QuickStart Terminal icon.  
* Click the Docker QuickStart icon to launch a pre-configured Docker Toolbox terminal.    
* If the system displays a User Account Control prompt to allow VirtualBox to make changes to your computer. Choose Yes.  
* The terminal does several things to set up Docker Toolbox for you. When it is done, the terminal displays the $ prompt.  
* Make the terminal active by clicking your mouse next to the $ prompt.
* The prompt is traditionally a $ dollar sign. You type commands into the command line which is the area after the prompt. Your cursor is indicated by a highlighted area or a | that appears in the command line. After typing a command, always press RETURN.

### Running the Container

* Run the command **docker-machine ip** and make a note of the IP address shown as output. You can skip this if you are on macOS or Ubuntu.

* Run the container:
```
docker run -it --name sampark --rm -p 8888:8888 iitmcvg/py36:lite
```

The image has the following tools:

  * OpenCV 3.4.1
  * Jupyter
  * Scientific python: Numpy, Scipy, Matplotlib ... etc.

* The command does some work for you. Downloading takes around 5 minutes. Be patient. Once the extraction is complete, you should see a terminal shell corresponding to the container (eg: root@xxxxxx).

* You should also see something similar to this:

```
[I 18:24:20.330 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[I 18:24:20.542 NotebookApp] Serving notebooks from local directory: /workspace
[I 18:24:20.542 NotebookApp] The Jupyter Notebook is running at:
[I 18:24:20.543 NotebookApp] http://(2545641d3489 or 127.0.0.1):8888/?token=ba41c6125383385819903eca036225bf0228c7a2fc7d387d
[I 18:24:20.543 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 18:24:20.548 NotebookApp] No web browser found: could not locate runnable browser.
[C 18:24:20.548 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-6-open.html
    Or copy and paste one of these URLs:
        http://(2545641d3489 or 127.0.0.1):8888/?token=ba41c6125383385819903eca036225bf0228c7a2fc7d387d
```

* Copy this URL, replace everything within () to the IP address that you noted down in the first step and paste this new URL in your browser.

For example, http://192.168.99.100:8888/?token=e99ef0776ac2c2d848d580e7e86d10a5f8e187fe20be8ae3

* You are good to go if Jupyter Notebook successfully opens up in your browser.



