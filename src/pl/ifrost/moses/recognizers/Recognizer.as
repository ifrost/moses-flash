/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers 
{
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	import pl.ifrost.moses.samplers.Sampler;
	
	/**
	 * Recognizer is responsible for registering patterns and recognizng them
	 * @author ifrost
	 */
	public interface Recognizer 
	{
		/**
		 * Sets sampler that will be used for getting information about user input
		 */
		function set sampler(value:Sampler):void;
		
		function register(pattern:Pattern):void

		function addEventListener(type:String, handler:Function, useCaputer:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;
	}
	
}