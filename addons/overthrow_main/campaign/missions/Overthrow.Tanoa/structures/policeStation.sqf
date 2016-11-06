private _pos = _this select 0;
private _post = (_pos nearObjects ["Land_Cargo_House_V3_F",10]) select 0;
private _town = _pos call nearestTown;

_garrison = server getVariable format['police%1',_town];
if(isNil "_garrison") then {
	//First time
	server setVariable [format['policepos%1',_town],_pos,true];
	_mrkid = format["%1-police",_town];
	createMarker [_mrkid,_pos];
	_mrkid setMarkerShape "ICON";
	_mrkid setMarkerType "o_installation";
	_mrkid setMarkerColor "ColorGUER";
	_mrkid setMarkerAlpha 1;
	_builder = name player;
	{
		[_x,format["New Police Station: %1",_town],format["%1 built a new police station %2",_builder,_pos call BIS_fnc_locationDescription]] call BIS_fnc_createLogRecord;
	}foreach(allplayers);
						
	server setVariable [format['police%1',_town],2,true];
	
	_spawned = _town call (compileFinal preProcessFileLineNumbers "spawners\police.sqf");
	_despawn = spawner getVariable [format["despawn%1",_town],[]];
	[_despawn,_spawned] call BIS_fnc_arrayPushStack;
	spawner setVariable [format["despawn%1",_town],_despawn,false];
};


