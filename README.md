# Godot Eyesee Color Plugin

Simulate color vision deficiencies directly within the editor to identify accessibility issues. You can watch an overview [here](https://youtu.be/L8-EHO303QU).

**Supported filters:**
- Protanopia
- Deuteranopia
- Tritanopia
- Achromatopsia

Filters can be selected via the **“CVD”** dropdown in the main menu panel for both 2D and 3D screens. The plugin works by inserting shader materials into all subviewport containers.
**Note:** As a limitation, this also affects gizmos.

**Simulation methods:**
- **Protanopia** and **Deuteranopia** are simulated using the method described by Viénot, F., Brettel, H., & Mollon, J. D. (1999): *Digital video colourmaps for checking the legibility of displays by dichromats*. *Color Research & Application, 24(4), 243–252.* [PDF link](https://vision.psychol.cam.ac.uk/jdmollon/papers/colourmaps.pdf). This method is fast and stable.
- **Tritanopia** is simulated using the method by Brettel, H., Viénot, F., & Mollon, J. D. (1997): *Computerized simulation of color appearance for dichromats*. *Journal of the Optical Society of America A, 14(10), 2647–2655.* [DOI](https://doi.org/10.1364/josaa.14.002647). This is the most accurate simulation for tritanopia.
- **Achromatopsia** is simulated using the luminance formula from ITU-R BT.601. [ITU spec](https://www.itu.int/rec/R-REC-BT.601-7-201103-I)

For a great article on color blindness and simulation methods, visit: [daltonlens.org/opensource-cvd-simulation](https://daltonlens.org/opensource-cvd-simulation).

These shaders are based on the excellent open-source library: [github.com/DaltonLens/libDaltonLens](https://github.com/DaltonLens/libDaltonLens).

Standalone canvas shaders are available [here](https://godotshaders.com/shader/color-vision-deficiency-cvd-simulation-shader/). (Also by me!)
