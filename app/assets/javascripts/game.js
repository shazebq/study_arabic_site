
$(document).ready(function() {
    var canvas = $("#gameCanvas");
    var context = canvas.get(0).getContext("2d");

    // Canvas dimensions
    var canvasWidth = canvas.width();
    var canvasHeight = canvas.height();

    var paused = true;

    var Asteroid = function(x, y) {
        this.x = x;
        this.y = y;
    };

    var asteroid = new Asteroid(0,0);

    function getLetter(e) {
        var charCode = e.which; // charCode will contain the code of the character inputted
        var letter = String.fromCharCode(charCode); // theChar will contain the actual character
        return letter;
    }

    function runGame() {
        //context.clearRect(0, 0, canvasWidth, canvasHeight);
        //context.fillStyle = "black";
        //context.fillRect(asteroid.x, asteroid.y, 40, 40); // redraw the sqaure in a new position
        //asteroid.x += 5;
        //asteroid.y += 5;

        // if not paused
        //if (!paused)
        //{
        //    setTimeout(runGame, 33);
        //};
        //

        //var textFile = "/Users/user/Projects/js_game/arabic_typing/sentences.html";

        //var textReader = new FileReader();
        //textReader.readAsText(textFile);
        
        


        if (!paused)
        {
            $(window).keypress(function(e) {
                //var letter = getLetter(e)         
                //
                console.log("wooow"); 
              
                


                //var textReader = new FileReader();
                //textReader.readAsText(textFile);
                //console.log(textFile.name);
            });
        }
    }


    function init(){
        setUpUi();
        runGame();
    }

    function setUpUi(){
       var startButton = $("#startButton");
       var stopButton = $("#stopButton");

       stopButton.hide();
       
       startButton.click(function(){
         $(this).hide();
         stopButton.show();
         paused = false;
         runGame();
       });

       stopButton.click(function(){
         $(this).hide();
         startButton.show();
         paused = true;
         // unbind the keydown listener
         $(window).unbind("keypress");
       });
    }

    init();

});

