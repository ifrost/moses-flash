/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.samplers 
{
	
	/**
	 * Describes object which is responsible for collecting sampling data
	 * @author ifrost
	 */
	public interface Sampler 
	{
		function activate():void;
		function deactivate():void;
		function addEventListener(type:String, handler:Function, useCaputer:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;		
	}
	
}