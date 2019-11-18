# Setting up VSCode for STM32 Arduino 
Goal is to build Arduino STM32 projects, without the Arduino IDE being installed.  

## Workflow
Setup a project by cloning this skeleton project. This sets up a fully configured VSCode project.  
Edit the Blink.cpp in the sources folder to your needs. You can add any number of sources files.  

Hit F5, the source should be compiled (first time, the Arduino core is also compiled), the compiled firmware is uploaded to the device.  
The debugger starts, stopping at the main entry, ready for executing setup and loop.  

There are tasks for build (```make``` on the terminal), flash (```make flash``` on the terminal) and clean (```make clean``` on the terminal).  
The compiled firmware is in the bin folder, the objects in the obj folder.

During coding, intellisense assists:  
![Intellisense](doc/intellisense.png?raw=true "")
<br/>
<br/>
Debugger at a breakpoint, showing global and local vars. Also a variable is watched:  
![Debugger](doc/debugger.png?raw=true "")


## Getting Started

### Prerequisites
Windows 10  
Visual Studio Code  
Git for Windows  

### Installing
There are several tools needed for building projects. Most tools do not need to be installed with an installer, but can simply be unzipped.  

When done, the toolchain tree should look like this:  
```
D:\Dev-Tools
| - Arduino_Core_STM32
| - CMSIS_5
| - gcc-arm-8
| - MinGW-W64
| - stlink-1.3.0-win64
```

### Arduino_Core_STM32
Download the zip from [Github -> Arduino_Core_STM32](https://github.com/stm32duino/Arduino_Core_STM32)  
Unpack it under the root of the toolchain, and rename the folder to Arduino_Core_STM32, removing the master at the end.  

### CMSIS_5
Download the zip from [Github -> CMSIS_5](https://github.com/ARM-software/CMSIS_5)  
Unpack it under the root of the toolchain.  

### gcc-arm-8
Download the zip from [developer.arm.com](https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-win32.exe?revision=b3eb9c4d-f49f-4694-8928-2084c9f090ac?product=GNU%20Arm%20Embedded%20Toolchain,32-bit,,Windows,8-2019-q3-update)  
Unpack it under the root of the toolchain, and rename the folder to gcc-arm-8.  
Edit your path (windows r --> env) and add the bin dir of the toolchain.  

### MingGw-X64
Download the zip from [sourceforge](https://sourceforge.net/projects/mingw-w64/)  
Unpack it, and move the folder under the dev tools.
Edit your path (windows r --> env) and add the bin dir of the MingGw-X64.  
MingGW-X64 is used for make.  For convenience, just copy mingw32-make.exe to make.exe (220kB).    

### stlink-1.3.0-win64
Download the zip from [github](https://github.com/texane/stlink/releases/tag/1.3.0)  
Unpack it, and move the folder under the dev tools.  

### Preparing Visual Studio Code
VSCode needs two extensions:  
- C/C++ for Visual Studio Code  
- Cortex Debug  

For intellisense to work, ```c_cpp_properties.json``` in the .vscode folder needs to be configured with the right settings. Use the same settings for family, proc and board as in the makefile.  
```settings.json``` needs to be configured with the path to stutil.


## Starting a new project from scratch

### Preparation
Clone the skeleton from github:  
```
git clone https://github.com/JBerg60/Arduino-VSCode.git
```
Rename the folder to something useful, F030-Blink seems sensible.
Open this folder in VSCode.

### Setting the target
The repo is configured for a STM32F103C8, a BluePill board on sale for a few dollar on Aliexpress.  
Lets say we want to change to a STM32F030F4 board, that is even cheaper as the BluePill.

Edit the Makefile:  
```
FAMILY = STM32F0xx
BOARD = DEMO_F030F4
PROC = STM32F030x6
ARM = cortex-m0
```  
Edit the sketch, the LED on this board is on PA4.  
Run the build task(or use ```make``` in a bash terminal), build should be without any errors.  

note: for intellisense to work, these settings also need to be configured in ```c_cpp_properties.json```.


### Useful commands
```
make -> build the system (shortcut ctrl-shift b)  

make clean -> clean the system (shortcut ctrl-shift c)  

make info -> get info on the connected device (shortcut ctrl-shift i).  

make flash -> flash the firmware to the device (shortcut ctrl-shift f).  
                If necessary, the firmware is build before flashing. 

F5 starts the debugger in Visual Studio Code  

Ctrl-F5 stops the debugger.  

```

### Useful links  


## Authors

* **John Berg** - *Maintainer* - [NetbaseNext](https://netbasenext.nl)

See also the list of [contributors](https://github.com/JBerg60/Arduino-VSCode/graphs/contributors) who participated in this project.

## License

MIT License.

## Acknowledgments

* Stackoverflow
