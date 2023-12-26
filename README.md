# Usage
1. Clone/download this repository on your local machine 
2. Install PowerShell on your machine 
3. Navigate to your where you downloaded this repository

   `cd ~/yourpath/yahoobball-setactiveplayers`
4. Get the Powershell POST request for a single SetActivePlayers call

   a. Go to your team page in your league with Google Chrome

    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/69a38579-166a-4216-9f14-02788a5e4113)

   b. Right click on any part of the page and open Inspect Element

   c. Navigate to the Network page

    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/0cd28bdc-5a79-4a75-818b-c4b001a5b425)
   d. Click on Start Active Players

    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/68d31569-518e-4f8b-87b3-619c7ae7bae0)

   e. Click on Start

    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/47934f52-14bf-48ba-869a-f4fed156ebfa)

   f. Find any instance of startactiveplayers in the network tab, right click, and select Copy->Copy as PowerShell.
   
    Make sure *not* to click on "Copy *all* as PowerShell"

    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/e6b2c17a-c2c1-46ae-9c27-8f1dedeabef6)


   g. Create a file in `~/yourpath/yahoobball-setactiveplayers/inputs` with this output

   h. Repeat for as many teams as you would like, one file per team in the inputs directory

   i. Run the startPlayers.ps1 script `./startPlayers.ps1`