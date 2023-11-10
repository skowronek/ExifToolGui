# ExifToolGui
A GUI for ExifTool

Current version: V6.2.0 updated September 28, 2023. See the changelog for info.<br>
The V6.2.0 release focuses on UTF8. All Exiftool commands can now be executed in UTF8 mode by using an Args File created with UTF8 encoding. This should solve all international character issues!
Also the Log Window is revised. It can now show the last 10 commands, with their output and/or errors.

Important: <br>
To help Bug hunting there are also Map files released. If you place the Map file in the same directory as the Executable
a stacktrace can be copied to the clipboard if an Exception occurs. Please also provide the stacktrace if you report an Exception.

This is an updated version of the ExifToolGui program created by Bogdan Hrastnik. Many thanks go out to him.

This updated source addresses the following issues.

1) Compiles with Delphi Community Edition. Without any 3rd party libraries.
2) Added styles.
3) Image preview is done with WIC. The autorotate should be available for more formats then just JPG
4) The Google Map is replaced by OSM map. The internal browser is now based on Edge, and not on IE.

 To achieve this the source had to be modified quite a lot. Dont expect a flawless product.

 See also the ReadMe files for Developers and Users in the Docs directory.

# Useful links

Obtaining Exiftool.

1) The original version by Phil Harvey. https://exiftool.org/ <br>
   Download the zip file called: Windows Executable: exiftool-xx.yy.zip. <br>
   Unzip the exe and rename it to 'exiftool.exe' in a directory that Windows searches. (Without the quotes) <br>
   Can be the directory where 'ExifToolGui.exe' is located.

2) An installer provided by Oliver Betz. https://oliverbetz.de/pages/Artikel/ExifTool-for-Windows

Obtaining WebWiew2Loader.dll.

https://www.nuget.org/packages/Microsoft.Web.WebView2
See Docs/ReadMe for Users.txt for more info.

Obtaining jhead.exe and jpegtran.exe.

https://exiftool.org/gui/exiftoolgui516.zip
Just take these executables from that version. You can find them in the zip in folder jhead_jpegtran.

Documentation.

 Online documentation is available at https://exiftool.org/gui/
 It is written with V5 in mind, but most of it still applies.


Frank Bijnen
