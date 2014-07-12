/***********************
 * Adobe Edge Animate Composition Actions
 *
 * Edit this file with caution, being careful to preserve
 * function signatures and comments starting with 'Edge' to maintain the
 * ability to interact with these actions from within Adobe Edge Animate
 *
 ***********************/
(function($, Edge, compId){
  var Composition = Edge.Composition, Symbol = Edge.Symbol; // aliases for commonly used Edge classes

  //Edge symbol: 'stage'
  (function(symbolName) {


    Symbol.bindTriggerAction(compId, symbolName, "Default Timeline", 18760, function(sym, e) {
      // Play the timeline at a label or specific time. For example:
      // sym.play(500); or sym.play("myLabel");
      //sym.play("start");

    });
    //Edge binding end

    Symbol.bindTriggerAction(compId, symbolName, "Default Timeline", 16760, function(sym, e) {
      //sym.stop();

    });
    //Edge binding end

    Symbol.bindTriggerAction(compId, symbolName, "Default Timeline", 17260, function(sym, e) {
      //sym.stop();

    });
    //Edge binding end


    Symbol.bindTriggerAction(compId, symbolName, "Default Timeline", 19260, function(sym, e) {
      sym.stop();

    });
    //Edge binding end

  })("stage");
  //Edge symbol end:'stage'

})(jQuery, AdobeEdge, "EDGE-88305242");