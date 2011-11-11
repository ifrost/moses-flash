/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.samplers 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import pl.ifrost.moses.events.SamplerEvent;
	import flash.events.MouseEvent;
	
	/**
	 * Simple sampler that samples points if next one is at minimum distance from last one
	 * @author ifrost
	 */
	public class DistanceSampler extends BaseSampler 
	{
		public var distance:Number;		
		
		public function DistanceSampler(displayObject:DisplayObject, distance:Number = 10) 
		{
			super(displayObject);
			this.distance = distance;
		}

		/**
		 * Sample point only if distance is greater than provided in configuration
		 * @param	e
		 */
		override protected function screeningContinue(e:MouseEvent):void 
		{
			var lastPosition:Point = getLastPosition();
			var currentPosition:Point = mousePosition(e);			
			if (lastPosition != null && Point.distance(currentPosition, lastPosition) >= distance) {
				pushMousePosition(e);
				dispatchEvent(new SamplerEvent(SamplerEvent.SAMPLED, _samplingData));
			}
		}
		
	}

}