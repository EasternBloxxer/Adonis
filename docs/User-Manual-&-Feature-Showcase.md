# Contents

1. [Command Usage Guide](#section-1-command-usage-guide)
2. [The "UserPanel" GUI](https://github.com/epix-incorporated/Adonis/wiki/User-Manual-&-Feature-Showcase#section-2-the-userpanel-gui)
3. [UI Themes Showcase](https://github.com/epix-incorporated/Adonis/wiki/User-Manual-&-Feature-Showcase#section-3-ui-themes-showcase)
4. [Moderation Commands Reference](https://github.com/epix-incorporated/Adonis/wiki/User-Manual-&-Feature-Showcase#section-4-moderation-commands-reference)
5. [Adonis Features Showcase](https://github.com/epix-incorporated/Adonis/wiki/User-Manual-&-Feature-Showcase#section-4-adonis-features-showcase)

---

<div align="center">

## ℹ️ **Notice**

**This manual is intended for regular users, moderators and admins in Roblox games using the Adonis admin system. For guidance on installing Adonis in your game as a developer, please refer to the [README](https://github.com/epix-incorporated/Adonis/blob/master/README.md) file in the repository. For API documentation, navigate to the [other pages](https://github.com/epix-incorporated/Adonis/wiki) on this wiki.**

</div>

---

# Section 1: Command Usage Guide

## Execution

These are the following ways by which an Adonis command can be executed by a user:
- by chat (as long as chat commands have not been disabled)
- by command console (default keybind for opening the console is `'`; the console may be restricted or disabled according to settings)
- by other interfaces such as `:cmdbox`

In all cases, the prefix (which is `:` by default for admin commands and `!` by default for player commands) *must* be included at the start of each command for it to work.

ℹ️ **Tip:** To run a command silently in the chat (so that other players do not see it), either prepend it with "/e " (eg. "/e :kill scel") or enable chat command hiding in your [client settings](https://github.com/Sceleratis/Adonis/wiki/User-Manual-&-Feature-Showcase#client-settings).

## Player Selectors

Commands that take players as their argument (eg. `:kill`) will normally support either a singular player or a comma-separated list of player names.

**Example:** `:god scel` or `:kill noob1,noob2`

Note that player names are not case-sensitive and may be partial, eg. `scel` for `Sceleratis`.

In addition to simply using player names, the following special identifiers for targeting certain groups of players exist:
- `me` - yourself (the executor of the command)
- `all` - everyone in the server
- `others` - everyone in the server except yourself
- `admins` - all admins in the server
- `nonadmins` - everyone except admins in the server
- `random` - a random person in the server
- `#NUM` - <NUM> random players in the server
- `@USERNAME` - targets a specific player whose username is exactly <USERNAME>
- `%TEAM` - members of the team <TEAM>
- `$GROUPID` - members of the group with ID <GROUPID> (number found in the Roblox group webpage URL)
- `radius-NUM` - anyone within a <NUM>-stud radius of you

Placing `-` before any selector or player name will *invert* the selection and select everyone except those within the selection defined after `-`.
To illustrate, using the `others` selector is essentially the same as doing `all,-me`.

**Example:** `:explode -radius-10` - explodes all players further than 10 studs from you.

## Batch Commands

Multiple commands can be ran sequentially at a time by separating them using the batch key, which defaults to `|` (vertical pipe).

Additionally, you can insert timed delays using `!wait <duration in seconds>`.

**Example:** `:ff me | :m Exploding everyone in 10 seconds! | !wait 10 | :explode all` - gives you a forcefield and makes a message announcement, waits 10 seconds, then explodes everyone.

## Repetition
Admins/moderators by default have access to the `:repeat <times> <delay>` command, which easily allows a command to be ran in a loop.

**Example:** `:repeat 10 1 :sword me | :heal me` - will give you a sword and heal yourself once every 1 second, for 10 times.

## Reference Commands
- `:cmds` for a list of available commands
- `:cmdinfo <command>` for detailed info about a specific command
- `!brickcolors` for a list of valid BrickColors (can be used in some commands which take a brickcolor argument)
- `!materials` for a list of material types
- `:capes` for a list of preset capes available to admins
- `:musiclist` for a list of preset audios
- `:insertlist` for a list of assets that can be inserted using `:insert <name>` (set by the developer in `settings.InsertList`)

---

[Return to Top](https://github.com/Sceleratis/Adonis/wiki/User-Manual-&-Feature-Showcase#contents)

# Section 2: The "UserPanel" GUI

The UserPanel GUI can be used to quickly access certain things in Adonis, such as commands, as well as configure Adonis client or server settings.
This wiki page will go over the different tabs within Adonis's UserPanel GUI and what they do.

## Info

<img width="400" alt="screenshot" src="https://user-images.githubusercontent.com/81153405/175774689-99df8917-150b-458f-83b8-1d957b9bb030.png">

The info tab shows you information about Adonis, and gives the user convenient buttons to perform actions such as opening the command list, viewing the changelog, viewing credits, getting the loader, or getting the system's source in the form of its MainModule. 

## Donate

<img width="400" alt="screenshot" src="https://user-images.githubusercontent.com/81153405/175774717-3a95fa3c-e29f-4c68-ae1a-86b159ee39fb.png">

This is where users can donate to Adonis's development and control settings related to their donator perks. These perks can be disabled by the place owner in the settings module of the Loader. Donation perks are intended to be purely visual and should not impact gameplay. When users donate in your game, Roblox will give the place owner 10% of the sale.

## Keybinds

![The keybinds tab](https://deveros.net/img/keybindtab1.png)

The keybinds tab allows users to bind command strings to a specific key, so when they press that key the specified command gets executed.

## Aliases

![The alias tab](https://deveros.net/img/aliastab1.png)

Aliases allow you to create custom commands that point to existing commands, or a combination of existing commands. When creating an alias, you can add markers for command arguments. The order the argument identifiers appear in the command string is the order the arguments will be replaced in.

To better understand lets go through what's going on in the above screenshot:
The command string `:kill <arg1> | :fire <arg1> <arg2>` is bound to `:killfire`
The following happens when `:killfire scel Really red` is ran:

1. In the command string, both substrings for `<arg1>` is replaced with `scel` and the substring `<arg2>` is replaced with `Really red`
2. `:killfire scel Really red` is replaced by `:kill scel | :fire scel Really red`.
3. The new command string gets processed like any other command. In this case we are running two commands at once, in other words a "batch" command as indicated by the `|` separating the two commands. The BatchKey setting can be used to change the `|` (vertical pipe) to whatever you'd like as long as it is not the same as the SplitKey or any of the Prefix settings.

It's important to note that the number of arguments is determined by the number of unique argument identifiers. Also, the actual text within the argument identifier is not important and is only used to match user-supplied arguments to where they should be. The order that these unique argument identifiers appear in the command string is what determines which which identifier will match argument 1, the next unique one found being argument 2, and so on. This is important to keep in mind. If you were to change the command string to `:kill <arg2> | :fire <arg2> <arg1>` and then chatted `:killfire scel Really red` `scel` would be assigned to `<arg2>` and `Really red` would be assigned to `<arg1>` so `:killfire Really red scel` would not work (as `:kill scel` would now be `:kill Really red`) It should also be noted that arguments that are intended to take spaces must appear last as otherwise portions of them may be treated as part of previous arguments when using the default SplitKey (a blank space.)

This system is currently still in development and may see improvements in the near future, such as manually defining in the alias string how arguments should be interpreted and matched to the command string. For now, you should not add argument indicators to the alias string. They should only be in the command string, and the order they appear is what currently determines the argument position they will be matched to in the chatted message. 

## Client

<img width="400" alt="screenshot" src="https://user-images.githubusercontent.com/81153405/175774781-bdc2443c-ad92-45ad-99d1-195623bb2024.png">

You've likely noticed that the UserPanel GUI in the screenshots here does not look like the default UserPanel. This is because Adonis supports multiple themes, my personal favorite being the Rounded theme (the one seen in these screenshots.) The default theme is named "Default" and is used for all UI development, and determines the default GUIs and UI modules used in the event the selected theme does not have the GUI being generated.

Users can choose what theme they would like to use by clicking the text next to the arrow pointing down next to the "Theme" listing.

There are also a few other client-specific settings. It should be noted that these settings are user-specific and only affect the user's client. They are not game breaking and only seek to offer finer control over certain things if the user wishes to do so.

### Client Settings

| Setting | Description |
| --- | --- |
| Keybinds | Enables/Disables keybinds (if disabled, keybinds will no longer work until re-enabled) |
| UI Keep Alive | Determines whether or not Adonis should attempt to prevent the deletion of its GUIs when the player respawns. |
| Particle Effects | Adonis contains a number of commands that involve particle effects, which for some users may be irritating or even performance-impacting. All particle effects are local to each client and as such can be toggled using this setting. |
| Capes | Like particle effects, capes (such as donor capes) are handled locally and can be disabled. |
| Hide Chat Commands | Whether Adonis commands that you run via the chat will automatically be hidden from other players. |
| Console Key | This is the key that will open/close the command console (the bar that appears when you press the Quote key by default). |
| Theme | Allows you to select the UI theme you want to use. Changing this to "Game Theme" will use whatever theme is set in the Adonis settings module (in the Loader). This is used by default for all new users. |

## Game

<img width="400" alt="screenshot" src="https://user-images.githubusercontent.com/81153405/175774809-b701f337-d5f6-41e2-99e1-6e2e5ce3ec39.png">

This is where creators can control Adonis related server settings for their game while in-game instead of in studio. "Clear all saved settings" will clear any settings previously written to the datastore. This is especially useful if you encounter issues after changing a setting in-game or quickly want to revert to only what is set within the settings module. Anything with "Cannot change" next to it can only be changed in studio currently.

If you ever change the prefix in-game and suddenly find yourself unable to open settings to fix it, running `:adonissettings` will open the UserPanel GUI and focus the "Game" tab so you can fix any issues. The `:adonissettings` command will *always* use `:` as a prefix so you can't accidentally change it to something unusable.

---

[Return to Top](https://github.com/Sceleratis/Adonis/wiki/User-Manual-&-Feature-Showcase#contents)

# Section 3: UI Themes Showcase

The following are the themes that come with Adonis by default:

## Default

| GUI | Screenshot |
| --- | --- |
| UserPanel | <img width=350 src="https://user-images.githubusercontent.com/81153405/175773465-dcc6d13f-e3a4-44ef-bfe2-ccf487fd210f.png"> |
| HelpButton | <img width="44" src="https://user-images.githubusercontent.com/81153405/175773752-8cc3648d-0f29-4b13-8cc1-805dfd4d5df7.png"> |
| Console | <img width="220" src="https://user-images.githubusercontent.com/81153405/175773663-cbfe3044-dabb-4c63-82f5-6ec1f4516239.png"> |
| Notification | <img width="196" src="https://user-images.githubusercontent.com/81153405/175775723-0ca7ba15-dc61-4264-9004-e3b388348baa.png"> |
| Message | <img width="521" src="https://user-images.githubusercontent.com/81153405/175773703-5ba1195e-e255-4af8-aca1-5c9e07fd29b4.png"> |
| Hint | <img width="525" src="https://user-images.githubusercontent.com/81153405/175773721-4acf607b-eb67-4234-93b4-dbb8c61a1789.png"> |
| Error | <img width="519" src="https://user-images.githubusercontent.com/81153405/175773781-b7c2208d-c8e2-4cfa-898b-0d92b71433df.png"> |

## Rounded

| GUI | Screenshot |
| --- | --- |
| UserPanel | <img width="350" src="https://user-images.githubusercontent.com/81153405/175773919-6ecbe89c-acb6-4280-a139-d54d28a885d1.png"> |
| Console | <img width="238" src="https://user-images.githubusercontent.com/81153405/175773995-b8ccdefa-61d1-4f79-866d-639e7d4d3ec2.png"> |
| Notification | <img width="193" src="https://user-images.githubusercontent.com/81153405/175775603-312460af-29a2-472a-a3b6-c478da438018.png"> |
| Error | <img width="258" src="https://user-images.githubusercontent.com/81153405/175774017-74111fdc-a5d2-49bc-b5da-98008ee9a984.png"> |

## Colorize

Note: rainbow effects are animated with chromatic interpolation.

| GUI | Screenshot |
| --- | --- |
| UserPanel | <img width="350" src="https://user-images.githubusercontent.com/81153405/175774144-7c8d2c0d-3256-44ed-b6a1-42687087a742.png">
| Console | <img width="522" src="https://user-images.githubusercontent.com/81153405/175774386-656a40b8-f81f-4b98-bdca-45cbd45ecf0a.png"> |
| Notification | <img width="195" src="https://user-images.githubusercontent.com/81153405/175775670-bcae0131-b4fc-4fda-8e69-15a52a14c500.png"> |
| Message | <img width="521" src="https://user-images.githubusercontent.com/81153405/175774407-e8d40ce2-5963-4e2a-bee1-75afd72c745b.png"> |
| Hint | <img width="521" src="https://user-images.githubusercontent.com/81153405/175774354-e1d69819-4a20-447b-8f7c-7ab72a9cca54.png"> |
| Error | <img width="523" src="https://user-images.githubusercontent.com/81153405/175774427-0da92a0e-9d18-4f09-81bb-1eafd7017fe9.png"> |

## BasicAdmin

This theme only changes the announcement GUIs.

| GUI | Screenshot |
| --- | --- |
| Message | <img width="525" src="https://user-images.githubusercontent.com/81153405/175774486-aed9054b-1f81-49bb-a2e8-09d4859f41ac.png"> |

## Aero

Made by [@Expertcoderz](https://github.com/Expertcoderz).

| GUI | Screenshot |
| --- | --- |
| UserPanel | <img width="350" src="https://user-images.githubusercontent.com/81153405/175774543-a1a69274-8f68-43f7-908c-08e08f0c6721.png"> |
| HelpButton | <img width="41" src="https://user-images.githubusercontent.com/81153405/175774556-38e53265-d3f6-4147-a508-811aaf7dc914.png"> |
| Console | <img width="518" src="https://user-images.githubusercontent.com/81153405/175774568-fc38f1ee-cb58-46d4-8dd8-84433be01599.png"> |
| Notification | <img width="154" src="https://user-images.githubusercontent.com/81153405/175775557-37640014-d50d-4bec-b247-444477703f8f.png"> |
| Message | <img width="523" src="https://user-images.githubusercontent.com/81153405/175774591-e812123f-acef-41d9-a8fe-5c81a2e187e0.png"> |
| Hint | <img width="521" src="https://user-images.githubusercontent.com/81153405/175774617-a3f05a0d-44fc-4a42-a406-4a44a6afbda8.png"> |
| Error | <img width="520" src="https://user-images.githubusercontent.com/81153405/175774632-4b0d796f-4f81-4e3b-9f67-41cc1cb31f1c.png"> |

## Unity

Made by [@LolloDev5123](https://github.com/LolloDev5123).

| GUI | Screenshot |
| --- | --- |
| UserPanel | <img width="350" src="https://user-images.githubusercontent.com/81153405/175774842-62dc2ab0-fd16-400e-88e6-3be7798e0196.png"> |
| HelpButton | <img width="39" src="https://user-images.githubusercontent.com/81153405/175775010-3a10b195-4510-4867-ba47-5fd3c7eb50ec.png"> |
| Console | <img width="525" src="https://user-images.githubusercontent.com/81153405/175775055-1963106c-ce2e-447c-8d3b-f8b666b005ed.png"> |
| Notification | <img width="190" src="https://user-images.githubusercontent.com/81153405/175775530-2f28f377-0e79-4382-ad39-fb6c9fbd87cb.png"> |
| Message | <img width="525" src="https://user-images.githubusercontent.com/81153405/175775085-c3511d8a-03c3-4a23-a0d8-4144ed20a417.png"> |
| Error | <img width="426" src="https://user-images.githubusercontent.com/81153405/175775153-4a8e5834-f479-4c58-a0e8-baf9205d7270.png"> |

## Windows XP

Made by [@P3tray](https://github.com/P3tray).

| GUI | Screenshot |
| --- | --- |
| UserPanel | <img width="350" src="https://user-images.githubusercontent.com/81153405/175775187-09e19512-18fc-440e-a3b2-9f43c3c3f211.png"> |
| HelpButton | <img width="39" src="https://user-images.githubusercontent.com/81153405/175775216-abec62e7-0470-4c80-aebf-f0dfbcd5db70.png"> |
| Console | <img width="225" src="https://user-images.githubusercontent.com/81153405/175775235-ed9d4bb3-5c4f-4146-a5ae-094fe401daae.png"> |
| Notification | <img width="163" src="https://user-images.githubusercontent.com/81153405/175775484-454d062d-dd6a-4a32-abd7-c4fe031c2e5a.png"> |
| Message | <img width="518" src="https://user-images.githubusercontent.com/81153405/175775274-736e7578-ec6a-4098-bd8d-3ae1fd727014.png"> |
| Hint | <img width="522" src="https://user-images.githubusercontent.com/81153405/175775296-7bbb0486-b365-4ecb-a844-a7a74d4907c4.png"> |
| Error | <img width="260" src="https://user-images.githubusercontent.com/81153405/175775314-50ce08b9-e174-40fe-87af-f83071492488.png"> |

---

[Return to Top](https://github.com/Sceleratis/Adonis/wiki/User-Manual-&-Feature-Showcase#contents)

# Section 4: Moderation Commands Reference

This section serves as a basic reference guide for the essential moderation commands offered by Adonis.

## General

### `:kick <player> <reason>`

Disconnects the specified player from the server. If specified, the reason is shown to the player.

## Warning Players

### `:warnings <player>`

Displays the specified player's warning log.

### `:warn <player> <reason>`

Gives the specified player a warning, upon which they will be notified with the reason.

### `:kickwarn <player> <reason>`

Gives the specified player a warning and kicks them; displays the warning reason in their kick message.

### `:removewarning <player> <reason>`

Deletes the specified warning from the player's warning log.

### `:clearwarnings <player>`

Clears the player's warning log.

## Banning Players

### `:banlist`

Displays a list of normal bans.

### `:timebanlist`

Displays a list of time-banned users.

### `:trellobanlist/:sbl`

Displays a list of users banned via Trello; only applicable if Trello integration is configured.

### `:ban/:serverban <player> <reason>`

Bans the specified player from the current server. Note that they may still be able to join other servers.

### `:permban/:gameban <player> <reason>`

Bans the specified player from *all* game servers, for an indefinite amount of time. Enforced immediately, so if the user is in a server other than where the command is run, they will be kicked by the system.

### `:tempban/:timeban <player> <duration (s/m/h/d)> <reason>`

Bans the specified player from *all* game servers, for a specific amount of time. Enforced immediately.

**Example:** `:tempban Player1 3d` -- globally-bans Player1 for 3 days.

### `:trelloban <player> <reason>`

Adds the specified player to the Trello ban list, if Trello integrations are configured for the game.

ℹ️ **Tip:** The above commands support full usernames for the `<player>` argument, which means you can ban specific users who are not currently in your server.

## Player Notes

### `:notes <player>`

Displays a list of notes on the specified player.

### `:note <player> <note>`

Sets a note on the specified player.

### `:removenote <player> <note>`

Removes a note from a specified player. Specify `all` for `<note>` to clear all notes on that player.

---

[Return to Top](https://github.com/Sceleratis/Adonis/wiki/User-Manual-&-Feature-Showcase#contents)

# Section 5: Adonis Features Showcase

Here's a miscellaneous collection of some interesting features that many users of the Adonis admin system may not be aware of:

## 🚩 `:teams`

This is an interface that allows you to view, create, delete and join teams easily.

<img width=400 src="https://user-images.githubusercontent.com/81153405/175766290-50dee520-0017-4aa3-8177-6719fa5c159c.jpg">

## 🛠️ `:tools` -- Inventory Monitor GUI

This utility allows you to view and manage players' backpacks via a user-friendly realtime inventory monitoring interface. An alternative to manually running the `:viewtools <player>`, `:removetool <player> <tool name>` and `:removetools <player>` commands.

<img width=400 src="https://user-images.githubusercontent.com/81153405/175766295-f281dc9c-be9a-4090-84b6-1bcee43ec47d.jpg">

## 📂 `:explorer`

This is a built-in alternative to `:dex` which allows you to view and navigate the game's file structure as well as delete objects.

<img width=400 src="https://user-images.githubusercontent.com/81153405/175766293-f58e9569-73cd-4aab-8f09-42465ccd7f86.jpg">

## 📃 `:players`

Displays full a list of in-game players along with some live-updated info about the state of their characters; may be useful for moderators if your game has the regular player list GUI hidden.

<img width=400 src="https://user-images.githubusercontent.com/81153405/175766296-2bbc9344-06a9-41be-b25e-ed50957b8400.jpg">

## 🔍 `!profile <player>`

Displays quite comprehensive information about a specific player.

*Some details such as safechat status and the "Game" tab are hidden from non-admins for security reasons.*

<img width=400 src="https://user-images.githubusercontent.com/81153405/175767046-72251caa-3b24-4547-9044-5cbb77d41aef.jpg">

## ℹ️ `!serverinfo`

Displays information about the current server.

*Some details are hidden from non-admins for security reasons.*

<img width=400 src="https://user-images.githubusercontent.com/81153405/175767132-0ad4fbc5-087b-4280-b73e-ade9d9bdf9a0.jpg">

## 🕵️ `:incognito <player>`

A powerful command that allows admins to hide themselves from other players in the server by vanishing from their player lists.

[Return to Top](https://github.com/Sceleratis/Adonis/wiki/User-Manual-&-Feature-Showcase#contents)

---

That's all, folks!

<sub>Notice anything wrong? Submit an issue [here](https://github.com/Sceleratis/Adonis/issues/new/choose) or discuss it in our official [Discord server](https://discord.com/invite/H5RvTP3).</sub>
