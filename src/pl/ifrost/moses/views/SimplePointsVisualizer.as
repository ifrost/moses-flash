/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.views 
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * Visualizer that show how pattern looks like
	 * @author ifrost
	 */
	public class SimplePointsVisualizer 
	{		
		/**
		 * Markers sprites
		 */
		protected var _markers:Array;
		
		/**
		 * Number of markers to create
		 */
		protected var _nofMarkers:int;
		
		/**
		 * Points to visualize
		 */
		protected var _points:Array;
		
		/**
		 * Timer for counting time gaps between releasing markers
		 */
		protected var _timer:Timer;
		
		/**
		 * Delay between releasing markers
		 */
		protected var _releaseDelay:int;
		
		/**
		 * Animation will be played on this object
		 */
		protected var _displayObject:DisplayObjectContainer;
		
		/**
		 * Delay between animation steps
		 */
		protected var _stepDelay:int;
		
		/**
		 * Color of animated marker
		 */
		protected var _markerColor:uint;
		
		/**
		 * Radius size of a marker
		 */
		protected var _markerRadius:int;
		
		/**
		 * Draw path from points
		 */
		protected var _showPath:Boolean;
		
		/**
		 * Path color if showPath is true
		 */
		protected var _pathColor:uint;
		
		/**
		 * Path alpha is showPath is true
		 */
		protected var _pathAlpha:Number;
		
		/**
		 * Path thickness is showPath is true
		 */
		protected var _pathThickness:int;
		
		/**
		 * Size of animation
		 */
		protected var _width:Number;
		protected var _height:Number;
		
		/**
		 * Offset for animation drawed on display object
		 */
		protected var _offsetX:Number;
		protected var _offsetY:Number;
		
		public function SimplePointsVisualizer(displayObject:DisplayObjectContainer) {
			_displayObject = displayObject;		
			setDefaults();
		}
		
		protected function setDefaults():void {
			_releaseDelay = 50;
			_stepDelay = 50;
			_nofMarkers = 5;
			_width = 100;
			_height = 100;
			_offsetX = 0;
			_offsetY = 0;
			_markerColor = 0x000000;
			_markerRadius = 5;
			_showPath = false;
			_pathColor = 0x000000;
			_pathThickness = 1;
			_pathAlpha = 1;
		}
		
		/**
		 * Fluent interface for configuring view
		 */
		
		public function setReleaseDelay(value:Number):SimplePointsVisualizer {
			_releaseDelay = value;
			return this;
		}
		
		public function setStepDelay(value:Number):SimplePointsVisualizer {
			_stepDelay = value;
			return this;
		}
		
		public function setNofMarkers(value:Number):SimplePointsVisualizer {
			_nofMarkers = value;
			return this;
		}
		
		public function setWidth(value:Number):SimplePointsVisualizer {
			_width = value;
			return this;
		}

		public function setHeight(value:Number):SimplePointsVisualizer {
			_height = value;
			return this;
		}

		public function setOffsetX(value:Number):SimplePointsVisualizer {
			_offsetX = value;
			return this;
		}
		
		public function setOffsetY(value:Number):SimplePointsVisualizer {
			_offsetY = value;
			return this;
		}		
		
		public function setMarkerColor(value:uint):SimplePointsVisualizer {
			_markerColor = value;
			return this;
		}
		
		public function setMarkerRadius(value:Number):SimplePointsVisualizer {
			_markerRadius = value;
			return this;
		}		
		
		public function setShowPath(value:Boolean):SimplePointsVisualizer {
			_showPath = value;
			return this;
		}
			
		public function setPathColor(value:uint):SimplePointsVisualizer {
			_pathColor = value;
			return this;
		}
		
		public function setPathThickness(value:int):SimplePointsVisualizer {
			_pathThickness = value;
			return this;
		}
			
		public function fitPoints(points:Array):Array {
			points = points.slice(); // make a copy
			
			// find min and max from points (cover area)
			var maxX:Number = Number.NEGATIVE_INFINITY;
			var maxY:Number = Number.NEGATIVE_INFINITY;
			var minX:Number = Number.POSITIVE_INFINITY;
			var minY:Number = Number.POSITIVE_INFINITY;
			
			for each (var p:Point in points) {
				if (p.x < minX) minX = p.x;
				if (p.x > maxX) maxX = p.x;
				if (p.y < minY) minY = p.y;
				if (p.y > maxY) maxY = p.y;
			}		

			// offset points
			var shiftX:Number = -minX;
			for (var i:int = 0; i < points.length; i++) {
				points[i].x += shiftX;
			}
			minX += shiftX;
			maxX += shiftX;
			
			var shiftY:Number = -minY;
			for (i = 0; i < points.length; i++) {
				points[i].y += shiftY;
			}
			minY += shiftY;
			maxY += shiftY;
			
			// fit to size by rescaling
			var rescaleX:Number = 1;
			if ((maxX - minX) > _width) {
				rescaleX = _width / (maxX - minX);
			}
			for (i = 0; i < points.length; i++) {
				points[i].x *= rescaleX;
				points[i].x += _offsetX;
			}
			
			var rescaleY:Number = 1;
			if ((maxY - minY) > _height) {
				rescaleY = _height / (maxY - minY);
			}
			for (i = 0; i < points.length; i++) {
				points[i].y *= rescaleY;
				points[i].y += _offsetY;
			}
			
			return points;
		}
		
		/**
		 * Relase new marker
		 * @param	event
		 */
		protected function releaseMarker(event:TimerEvent):void {
			var marker:Sprite = _markers[_timer.currentCount - 1];
			marker.visible = true;
			marker.x = _points[0].x;
			marker.y = _points[0].y;
			moveMarker(marker, 0);
		}
		
		private function moveMarker(marker:DisplayObject, nextPointIndex:int):void 
		{
			var index:int = nextPointIndex % _points.length;
			TweenLite.to(marker, _stepDelay / 1000,  { x:_points[index].x, y:_points[index].y, onComplete:moveMarker, onCompleteParams:[marker, nextPointIndex + 1] } );
		}
		
		protected function createMarkers():void {
			// clear current markers
			_markers = [];			
			
			// create markers
			for (var i:int = 0; i < _nofMarkers; i++) {
				// sprite for marker
				var s:Sprite = new Sprite();
				s.graphics.beginFill(_markerColor);
				s.graphics.drawCircle(0, 0, _markerRadius * ((_nofMarkers - i + _nofMarkers / 5) / _nofMarkers));
				s.graphics.endFill();
				// each next marker has little lower alpha
				s.alpha = (_nofMarkers - i + _nofMarkers / 10) / _nofMarkers;
				
				// dont show markers before animations start
				s.visible = false;
				_displayObject.addChild(s);
				
				_markers.push(s);
			}
		}
		
		public function drawPath():void {
			var pathSprite:Sprite = new Sprite();
			_displayObject.addChild(pathSprite);

			pathSprite.graphics.drawRect(0, 0, _displayObject.width, _displayObject.height);
			pathSprite.graphics.lineStyle(_pathThickness, _pathColor, _pathAlpha);
			pathSprite.graphics.moveTo(_points[0].x, _points[0].y);
			for each (var point:Point in _points) {
				pathSprite.graphics.lineTo(point.x, point.y);
			}
		}
		
		/**
		 * Create and animate markers
		 * @param	points
		 */
		public function play(points:Array):void {
			_timer = new Timer(_releaseDelay, _nofMarkers);
			_timer.addEventListener(TimerEvent.TIMER, releaseMarker);
			
			// fit point to size and offsets
			_points = fitPoints(points);
			
			if (_showPath) {
				drawPath();
			}
			
			createMarkers();
			
			// play animation
			_timer.start();
		}
		
	}

}