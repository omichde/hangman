# hangman via GroupActivities for iOS 15

As an exciting surprise Apple announced a new framework for iOS 15 to simultaneously join a video stream or custom experiences via a FaceTime call - this game is such a custom experience by playing "hangman" together.

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
- when somebody wants to guess either a character or the full word, tap on the wand and enter your guess
- at the end a small sound is played either for a successful/lost game

# Disclaimer

This is an experiment on top of the current iOS 15 beta - as this project is a test to explore Group Activities, it is not production ready and will contain bugs. Feel free to clone, tweak, hack around it.

# Upcoming

- understanding session life cycle and data limits
- proper session teardown and recovery
- better state management

# Links

- https://developer.apple.com/design/human-interface-guidelines/shareplay/overview/
- https://developer.apple.com/shareplay/

- https://developer.apple.com/videos/play/wwdc2021/10225/
- https://developer.apple.com/videos/play/wwdc2021/10187/
- https://developer.apple.com/videos/play/wwdc2021/10184/
- https://developer.apple.com/videos/play/wwdc2021/10183/

- https://developer.apple.com/documentation/groupactivities
- https://developer.apple.com/documentation/avfoundation/media_playback_and_selection/supporting_coordinated_media_playback

# Contact

Oliver Michalak - [oliver@werk01.de](mailto:oliver@werk01.de) - [@omichde](http://twitter.com/omichde)

## License

This hangman is available under the MIT license
