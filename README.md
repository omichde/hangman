# hangman via GroupActivities for iOS 15

To much of an exciting surprise Apple announced a new framework for iOS 15 to simultaneously join a video stream or custom experiences via a FaceTime call - this handman game is such a custom experience by playing "hangman" together.

![Screen](screen.png?raw=true)

The implementation is very rough but shows:

- how to set up and start a custom experience
- exchange data with participants
- draw a hangman (via PaintCode)

## Usage

- you need at least two devices on iOS 15
- you need two Apple IDs set up on these device to initiate a FaceTime call between them
- install the app on both devices, launch it on one, then tap connect (top left)
- provide a guess word and start the game (top right)
- when somebody wants to guess either a character or the full world, tap on the wand and enter your guess

# Disclaimer

This is an experiment on top of the current iOS 15 beta - as this project is a test to explore Group Activities, it is not production ready and will contain bugs. Feel free to clone, tweak, hack around it.

# Upcoming

- understanding session life cycle and data limits
- proper session teardown and recovery
- better state management

# Contact

Oliver Michalak - [oliver@werk01.de](mailto:oliver@werk01.de) - [@omichde](http://twitter.com/omichde)

## License

This hangman is available under the MIT license
