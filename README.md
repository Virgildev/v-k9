# Police K9 Script for FiveM

This is a custom script for FiveM, designed to integrate K9 functionality for police jobs using QBOX/QBCore framework. The script allows police dogs to activate a K9 mode, command the K9 to perform various actions such as searching players, searching vehicles, using real world sounds/emotes and many more! It also features sound effects and emotes that can be triggered by the K9, adding **IMMENSE** ROLEPLAY capabilities.

## Features

- **K9 Mode Activation**: Police officers can activate the K9 mode with a simple command.
- **K9 Menu**: Access a menu with various options for K9-related actions, such as:
  - **Enter/Exit Vehicle**: Command the K9 to enter or exit a vehicle.
  - **Search Player**: Order the K9 to search a player for contraband.
  - **Search Vehicle**: Command the K9 to search a nearby vehicle.
  - **K9 Sounds**: Play different sound effects based on the K9's breed (small or large).
- **K9 Emotes**: Trigger emotes for small and large dogs during actions such as searching or barking.
- **K9 Sound Effects**: Play sound effects associated with the K9's actions.
- **Supports Multiple Dog Breeds**: The script supports both small and large dog breeds, with different sounds and emotes for each.

## Requirements

- **QBOX/QBCore**
- **ox_lib**
- **rpemotes-reborn**
- **InteractSound**

## Installation

1. Download the script and place it in your server's resources folder.
2. Ensure that all depencies are installed and ensured.
3. Drop the sounds from ``v-k9/sounds`` into ``interact-sound\client\html\sounds``
4. Add the following to your `server.cfg` to start the resource:

   ```plaintext
   ensure v-k9
   ```

5. Customize the `Config.lua` file to add or modify the list of small and large dog breeds and their corresponding sound effects.

## Commands

- **/k9menu**: Opens the K9 menu, allowing the officer to issue commands to the K9.
- **/k9activate**: Activates K9 mode. Officers can only activate this if they are not in a vehicle.

## Support

For any issues or suggestions, please feel free to open an issue on this repository or contact me via discord: *Virgil7399*.