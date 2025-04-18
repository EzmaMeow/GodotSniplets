#Action System
This is meant to be a collection of GDscripts to build a simple but expenable action or task system base on the resource type.
The idea is to reduce the need to have every task as a separate node or script. This is to allow one to reused same logic with diffrent parameters as a slot in nodes that provides it.

The general flow is that a Node export a Base_Action. It also needs to handle when to call the action `run()` as well as creating a Action_State for this run function.

The Base_Action would need to be expanded on to do anything of intrest. The `_run()` function is meant to be overriden to add the action logic. 

Note: Actions are not expected to have acess to the scene tree (but if a vaild state with a vaild node is sent, one could acess the tree from the owner).
They are limited to what is provided in their state and any global objects available to them.

Example: A character(node) adds an Action call Interact_Action that is run when ever the character tried to interact with something (or nothing). It will ref itself(or a node it used for its state) as the owner
and the other object as the target. It may set the action state's meta with data related to the interaction depending on if it needed for any action. It will also check the action `run()' return value if it need to know if 
an action was ran without fail.

Lets say an action was created under the class_name of 'Action_Print_Message' that export a string called `message` and `_run()` will call `print(message)` as well as return true. This can be slotted in the character Interact_Action and a message can
be set that will be display in the console. This should cause the message to log when ever the character interacts. 

This allow diffrent characters to have the same triggers, but various responses. This may not seem like much, but could be used if one want a GM to build the game without needed to script everything or if one do not want to have a script for each character or
design various characters that preform similar yet diffrent tasks. 

Personally I was not going to use such a system, but found it to allow comunications between systems to be easier with my flow pattern. I would have tried to use Nodes, but they have their own limitations and headaches.

(I will add to this as I work with it, but a lot of actions will be unique to the projects. There is a high chance other dir will depend on this, but I will mention this in their readme if that the case.)

