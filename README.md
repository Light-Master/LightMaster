# LightMaster

## Getting Started - 03.05.21
1. Make sure flutter is added to your PATH, for all systems
2. Depending on the system install the following:

	1. Android ... after installing Android Studio and the SDK run:
		1. **flutter config --android-sdk** to update its location
	2. iOS:	
		1. **sudo xcode-select --switch /Application/Xcode.app/Contents/Developer**
		2. **sudo xcodebuild -runFirstLaunch**
	3. Web ... apparently only Chrome works so yeah install it
	
	When in doubt run:
	**flutter doctor**
3. The project has been created and is located inside the light_master_app directory. This was achieved via the flutter create command. To run the app the simulator needs to be running and then type the command flutter run. Afterwards a web interface will be made available that provides valuable insight into the simulated device. This interface' name is printed out in the terminal and accessable via *127.0.0.1:9100?xxxx....*

