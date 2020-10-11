local Piece = require 'tetris.components.piece'
local Ruleset = require 'tetris.rulesets.ruleset'

local DTET = Ruleset:extend()

DTET.name = "DTET Rotation System"
DTET.hash = "DTET"

DTET.spawn_positions = {
	I = { x=5, y=3 },
	J = { x=4, y=4 },
	L = { x=4, y=4 },
	O = { x=5, y=4 },
	S = { x=4, y=4 },
	T = { x=4, y=4 },
	Z = { x=4, y=4 },
}

DTET.big_spawn_positions = {
	I = { x=2, y=1 },
	J = { x=2, y=2 },
	L = { x=2, y=2 },
	O = { x=2, y=2 },
	S = { x=2, y=2 },
	T = { x=2, y=2 },
	Z = { x=2, y=2 },
}

DTET.block_offsets = {
	I={
		{ {x=0, y=1}, {x=-1, y=1}, {x=-2, y=1}, {x=1, y=1} },
        { {x=-1, y=0}, {x=-1, y=-1}, {x=-1, y=1}, {x=-1, y=2} },
		{ {x=0, y=1}, {x=-1, y=1}, {x=-2, y=1}, {x=1, y=1} },
        { {x=0, y=0}, {x=0, y=-1}, {x=0, y=1}, {x=0, y=2} },
	},
	J={
        { {x=0, y=-1}, {x=-1, y=-1}, {x=1, y=-1}, {x=1, y=0} },
		{ {x=0, y=-1}, {x=0, y=-2}, {x=0, y=0}, {x=-1, y=0} },
        { {x=0, y=0}, {x=-1, y=0}, {x=1, y=0}, {x=-1, y=-1} },
		{ {x=0, y=-1}, {x=1, y=-2}, {x=0, y=-2}, {x=0, y=0} },
	},
	L={
        { {x=0, y=-1}, {x=-1, y=-1}, {x=1, y=-1}, {x=-1, y=0} },
		{ {x=0, y=-1}, {x=-1, y=-2}, {x=0, y=-2}, {x=0, y=0} },
        { {x=0, y=0}, {x=-1, y=0}, {x=1, y=0}, {x=1, y=-1} },
	    { {x=0, y=-2}, {x=0, y=-1}, {x=1, y=0}, {x=0, y=0} },
	},
	O={
		{ {x=0, y=0}, {x=-1, y=0}, {x=-1, y=-1}, {x=0, y=-1} },
		{ {x=0, y=0}, {x=-1, y=0}, {x=-1, y=-1}, {x=0, y=-1} },
		{ {x=0, y=0}, {x=-1, y=0}, {x=-1, y=-1}, {x=0, y=-1} },
		{ {x=0, y=0}, {x=-1, y=0}, {x=-1, y=-1}, {x=0, y=-1} },
	},
	S={
		{ {x=1, y=0}, {x=0, y=0}, {x=0, y=1}, {x=-1, y=1} },
		{ {x=-1, y=-1}, {x=-1, y=0}, {x=0, y=0}, {x=0, y=1} },
		{ {x=-1, y=1}, {x=0, y=1}, {x=0, y=0}, {x=1, y=0} },
		{ {x=1, y=1}, {x=1, y=0}, {x=0, y=0}, {x=0, y=-1} },
	},
	T={
		{ {x=0, y=-1}, {x=-1, y=-1}, {x=1, y=-1}, {x=0, y=0} },
		{ {x=0, y=-1}, {x=0, y=0}, {x=1, y=-1}, {x=0, y=-2} },
        { {x=0, y=0}, {x=-1, y=0}, {x=1, y=0}, {x=0, y=-1} },
		{ {x=0, y=-1}, {x=0, y=0}, {x=-1, y=-1}, {x=0, y=-2} },
	},
	Z={
		{ {x=1, y=1}, {x=0, y=1}, {x=0, y=0}, {x=-1, y=0} },
		{ {x=-1, y=1}, {x=-1, y=0}, {x=0, y=0}, {x=0, y=-1} },
		{ {x=1, y=1}, {x=0, y=1}, {x=0, y=0}, {x=-1, y=0} },
		{ {x=1, y=-1}, {x=1, y=0}, {x=0, y=0}, {x=0, y=1} },
	}
}

-- clockwise kicks: {{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
-- counterclockwise kicks: {{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},

DTET.wallkicks_3x3 = {
	[0]={
		[1]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[2]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[3]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
	[1]={
		[0]={{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},
		[2]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[3]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
	[2]={
		[0]={{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},
		[1]={{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},
		[3]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
	[3]={
		[0]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[1]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[2]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
};

DTET.wallkicks_line = {
	[0]={
		[1]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[2]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[3]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
	[1]={
		[0]={{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},
		[2]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[3]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
	[2]={
		[0]={{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},
		[1]={{x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=1, y=1}, {x=-1, y=1}},
		[3]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
	[3]={
		[0]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[1]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
		[2]={{x=-1, y=0}, {x=1, y=0}, {x=0, y=1}, {x=-1, y=1}, {x=1, y=1}},
	},
};

function DTET:attemptWallkicks(piece, new_piece, rot_dir, grid)

	local kicks
	if piece.shape == "O" then
		return
	elseif piece.shape == "I" then
		kicks = DTET.wallkicks_line[piece.rotation][new_piece.rotation]
	else
		kicks = DTET.wallkicks_3x3[piece.rotation][new_piece.rotation]
	end

	assert(piece.rotation ~= new_piece.rotation)

	for idx, offset in pairs(kicks) do
		kicked_piece = new_piece:withOffset(offset)
		if grid:canPlacePiece(kicked_piece) then
			piece:setRelativeRotation(rot_dir)
			piece:setOffset(offset)
			self:onPieceRotate(piece, grid)
			return
		end
	end
end
function DTET:onPieceDrop(piece, grid)
	piece.lock_delay = 0 -- step reset
end

function DTET:get180RotationValue() return config["reverse_rotate"] and 1 or 3 end
function DTET:getDefaultOrientation() return 1 end

return DTET