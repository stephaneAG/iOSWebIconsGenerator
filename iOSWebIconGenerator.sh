#! /bin/bash

#  nF iOS Web Icons Generator

# R: to quick test:
# rm ./icon-logo--apple-touch-icon-ip*; rm html-logo-icon_link_as_metas.html; rm package-*; rm ./*~; clear;
# ./iOSIconGenerator.sh logo.png

# StephaneAG - 2015


### hlprs ###

## bash ascii color codes hlprs ##

# background colors
# default ( black )
bacc_bckgrnd_def="\e[49m"
# magenta
bacc_bckgrnd_magenta="\e[45m"
# cyan
bacc_bckgrnd_cyan="\e[46m"
# dark grey
bacc_bckgrnd_drkgry="\e[100m"
# text colors
# default ( white )
bacc_txt_def="\e[39m"
# magenta
bacc_txt_magenta="\e[35m"
# cyan
bacc_txt_cyan="\e[36m"
# light blue
bacc_txt_lghtbl="\e[94m"
# dark grey
bacc_txt_drkgry="\e[30m"

## texts ##
txt_filename="filename"
txt_genfor="filename generated"
txt_genas="generated as"

##  html template variables names for sourcing ##
html_appleTouchIconIphone="unset"
html_appleTouchIconIpad="unset"
html_appleTouchIconIphoneRetinaDisplay="unset"
html_appleTouchIconIpadRetinaDisplay="unset"

## html colored output colors ##
html_color_purple="\033[1;35m"
html_color_blue="\033[1;34m"
html_color_lightblue="\033[1;36m"
html_color_drkgry="\033[1;30m"
html_color_def="\033[1;0m"


## script start ##

# get the file name of the file(s) passed as arguments
# get the filename without the extension
# copy file passed as param once, add '-apple-touch-icon-iphone-57x57' + its original extension & resized to 57x57
# copy file passed as param once, add '-apple-touch-icon-ipad-72x72' + its original extension & resized to 72x72
# copy file passed as param once, add '-apple-touch-icon-iphone-retina-114x114' + its original extension & resized to 114x114
# copy file passed as param once, add '-apple-touch-icon-ipad-retina-150x150' + its original extension & resized to 150x150


## global member variables ##
iconshrefdir="" # 'll contain the passed href path directory ( where the icons 'll finally reside in on the server, as locally the'll be in the directory where the script was called from by def )

# constants used for the names of the files
drawable_iphone_suffix="-apple-touch-icon-iphone-57x57"
drawable_ipad_suffix="-apple-touch-icon-ipad-72x72"
drawable_iphone_retina_suffix="-apple-touch-icon-iphone-retina-114x114"
drawable_ipad_retina_suffix="-apple-touch-icon-ipad-retina-150x150"


## intro ##
echo # a littl' spacer
echo -e "$bacc_txt_lghtbl     [$bacc_txt_def iOS Icon Generator v0.0.1 $bacc_txt_lghtbl]$bacc_txt_def"

