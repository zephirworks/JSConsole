JSConsole, let Javascript speak
==============================================

Overview
--------

A strong use of Javascript inside a iOS application quickly turns into a nightmare for the absence of a simple way to get JS logging.
The only allowed ways out are to fill your application of alerts popping out everywhere or to embed your log in a link.
Both of these methods are not very handy and tell you nothing when an exception is thrown.

JSConsole gives the possibility, during your development phase, both to use a console
object into the javascript for logging and to detect the exceptions thrown by your
code. And it is all done in a very simple way.
Just link JSConsole into your project and the most is done.

Integration
-----------

JSConsole is implemented in order to be easily imported in your project.

As first step you should link JSConsole:

1. Add *JSConsole.xcodeproj* in your project.

2. 
   Open your target info (double click on your target from the Groups & Files view).

   Set Configuration at All Configuration.

   Add in Header Search Paths *PROJECT_JSCONSOLE/build/${BUILD_STYLE}-${PLATFORM_NAME}/Headers*, where *PROJECT_JSCONSOLE* is the path for the JSConsole project.

   Set an additional flag in Other Linker Flags with value *-all_load*.

3. Staying in the target info, go to the General tab.

   Add JSConsole as Direct Dependencies.

4. In Groups & Files view click on *JSConsole.xcodeproj* (added in step 1).

   In the File Name view check the square under the target column for libJSConsole.a or
   just drag and drop libJSConsole.a in "Link Binary with Libraries folder" under your target in the Groups & Files view

Now JSConsole should be successfully linked to your project.

You can get the JS logs in two ways:

1. Use the *TestWebView* instead of *UIWebView*;
   you have to import *"JSConsole/TestWebView.h"*.

2. Use the category for *UIWebView* implemented in JSConsole;
   import *"JSConsole/JSConsoleInitializer.h"* and call `[JSConsoleInitializer start]` before to use the *UIWebView*.

Use
--------

JSConsoleSample is a project with make use of JSConsole and show how to use it.
In particular JSConsoleSample use the category for *UIWebView*.
You can log directly from your javascript calling window.zephirConsole.log() which accept a string as a parameter.
JSConsoleSample shows also as the exceptions are detected and logged in the console or in a popover. Just pay attention that both caught and uncaught exceptions are logged.

Debug & Release
--------

Most of the code is not documented by Apple for use in iOS. You really do not want to use this stuff in the Release version to be submitted.
Keeping this in mind, the Release version of JSConsole do not log anything since most of the code is skipped.