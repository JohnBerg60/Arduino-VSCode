# Setting up VSCode for STM32 Arduino 
Goal is to build Arduino STM32 projects, without the Arduino IDE beeing installed.  

## Workflow
Setup a project by cloning this skelleton project. This sets up a fully configured VSCode project.  
Edit the Blink.cpp in the sources folder to your needs. You can add any numbers of sources files.  

Hit F5, the source should be compiled (first time, the Arduino core is also compiled), the compiled firmware is uploaded to the device.  
The debugger starts, stopping a the main entry, ready for executing setup and loop.  

There are task for build (make on the terminal), and clean (make clean on the terminal).  
The compiled firmware is in the bin folder, the objects in the obj folder.

## Getting Started

### Prerequisites
Windows 10  
Visual Studio Code  
Git for Windows  

### Installing
There are several tools needed for building projects. Most tools do not need to be installed with a installer, but can simply be unzipped.  

When done, the toolchain tree should look like this:  
```
D:\Dev-Tools
| - Arduino_Core_STM32
| - gcc-arm-8
| - MinGW-W64
| - stlink-1.3.0-win64
```

### Arduino_Core_STM32

Download the zip from [Github -> Arduino_Core_STM32](https://github.com/stm32duino/Arduino_Core_STM32)  
Unpack it under the root of the toolchain, and rename the folder to Arduino_Core_STM32, removing the master at the end.  

### gcc-arm-8

### MingGw-X64
GNU ARM Embedded Toolchaing (V8 Q3)

Most of the time, the instructions in the usefull links can be followed.  
Install MingGw-X64 on a location without a space in the path.  
Example:  

```
D:\Dev-Tools\mingw-w64
```

MingGW-X64 is used for make.  For convinience, just copy mingw32-make.exe to make.exe (220kB)  

The ARM toolchain can be a zip file, that is unzip in a conviniant place:  
```
D:\Dev-Tools\arm-gnu-8
```

In Visual Studio Code It is not possible to assigns keybindings on a project basis to tasks, so add the keybinding global, and give the tasks some global names.  

F5 is already the key to start the debugger!

Git has a bash terminal, that can be started by making a shortcut in Windows.  
Visual Studio Code also can start Powershell, Cmd and Bash terminals.  
By starting a bash terminal, we can act if we where on unix for our makescript, making it platform independent, and much easyer!

## Using the system

Buildd your C/C++ project structure as you like.  
From the commandline, or in Visual Studio code

```
make -> build the system (shortcut ctrl-shift b)  
make clean -> clean the system (shortcut ctrl-shift c)  
F5 starts the debugger in Visual Studio Code

```

### Usefull links  

https://code.visualstudio.com/docs/cpp/config-mingw  
https://stackoverflow.com/questions/42752721/mingw-64-ships-without-make-exe  
https://sourceforge.net/projects/mingw-w64/  
https://code.visualstudio.com/docs/getstarted/keybindings  

Tutorial on Makefile:  
https://www.youtube.com/watch?v=_r7i5X0rXJk  

## Deployment

The compiled files are in the bin folder.

## Authors

* **John Berg** - *Maintainer* - [NetbaseNext](https://netbasenext.nl)

See also the list of [contributors](https://github.com/JBerg60/Arduino-VSCode/graphs/contributors) who participated in this project.

## License

MIT License.

## Acknowledgments

* Stackoverflow
