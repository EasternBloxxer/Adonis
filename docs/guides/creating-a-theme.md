# Getting started
In order to create a theme, you must have the Adonis Loader inside your game. You will also need to have access to the Adonis MainModule, but you do not need to keep this.

# Part 1
## Copying the theme
Go to the temporary Adonis MainModule copy and go to `MainModule > Client > UI`. This will allow you to see all the UI themes that Adonis uses. Select whichever one it is that you would like to base your new theme on! In our example, we will use Unity.
![image](https://github.com/Epix-Incorporated/Adonis/assets/64012878/493a2b83-5769-444b-90a4-6fc0832828fa)
## Transferring the theme
Copy the theme you wish to base your new theme on and paste it in your loader at: `Adonis_Loader > Config > Themes`. You can now delete MainModule if you wish.
![image](https://github.com/Epix-Incorporated/Adonis/assets/64012878/84fc9794-cf55-4a06-952d-9e79bead63bb)


***

# Part 2
## Setting up your new theme
1. Now you've successfully copied your theme over to your loader, you can start setting it up. Rename the theme to whatever it is you wish for it to be called. In this guide we will call it `ExampleTheme`.
2. Now check that your theme has a StringValue inside called `Base_Theme`. If it doesn't, create it! This is the theme that Adonis will use if it cannot find a specific GUI. In our example we will set this to Aero.
3. You've successfully installed the new theme! You can now select it in the menu. However, at the moment it is the exact same as another theme.
## Creating your new theme
* Now it's time to customise your new theme. You can delete any GUIs you don't want to customise, and Adonis will automatically use the Base_Theme for these cases.
* In this example, we will turn the colour of the UI into red and change the font to Source Sans Pro. 
* * To do this, we will go to `ExampleTheme > Window > Drag` and change the FontFace from Ubuntu to Source Sans Pro. Then we will go into Drag and change the background frame to Red.
* You can edit the UI further. If you wish to see the changes you are making, drag the ScreenGui into StarterGui. Just remember to put it back into the theme folder when you're done editing!
* Additionally, you can also edit the UI code to include new features or change existing ones, such as click sounds.
* * Note that some UIs do not have ScreenGuis by default (such as Notifications/Hints)- this is intentional and you will have to add a ScreenGui to see these in StarterGui.

***

Congratulations! Just publish the game and you've successfully made an Adonis theme. If you have any queries, or would like to see a different guide, just ask in our communications server.