package com.grandroot.tmx
{

	public class TMXObject
	{
		private var _custom:TMXPropertySet;
		private var _gid:int;
		private var _group:TMXObjectGroup;
		private var _height:int;
		private var _name:String;
		private var _shared:TMXPropertySet;
		private var _type:String;
		private var _width:int;
		private var _x:int;
		private var _y:int;

		public function TMXObject(source:XML, parent:TMXObjectGroup)
		{
			_group = parent;
			_name = source.@name ? source.@name : "";
			_type = source.@type ? source.@type : "unknown";
			_x = source.@x ? source.@x : 0;
			_y = source.@y ? source.@y : 0;
			_width = source.@width ? source.@width : 0;
			_height = source.@height ? source.@height : 0;
			_shared = null;
			_gid = -1;

			if (source.@gid.length != 0)
			{
				_gid = source.@gid;
				for each (var tileSet:TMXTileset in _group.map.tilesets)
				{
					_shared = tileSet.getPropertiesByGid(_gid);
					if (_shared)
						break;
				}
			}

			var node:XML;
			for each (node in source.properties)
			{
				_custom = _custom ? _custom.extend(node) : new TMXPropertySet(node);
			}
		}
	}
}