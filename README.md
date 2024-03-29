# Build Box

Primitive recorder/installer for LSL and Open Simulator platforms.

![OpenSimulator](https://raw.githubusercontent.com/nuxy/LSL-OS-Build-Box/master/demo.gif)

## What is this for?

When building objects within the simulator there is a server-based limitation of 256 primitives that can be used within a linkset group. On designs that require a large number of primitives this poses an issue resulting in having to break up your objects into multiple parts only having to carefully reassemble them once instantiated.

This project aims to provide a workaround by allowing you to ‘Record’ the current vector position and rotation axis of primitives and object link sets so that you can ‘Install’ them later with ease.

## Other uses

The scripts provided can also be used to redistribute your objects as a single package allowing for easy installation.

## Assumptions

It is assumed that you have a clear understanding of how to create objects within LSL or Open Simulator and are familiar with the development tools they provide.

## Set-up

There are two scripts required in order for this to work.

- [Manager.lsl](https://github.com/nuxy/LSL-OS-Build-Box/blob/master/Manager.lsl) (Recorder/Installer script)

- [Object.lsl](https://github.com/nuxy/LSL-OS-Build-Box/blob/master/Object.lsl) (Action script)

Setting this up is fairly easy.

1. Create a new primitive and copy the _Manager_ script to the *Inventory* contents.  As for the _Object_ script, this should be copied to the same location on all primitives and object link sets.  Keep in mind that you only need one _Object_ script per primitive or linkset group.

2. Double click on the primitive that contains the _Manager_ script.  When the dialog window appears, click ‘Record’.  Based on the complexity of your design the recording process can take up to a minute to complete.  After the process finishes, copy all of your objects into the _Manager_ primitive *Inventory* contents.  It is important to test your package prior to removing your original objects.  If there is something you missed, repeat the process where necessary.

## To Do

As of current, on installation, all objects are instantiated to the region prior to being assembled.  In the future, I intend to make this process transparent to the end-user.  I will also be adding a micro-framework for builders who intend to redistribute their objects within the meta-verse.  This will include the standard Notecard and customizable installation dialog window.

## License and Warranty

This package is distributed in the hope that it will be useful, but without any warranty; without even the implied warranty of merchantability or fitness for a particular purpose.

_LSL-OS-Build-Box_ is provided under the terms of the [MIT license](http://www.opensource.org/licenses/mit-license.php)

## Author

[Marc S. Brooks](https://github.com/nuxy)
