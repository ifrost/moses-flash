/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.events 
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Event dispatched by sampler.
	 * @author ifrost
	 */
	public class SamplerEvent extends Event 
	{
		/**
		 * After activating sampler
		 */
		public static const ACTIVATED:String = "samplingActiveted";
		
		/**
		 * After deactivating sampler
		 */
		public static const DEACTIVATED:String = "samplingDeactivated";
		
		/**
		 * When data collectinghas been started
		 */
		public static const STARTED:String = "samplingStarted";
		
		/**
		 * When new point is collected
		 */
		public static const SAMPLED:String = "sampled";
		
		/**
		 * When sampling is finished and all data has been collected
		 */
		public static const FINISHED:String = "samplingFinished";
		
		/**
		 * When for some reason sampling was aborted (should be dispatched only if sampling has been started)
		 */
		public static const ABORTED:String = "samplingAborted";
		
		public var data:Array;
		
		public function SamplerEvent(type:String, data:Array=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this.data = data;			
		}
		
		public function get lastPoint():Point {
			return data[data.length - 1];
		}
		
	}

}