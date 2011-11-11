/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.demo 
{
	import adobe.utils.ProductManager;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import pl.ifrost.moses.events.RecognizerEvent;
	import pl.ifrost.moses.events.SamplerEvent;
	import pl.ifrost.moses.recognizers.DefaultRecognizer;
	import pl.ifrost.moses.recognizers.Matching;
	import pl.ifrost.moses.recognizers.patterns.MosesPatterns;
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	import pl.ifrost.moses.recognizers.Recognizer;
	import pl.ifrost.moses.samplers.DistanceSampler;
	import pl.ifrost.moses.samplers.Sampler;

	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Moses library showcase. On left side there is a tile representing how move patterns
	 * should look like. On right side there is an area for drawing. Recognized pattern will
	 * be hihglighted
	 * 
	 * @author ifrost
	 */
	public class Main extends Sprite 
	{
		/**
		 * Drawing area
		 */
		private var samplerView:PatternSamplerView;
		
		/**
		 * Tile for pattern views
		 */
		private var tile:ViewTile;
		
		/**
		 * Patterns that will be visualized in tile
		 */
		public static const PATTERNS:Array = [
			MosesPatterns.V,
			MosesPatterns.DASH,
			MosesPatterns.SEVEN,
			MosesPatterns.EXAMPLE,			
			MosesPatterns.SQUARE,
			MosesPatterns.CIRCLE			
		]
				
		public function Main() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			draw(); // draw everything
		}		
		
		/**
		 * Draw tile and sampler view
		 */
		private function draw():void {
			// create and add tile, sampler view and info text
			addTile();
			addSamplerView();
			addInfo();						
			
			// init moses recognition
			initGesturesRecognition();
		}
		
		/**
		 * Initialize gesture recognition by createing sampler
		 * and recognizer and registering patterns
		 */
		private function initGesturesRecognition():void {
			var sampler:Sampler = new DistanceSampler(samplerView); // sample data from sampler view
			
			// register patterns
			var recognizer:Recognizer = new DefaultRecognizer();			
			for each (var pattern:Pattern in PATTERNS) {
				recognizer.register(pattern);
			}
			
			// handle recognition
			recognizer.addEventListener(RecognizerEvent.RECOGNITION_PROCEEDED, recognitionProceeded)
			recognizer.sampler = sampler;
			
			// acitivata sampler to initialize whole process
			sampler.activate();
		}
		
		/**
		 * Create and add tile of pattern views
		 */
		private function addTile():void 
		{
			tile = new ViewTile(3, 2, 200, 300);
			tile.x = 5;
			tile.y = 30;
			
			// create pattern views
			for each (var pattern:Pattern in PATTERNS) {
				tile.addViews(new PatternView(pattern));
			}
			tile.draw();
			addChild(tile);			
			
			// animate all views
			for each (var view:PatternView in tile.views) {
				view.animate();
			}
		}
		
		/**
		 * Add sampler view
		 */
		private function addSamplerView():void 
		{
			samplerView = new PatternSamplerView();
			samplerView.x = 215;
			samplerView.y = 30;
			addChild(samplerView);			
		}
		
		private function addInfo():void {
			var label:TextField = new TextField();
			label.defaultTextFormat = new TextFormat("Verdana", 10, 0x777777);
			label.selectable = false;
			label.autoSize = "left";
			label.text = "Moses library demo (http://github.com/ifrost/moses)";
			
			label.x = width / 2 - label.textWidth / 2
			label.y = 5
			
			addChild(label);
			
		}
		
		/**
		 * Handle recognition. If any pattern has been recognized - highlight
		 * this pattern. If not - show warning on sampler view.
		 * Only one pattern is highlighted (with best matching)
		 * @param	e
		 */
		private function recognitionProceeded(e:RecognizerEvent):void 
		{
			var best:Matching = e.recognitionData.bestMatching;
			
			if (e.recognized) {
				// highlight recogized pattern and ensure that 
				// other pattern are not highlighted
				for each (var view:PatternView in tile.views) {
					view.highlight(view.pattern == best.pattern);
				}				
			}
			else {
				// ensure that highlight is disabled on each patten view
				for each (view in tile.views) {				
					view.highlight(false);
				}			
				samplerView.warn();				
			}			
		}
		
		
		
	}

}