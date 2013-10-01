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
        
        var sentences = getSentences();
        var count = 0;
        context.font = "30px sans-serif"
        context.fillStyle = "navy";
        context.fillText (sentences[count], 500, 80);
        var x = 500;
        var letters = sentences[count].split("");
        context.fillStyle = "orange"; 

        // this the the key righ here!
        var test = letters.slice(0, 5).join("");
        context.fillText (test, 500, 80);

        if (!paused)
        {
            context.fillStyle = "orange"; 
            $(window).keypress(function(e) {
                var letter = getLetter(e);
                if (letter == letters[count])
                {
                    // every time a key is pressed, add a letter from the line 
                    context.fillText (letters[count], x, 80);
                    // add the width of the previous letter to the x coordinate of the new letter
                    x -= context.measureText(letters[count]).width;
                    count += 1;
                }
                // if the wrong letter in input
                else
                {
                    // alert("wrong letter!");
                    // need a sound here and some kind of error symbol maybe? 
                }
            });
        }
    }

    // lines is an array of sentences
    function getSentences() {
        var result = false;
        var textFile = "/game/arabic_sentences.html";
        $.ajax({
            url: textFile, 
            success: function(text) { result = text; },
            async: false
        });
        return result.split("\n");
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