## handle the case where we are passed no arguments -> in such case, we display a tiny help ;)
if [ $# -eq 0 ]; then
  echo # a littl' spacer
  echo "HERE 'll BE A TINY HELP"
  exit 0
fi




# loop over the files passed as argument
for filename in "$@"
  do
  
    # some space in case we have multiple files ;)
    echo
    echo
    
    # 1: get filename
    #filenameWithoutExtension=$(basename "$filename" '.png') # nb: works
    filenameWithoutExtension="${filename%.*}"
    #echo -e "$txt_filename without extension: $filenameWithoutExtension"
    
    # 2: get extension
    extensionWithoutFilename="${filename##*.}"
    #echo -e "extension without $txt_filename: $extensionWithoutFilename"
    
    # 0/1/2bis: display complete file name
    echo -e "$bacc_txt_lghtbl [$bacc_txt_def $bacc_txt_lghtbl  file:$bacc_txt_def $filename   $bacc_txt_lghtbl]$bacc_txt_def"
    echo
    
    # 3: compose the file names ( later, will be modified & use a directories names )
  
    # apple-touch-icon-iphone-57x57: first drawable name                                               => @Drawable-apple-touch-icon-iphone-57x57
    iphoneIconFilename="icon-$filenameWithoutExtension-$drawable_iphone_suffix.$extensionWithoutFilename"
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_cyan@Info$bacc_txt_def ]$bacc_txt_cyan      $drawable_iphone_suffix $txt_genfor:$bacc_txt_def $iphoneIconFilename"
    
    # apple-touch-icon-ipad-72x72: second drawable name                                                => @Drawable-apple-touch-icon-ipad-72x72
    ipadIconFilename="icon-$filenameWithoutExtension-$drawable_ipad_suffix.$extensionWithoutFilename"
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_cyan@Info$bacc_txt_def ]$bacc_txt_cyan      $drawable_ipad_suffix $txt_genfor:$bacc_txt_def $ipadIconFilename"
    
    # apple-touch-icon-iphone-retina-114x114: third drawable name                                      => @Drawable-apple-touch-icon-iphone-retina-114x114
    iphoneRetinaIconFilename="icon-$filenameWithoutExtension-$drawable_iphone_retina_suffix.$extensionWithoutFilename"
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_cyan@Info$bacc_txt_def ]$bacc_txt_cyan      $drawable_iphone_retina_suffix $txt_genfor:$bacc_txt_def $iphoneRetinaIconFilename"
    
    # apple-touch-icon-ipad-retina-150x150: fourth drawable name                                      => @Drawable-apple-touch-icon-iphone-retina-114x114
    ipadRetinaIconFilename="icon-$filenameWithoutExtension-$drawable_ipad_retina_suffix.$extensionWithoutFilename"
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_cyan@Info$bacc_txt_def ]$bacc_txt_cyan      $drawable_ipad_retina_suffix $txt_genfor:$bacc_txt_def $ipadRetinaIconFilename"
    
    
    # 4: clone & resize

    # iphone: 57x57, whatever the dimensions of the original file
    convert -resize 57x57 $filename $iphoneIconFilename    # create the apple-touch-icon-iphone (57x57) file from the original
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_magenta@Drawable$bacc_txt_def ] $bacc_txt_magenta $drawable_iphone_suffix $txt_genas:$bacc_txt_def $iphoneIconFilename"
    
    # ipad: 72x72, whatever the dimensions of the original file
    convert -resize 72x72 $filename $ipadIconFilename    # create the apple-touch-icon-ipad (72x72) file from the original
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_magenta@Drawable$bacc_txt_def ] $bacc_txt_magenta $drawable_ipad_suffix $txt_genas:$bacc_txt_def $ipadIconFilename"
    
    # iphone retina: 114x114, whatever the dimensions of the original file
    convert -resize 114x114 $filename $iphoneRetinaIconFilename    # create the apple-touch-icon-iphone-retina (114x114) file from the original
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_magenta@Drawable$bacc_txt_def ] $bacc_txt_magenta $drawable_iphone_retina_suffix $txt_genas:$bacc_txt_def $iphoneRetinaIconFilename"
    
    # ipad retina: 150x150, whatever the dimensions of the original file
    convert -resize 150x150 $filename $ipadRetinaIconFilename    # create the apple-touch-icon-ipad-retina (150x150) file from the original
    echo -e " [ $bacc_txt_lghtbl$bacc_txt_magenta@Drawable$bacc_txt_def ] $bacc_txt_magenta $drawable_ipad_retina_suffix $txt_genas:$bacc_txt_def $ipadRetinaIconFilename"
      
    # 5: source html template & capture the it with the filenames rendered in it, & a filename corresponding to the name of the image passed in the first place ;)
    
    # define the content of the html template variables
    html_appleTouchIconIphone="$iphoneIconFilename"
    html_appleTouchIconIpad="$ipadIconFilename"
    html_appleTouchIconIphoneRetinaDisplay="$iphoneRetinaIconFilename"
    html_appleTouchIconIpadRetinaDisplay="$ipadRetinaIconFilename"
    
    # render the html template
    #rendered_html_template=$(. ./template.html)
    # generate a filename for the rendered html template
    rendered_html_filename="html-$filenameWithoutExtension-icon_link_as_metas.html"
    # save the rendered html template
    #cat "$rendered_html_template" > "$rendered_html_filename"
    
    # source directly the rendered template to a file
    . "./template.html" > "$rendered_html_filename"
    
    
    # 6: inform the user that everything went well & that the suffixed images have been generated in the directory the script resides in
    echo
    echo -e "$bacc_txt_lghtbl     [$bacc_txt_def iOS icons successfully generated ! $bacc_txt_lghtbl]$bacc_txt_def"
    echo
    
    # 7: display a colored version of the rendered html template containing the icons meta links in the terminal
    
    # source directly the rendered template to stdout
    . "./colored_template.html"
    
    echo
    echo -e "$bacc_txt_lghtbl     [$bacc_txt_def container html template successfully generated ! $bacc_txt_lghtbl]$bacc_txt_def"
    echo
    
    # 8: create a dedicated directory to hold the generated files ( we could also zip the package ;p )
    mkdir ./"package-$filenameWithoutExtension"
    mv ./icon*.png ./"package-$filenameWithoutExtension"
    mv "$rendered_html_filename" ./"package-$filenameWithoutExtension"
    
    # 9: zip that dir into an actual package ?
    zip -q -r "package-$filenameWithoutExtension.zip" "package-$filenameWithoutExtension"
    
    # 10: if our stuff if zipped, we can do an actual cleanup ;p
    rm -r ./"package-$filenameWithoutExtension"
    
    echo
    echo -e "$bacc_txt_lghtbl     [$bacc_txt_def package-$filenameWithoutExtension.zip successfully generated !  $bacc_txt_lghtbl]$bacc_txt_def"
    echo
    
  done    
