# JSPanel-Xojo

[jsPanel4](https://github.com/Flyer53/jsPanel4) is a JavaScript library to create highly configurable floating panels, modals, tooltips, hints/notifiers/alerts or contextmenus for use in backend solutions and other web applications developed by [Flyer53](https://github.com/Flyer53/jsPanel4).

JSPanel-Xojo is a jsPanel4 [Wrapper](https://en.wikipedia.org/wiki/Wrapper) for [Xojo](https://xojo.com/) Web 2.0  (version >= 2020r1)  developed used Xojo WebSDK 2.0.

Tested and working versions of JSPanel start from 4.11.4 up to 4.16.1 (latest current version at the time of code publication).

# Highlights

- Using WebContainers to design your own Dialogs.
- Adds Features not found in Xojo such as : Maximize,Minimize,Resize, Smallify
- Create hint messages.
- Create Dialog with custom buttons (Ex: Yes Or No)
- Create Progress Dialogs that remain visible until the indicated routine is completed
- Create Progress Dialogs with messages that can be updated during the execution of a WebThread.
- Ability to create Master and Slave Panels
- Ability to create a dialog that contains HTML code

Of course, not all the features of the base library are present, but only those that I have personally used in my own projects. It is possible to extend the functionality as desired.

## How to incorporate JSPanel-Xojo into your Realbasic/Xojo project

- Clone this repository
- Open the AttyWebJSPanel.xojo_project file.
- Copy the JSClass SDK Folder to your project
- Copy all variables and functions Present in the Session element
- View how the library works via the examples present in the Class for Test folder

## Screenshot
![Palette Dialog](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot1.png)
![Progress](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot2.png)
![Msg Yes or No](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot3.png)
![MasterAndSlave](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot4.png)
![Modal](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot5.png)
![Thread Progress](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot6.png)
![HTML Dialog + Hint](https://github.com/attyskater/JSPanel-Xojo/blob/main/images/Screenshot7.png)
## Current Version : 2.1.0

## Changelog from 2.0.0 to 2.1.0
- Fix resize bug
- Add minResizeHeight e minResizeWidth properties


![made with Xojo](https://xojo.com/account/mwx/mwx_long.png)
