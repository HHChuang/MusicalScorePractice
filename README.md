# Using LilyPond to write music score

## What is Lilypond?
Open source and a text-based programming language, which is used for music engraving. Just like the LaTex-version in music. (c.f. [Wiki][1])

[1]: https://en.wikipedia.org/wiki/LilyPond

## How to use LilyPond?
### Step 1. Download Lilypond on MacOS-X
>* Go to the [official website][2] to download LilyPond, which is version 2.18.2-1 on July 8, 2018. Then, moves the program to the folder /Application, just like the following screenshot. 

![Fig1][fig1]

>* Open terminal to write the script to call the LilyPond

![Fig2][fig2]

>* Write a testing LilyPond file called original.ly 

![Fig3][fig3]

>* Execute above file 

![Fig4][fig4]

>* Finally, we can get the PDF file

![Fig5][fig5]

[2]: http://lilypond.org/doc/v2.18/Documentation/web/macos-x

[fig1]: ./aux/fig1.png  
[fig2]: ./aux/fig2.png 
[fig3]: ./aux/fig3.png 
[fig4]: ./aux/fig4.png 
[fig5]: ./aux/fig5.png 
[fig6]: ./aux/fig6.png 

### Step 2. Using VScode to write music score

 Follow the tutorial [blog][3], I download the plug-in <br />
   
* [LilyPond syntax highlighting][4]

I didn't follow all the instructions, for downloading the `PDF viewing` and write the configuration of task. First, I use LaTex plug-in which already has the function to open PDF file in VScode. Second, I tried to write the configuration file of task, and use `Cmd+Shift+B` to compile the test LiliPond file. But this workflow is not effective for me, because I can just type 

    : lilypond *.ly

in the terminal block in VScode. Following is the screenshot for demonstration. 

![Fig6][fig6]



[3]: https://blog.anonymous-function.net/2017/10/24/music-ide-lilypond-in-visual-studio-code/

[4]: https://marketplace.visualstudio.com/items?itemName=truefire.lilypond
[fig6]: https://github.com/HHChuang/MusicScore_Mononoke_Hime/blob/master/Fig/Screen%20Shot%202018-07-08%20at%2012.52.14%20PM.png


### Reference 
1. [もののけひめ][ref1]
2. [Music IDE: Lilypond in VScode][ref2]
3. [Official Website of LilyPond][ref3]


[ref1]: http://www.gangqinpu.com/html/19472.htm
[ref2]: https://blog.anonymous-function.net/2017/10/24/music-ide-lilypond-in-visual-studio-code/
[ref3]: http://lilypond.org/doc/v2.18/Documentation/learning/index.html
