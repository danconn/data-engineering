# Project Setup Instructions

Terminal to where you want to clone my project solution on your local machine and run the command:
  
    git clone https://github.com/danconn/data-engineering.git
    
From that directory, move down to the data_engineering directoyr and assuming you have rake, rails and bundler 
run these commands:

    bundle install
    sudo rake db:create # you might have to put in a password
    sudo rake db:migrate
    rails server
    
You can visit the app at localhost:3000 and upload the file to the form.

I only created views for the new and index of the FileSubmission model so you can view the database data, etc. from the
project directory with
    
    rails dbconsole

## Note

The gem I am using for the upload, Paperclip, has a dependency on ImageMagick. I do not actually process an image 
obviously, it is somewhat annoying to install ImageMagick and I did not get an error when I uninstalled it so I
tried to just leave it out so the reviewer wouldn't have to deal with it.

If you get an error relating to ImageMagick, on linux you can get it from apt-get:

    sudo apt-get install imagemagick
    
On MacOSX, if you have homebrew you can use:

    brew install imagemagick # maybe with sudo; I don't remember

Then at the terminal, type in the command to find out where your installation is

    which convert
    
to find out where your local install is. Then you need to got into my project and update and uncomment the line

    #Paperclip.options[:command_path] = "/usr/bin/"
    
and replace /usr/bind/ with your value. Hopefully you don't have to deal with this.