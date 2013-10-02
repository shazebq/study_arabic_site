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
        var correctCount = 0;
        var sentenceNumber = 0;
        
        setSentenceState();
        context.font = "bold 30px 'courier new'"
        context.fillText (sentences[sentenceNumber], 500, 80);
        var rectWidth = 0;
        var letters = getLetters(sentences[sentenceNumber])

        if (!paused)
        {
            $(window).keypress(function(e) {
                var letter = getLetter(e);
                // prevent scrolling when space bar is hit
                if (letter == " ")
                    e.preventDefault();
                if (letter == letters[correctCount])
                {
                    context.clearRect(0, 0, canvasWidth, canvasHeight);
                    redrawSentence(sentences[sentenceNumber]);
                    correctCount += 1;
                    var currentSnippet = letters.slice(0, correctCount).join("");
                    rectWidth = -(context.measureText(currentSnippet).width);
                    setHighlightState();
                    context.fillRect(500, 55, rectWidth, 30);
                   
                    // user completes a sentence
                    if (correctCount == letters.length)
                    {
                        sentenceNumber += 1;
                        correctCount = 0;
                        letters = getLetters(sentences[sentenceNumber])
                        context.clearRect(0, 0, canvasWidth, canvasHeight);
                        redrawSentence(sentences[sentenceNumber]);
                    }
                }
                // if the wrong letter in input
                else
                {
                    console.log("wrong letter"); 
                    // need a sound here and some kind of error symbol maybe? 
                }
            });
        }
    }

    // get the letters of one sentence
    function getLetters(sentence) {
        var letters = sentence.split("");
        return letters;
    }

    function setSentenceState() {
        context.fillStyle = "rgba(45, 39, 97, 1)"; 
    }

    function setHighlightState() {
        context.fillStyle = "rgba(255, 204, 0, 0.5)"; 
    }

    function redrawSentence(sentence) {
        setSentenceState();
        context.fillText (sentence, 500, 80);
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

