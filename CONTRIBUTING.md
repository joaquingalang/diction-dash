# 🦊 DictionDash 📖
DictionDash is a Flutter mobile application that functions as a language trainer where a user participates in daily minigames to improve their proficiency in certain aspects of the English language such as vocabulary, spelling, grammar, and comprehension.

## Code Format

**Naming Dart Files** - When naming dart files, follow the snake case convention. (e.g `welcome_screen.dart`, `round_button.dart`, `user.dart`, etc.)

**Variables & Functions** - Follow the camel case naming convention. (e.g `currentLevel`, `totalXP`, `getDifficulty()`)

**Constants** - Constants should be defined in the constants.dart file. Constants follow the camel case naming convention but always start with a lowercase *k*. (e.g `kTitleTextStyle`, `kActiveColor`, `kDefaultContainerSize`)

**Classes & Custom Widgets** - Classes and custom widgets follow the camel case naming convention but **all words are capitalized.** (e.g `RoundButton`, `WelcomeScreen`, `SettingsScreen`, `User`, etc.)


### constants.dart
- This file contains defined constant variables that contain widgets such as TextStyle() and Color(). In other screens, we import constants.dart by using `import: 'package:diction_dash/*path_to_constants.dart*'`.
- This way, it is easier to add custom styles/colors to widgets without having to manually insert them. We can just use variables stored in constants.dart.
- For example, I defined a constant called `kActiveColor = Color(0xFF1234)` in constants.dart. Then, later, when I'm working on the Welcome Screen, I can just put kActiveColor when I need to specify the color for the background and certain elements like buttons.


## Directories

**lib/screens**
This directory conatins all of the screens of the application such as:
- Welcome Screen (`welcome_screen.dart`)
- Login Screen (`login_screen.dart`)
- Register Screen (`register_screen.dart`)
- Fluency Screen (`fluency_screen.dart`)
- Home Screen (`home_screen.dart`)
- etc.

*P.S Please follow the correct naming convention*

**lib/widgets**
This directory contains all of the custom widgets that will be used across the application such as custom buttons, list tiles, icons, etc.

**images**
This directory contains images that will be used in the project.

**fonts**
This directory contains all images that will be used in the project

**assets**
This directory contains all sound files that will be used in the project.
