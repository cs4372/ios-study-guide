## How to create an iOS project without storyboards

1. Command shift F and search main
2. Search `main` on the right hand side and you should see `UIKit Main Storyboard File Base Name`
3. Select that and hit delete. It should remove the plist reference file
4. Go back to the result and select Info.plist Main. Select `Application Scene Manifest` and hit delete
5. Go to AppDelegate.swift and delete the code

Tip: Create a code snippet for no storyboards for AppDelegate