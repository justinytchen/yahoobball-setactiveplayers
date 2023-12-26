# Usage
1. Clone/download this repository on your local machine 
2. Install PowerShell on your machine 
3. Navigate to your where you downloaded this repository

   `cd ~/yourpath/yahoobball-setactiveplayers`
4. Get the Powershell POST request for a single SetActivePlayers call

   a. Go to your team page in your league with Google Chrome

   b. Right click on any part of the page and open Inspect Element

   c. Navigate to the Network page
    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/091ff6cd-8bd0-470f-88de-2411c0a0cc04)
   d. Click on Start Active Players
    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/68d31569-518e-4f8b-87b3-619c7ae7bae0)

   e. Click on Start
    ![alt text](https://github.com/justinytchen/yahoobball-setactiveplayers/assets/6785106/61aee73e-c74d-451c-9e3f-a2bcb6c9b754)
    
   f. Find any instance of startactiveplayerse in the network tab, right click, and select Copy->Copy as PowerShell

   g. Create a file in `~/yourpath/yahoobball-setactiveplayers/inputs` with this output

   h. Repeat for as many teams as you would like, one file per team in the inputs directory