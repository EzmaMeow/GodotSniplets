##this is an abstract class used to call the interaction signal for objects that
##extends this. NOTE: this can be added to Area2D and CharaterBody2D, but limited
##to the properties of a CollisionObject2D (which they all share)
class_name Interaction_Component_2D extends CollisionObject2D

##This will be emitted when interact is triggered
signal interaction(tiggering_node:Node) #Note, use bind to attach addional info

##this is the function called and should be overriden with the desired logic
##unless the owning node is handling it from the interaction signal.
func interact(tiggering_node:Node=null) -> bool:
	interaction.emit(tiggering_node)
	return true
