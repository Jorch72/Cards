-- Filename: CHIPS
-- Author: Luke Perkin
-- Date: 2010-03-16

Chip = class('chip',CanvasObject)
Chip.image = {}
Chip.image.black = love.graphics.newImage('chips/chipblack.png')
Chip.image.blue = love.graphics.newImage('chips/chipblue.png')
Chip.image.green = love.graphics.newImage('chips/chipgreen.png')
Chip.image.pink = love.graphics.newImage('chips/chippink.png')
function Chip.create( send, id, ... )
	local _chip = Chip:new(...)
	
	if id and id > 0 then
		_chip.id = id
		CanvasObject.newid = newCounter(id+1)
	else
		_chip.id = CanvasObject.newid()
	end
	
	if send then
		local data = lube.bin:pack{ mid = 8, id = _chip.id, ... }
		game.netObj:send( data )
	end
	
	return _chip
end
function Chip:initialize(id,x,y,image)
	self.image = Chip.image[image] or Chip.image.black
	super.initialize(self,x,y,1,0,self.image)
	-- Needed to make the sort func work. I'll fix anothertime.
	self.card_id = id
	self.alpha = 255
end
function Chip:draw()
	love.graphics.setColor(255,255,255,self.alpha)
	love.graphics.draw( self.image, self.x, self.y, 0, self.scale)
end
function Chip.states.selected:draw()
	love.graphics.setColor(150,150,150,100)
	love.graphics.draw( self.image, self.x-2, self.y+2, 0, self.scale)
	love.graphics.setColor(255,255,255,self.alpha)
	love.graphics.draw( self.image, self.x, self.y, 0, self.scale)
end