EXEC sp_rename 'ShowRoom.OfertaShowRoom'
	,'ShowRoom.OfertaShowRoom_obsolete';GO;

EXEC sp_rename 'ShowRoom.OfertaShowRoomDetalle'
	,'ShowRoom.OfertaShowRoomDetalle_obsolete';GO;
