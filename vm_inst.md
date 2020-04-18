One option for running R and RStudio is to use a "Virtual Machine" VM, hosted by UO IT and CASIT.  A virtual machine runs a server, and is accessed (in this case) through a web browser.  The VMs that have been "provisioned" for us run R and RStudio only a little more slowly than a "local" machine, and could provide a workaround if your access to a newish computer is limited.  The instructions here cover the initial setup that needs to be done in order to insure that your workspace and data are saved between sessions.

**Setting up the virtual machine**

*Logon/start the VM*

To start:

- Open Firefox, and click on this URL:  [https://view.uoregon.edu/](https://view.uoregon.edu/)
- Login using your UO userid (the part of your email address in front of the @ sign) and password;
- Click (or double-click) on the `UO Virtual Computer Lab` icon;
- respond `Yes` to the cut-and-paste option.

A standard Windows 10 boot-up screen should appear.  It takes a little while for the virtual machine to start up.  Give everything a little more time after clicking on something than you would expect on a laptop or lab machine.

*Start RStudio*

To start RStudio,

- click on the Windows Start button, and
- type "RStudio" (without the quotes); then
- click on the `RStudio Desktop app` bar

RStudio will start in a few seconds (wait).  Then (**this is important**), in the `Console` window of RStudio, type the following, replacing "userid" with your login/user id:
	 
	 setwd("R:/geog495_1/Student_Data/userid/") 
	 .libPaths("R:/geog495_1/Class_Data/win-library/3.6")

Note the forward slashes in the paths (the backward slash in R is an escape character), and make sure the cases (upper or lower) of the characters are strictly followed.  The first command sets the "working directroy" (where R saves data and plots) to the `Class_Data` folder, while the second indicates where downloaded packages should be installed.  (The default locations for these are volitile, and disappear when logging off.)

The `Files` pane (usually in the lower right of RStudio) can be pointed at the working directory by clicking on the `More` dropdown, and clicking on `Go To Working Directory`

**Test the VM**

*Create some data and a plot*

Create a simple data set and a plot.  First, create an R script, 

- click on `File`, then `New File` and `R Script`

A new file named `Untitled` will be created.  Save that file by clicking on the disk icon, or by 

- clicking on `File`, then `Save As` and
- enter `test01` in the `File name:` area of the `Save File` dialog box.

As the file is saved, it will automatically be given the extension `.R`.

Next, copy or type the following into the `test01.R` script window.

	x <- rnorm(1000)
	plot(x)

Save the file again.

Now run the script by selecting the code, and clicking on the `Run` button (to run both lines at once) or by placing the cursor in the first line and clicking `Run`, and then clicking `Run` again as the cursor moves to the second line.

Save the plot as a .pdf

- click on `Export` and then `Save as PDF...`;
- in the `Save Plot as PDF` dialog box, the `Directory` should be `R:/geog495_1/Student_Data/userid`, where "userid" is again your userid.  if the path is not correct, the `Directory` button can be used to browse to it; 
- click `Save`

*Close RStudio*

To quit RStudio, 

- click on `File`, `Quit R Session`.

A `Quit R Session` dialog box will pop up, asking if you wish to save the `Worspace image (.RData)`, and the script file `test01.R`. 

- click on the `Save Selected`.

*Log off the virtual machine*

To log off the virtual machine, use the gray tab at the left of the browser window, and click on the menu button of the `Running` virtual machine, and click on `Logoff`.  Close the brower to completely disconnect.

*Log in, run RStudio, and check that the data have been saved*

Start the virtual machine again, and RStudio as above.  Copy and paste or type the following where as usual, userid is replace by your userid.

	 setwd("R:/geog495_1/Student_Data/userid/") 
	 .libPaths("R:/geog495_1/Class_Data/win-library/3.6")

Use `Files` and `More` to set the view of the `Files` pane to the working directory, and you should see the plot file, `.Rdata` workspace, and the script file, and the variable `x` should appear in the `Environment` tab.  

**An alternative way to start RStudio**

Once you have files in your "R" folder (`R:/geog495_1/Student_Data/userid/`) you can start RStudio simply by clicking on a script file (`*.R`) or the R workspace file (`.RData`).  A useful thing to do would be to create a script called, e.g. `startup.R`, and copy into it the setup code:

	 setwd("R:/geog495_1/Student_Data/userid/") 
	 .libPaths("R:/geog495_1/Class_Data/win-library/3.6")

(replacing `userid` with your user id).  Once that file is created and saved, simply clicking on it will start RStudio, and open that script file.  Then the first thing to do is to select the two lines, and run the script.  (Note that simply opening the script in RStudio doesn't execute the lines.)

