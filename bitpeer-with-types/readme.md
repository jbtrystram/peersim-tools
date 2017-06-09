#How to add custom parameters to peersim

#List your keywords

Locate the definition of all the keywords used, it should look like this :
 
private static final String PAR_TRANSPORT="transport";

Now you can replicate this line and use it to your will.

eg : private static final String NO0="nodetype0";

#Parsing the command

Then locate the part where the commands are parsed, it should look like this :

tid = Configuration.getPid(prefix+"."+PAR_TRANSPORT);

Now you can replicate this line and use it to your will : 

nodeType0 = (int)(Configuration.getInt(prefix+"."+NO0));

Note that the parameter is cast as an int for this example.

#Add your command

Now we can add our command to the cfg file, to do so we need to find the right prefix and match it with our controller.

We can see that : init.net.transport, matches with private static final String PAR_TRANSPORT="transport";

So our prefix is init.net.

In the end : init.net.nodetype0 20

Where 20 is the parameter
