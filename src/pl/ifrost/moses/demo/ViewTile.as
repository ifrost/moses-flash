/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.demo 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * Simple tile for presenting multiple views
	 * @author ifrost
	 */
	public class ViewTile extends Sprite 
	{
		private var _views:Array;
		private var _rows:int;
		private var _columns:int;
		private var _width:Number;
		private var _height:Number;
		private var _verticalGap:Number;
		private var _horizontalGap:Number;
		
		public function ViewTile(rows:int, columns:int, width:Number, height:Number) 
		{			
			super();			
			this._rows = rows;
			this._columns = columns;			
			this._width = width
			this._height = height;
			this._views = [];
			
			// calculate gaps between views
			calculateGaps();
		}
		
		/**
		 * Add one or more view
		 * @param	...views array of DisplayObjects
		 */
		public function addViews(...views):void {
			_views = _views.concat(views);
		}
		
		public function draw():void {			
			var currentRow:int = 0;
			var currentColumn:int = 0;
			for each (var view:DisplayObject in _views) {
				// set position of view
				view.x = currentColumn * _horizontalGap;
				view.y = currentRow * _verticalGap;
				
				// add view to tile
				addChild(view);
				
				// calculate next position
				currentColumn++;
				if (currentColumn >= _columns) {
					currentColumn = 0;
					currentRow++;
					if (currentRow >= _rows) {
						break; // if no more views fit to tile - finish
					}
				}
			}
		}
		
		/**
		 * Calculate gaps between views. It just make a simple offset and do not
		 * make any aligning
		 */
		private function calculateGaps():void {
			_verticalGap = this._height / this._rows;
			_horizontalGap = this._width / this._columns;
		}
		
		public function getViewAt(index:int):DisplayObject {
			return _views[index];
		}
		
		public function get views():Array 
		{
			return _views;
		}
		
	}

}