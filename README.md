# Repository for the CoRD2 Website

## Referencing JIRA Issues
When working on an issue run `git checkout -b KAN-(your issue number)`, for example if working on `KAN-1` do `git checkout -b KAN-1`.  
In your commit messages you also have to reference the issue by typing `git commit -m "KAN-(your issue number) (your commit message)"`.  
This will allow the git commits to link to the JIRA board.  
Also when making a pull request use the issue in the title "KAN-1 Example". 

## Running the Application
To run the app use a terminal and navigate to the apps directory.  Then run `flutter run -d chrome`.  
This will compile the web app and run it in a chrome browser.  
Flutter doesn't support hot reload for web browsers so everytime you make a change you'll have to re-run the command.