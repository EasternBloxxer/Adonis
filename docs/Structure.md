# File Structure
The internal file structure of both Adonis's client and server can be broken down into four main parts:

## Core
This folder contains modules essential to the script's functionality. When Adonis starts, all modules within the core folder are loaded in a specific order. These modules must be loaded, in order, before the script can start doing anything. 

### Server Load Order:
1. Service
2. Logs
3. Variables
4. Core
5. Remote
6. Functions
7. Process
8. Admin
9. HTTP
10. Anti
11. Commands

### Client Load Order:
1. Service 
2. Variables
3. UI
4. Core
5. Remote
6. Functions
7. Process
8. Anti

## Dependencies
All dependencies of the client or server are contained within the respective "Dependencies" folder. This can include pre-made scripts and UI elements.

## Plugins
The "Plugins" folders specific non-essential modules to be loaded. The server will automatically populate the client's Plugins folder if user defined client plugins are present in Loader > Config > Plugins

## Main Scripts
### Server
Handles the server-side loading process.
### Client
Handles the client-side loading process.


# Code Structure
Adonis has three main tables that nearly all variables, functions, settings, objects, and folders, can be accessed from. 

## "server" & "client"
The "server" and "client" variables are tables containing everything related to Adonis's functionality. This includes any tables, functions, and variables added by loaded modules.

## service
The "service" metatable is a variable unique to Adonis and it's modules that provides many functions and services used throughout both the client and server. Within the service metatable are functions to handle anything from task creation and tracking to object deletion. If the index requested is not found within the service table, it will return a game service matching the index if it can. (Specifically, it just returns ``game:GetService(index)``.)