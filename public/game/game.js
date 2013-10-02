$(document).ready(function() {
    var canvas = $("#gameCanvas");
    var context = canvas.get(0).getContext("2d");
    context.font = "bold 30px 'courier new'"

    // Canvas dimensions
    var canvasWidth = canvas.width();
    var canvasHeight = canvas.height();
    var paused = true;

    // create a game object which keeps track of sentences, sentenceNumber, correctCount, etc
    
    var Game = function() {
        this.getSentences = function() {
            // lines is an array of sentences
            var result = false;
            var textFile = "/game/arabic_sentences.html";
            $.ajax({
                url: textFile, 
                success: function(text) { result = text; },
                async: false
            });
            return result.split("\n");
        }

        this.sentenceNumber = 0;
        this.level = 0;
        this.sentences = this.getSentences();
        
        this.getUserLetter = function(e) {
            var charCode = e.which; // charCode will contain the code of the character inputted
            var letter = String.fromCharCode(charCode); // theChar will contain the actual character
            return letter;
        }

        this.clearCanvas = function() {
          context.clearRect(0, 0, canvasWidth, canvasHeight);
        }
    }

    var Sentence = function(sentenceString) {
        this.sentenceString = sentenceString; 
        this.correctCount = 0;

        this.getLetters = function() {
            var letters = sentenceString.split("");
            return letters;
        }

        this.letters = this.getLetters();

        this.setState = function() {
            context.fillStyle = "rgba(45, 39, 97, 1)"; 
        }

        this.redraw = function() {
            this.setState();
            context.fillText (sentenceString, 500, 80);
        }
    }

    var Highlighter = function() {
        this.width = 0;

        this.setState = function() {
            context.fillStyle = "rgba(255, 204, 0, 0.5)"; 
        }
    }

    var InputHandler = function() {
    }

    function runGame() {
        var game = new Game();
        var sentence = new Sentence(game.sentences[game.sentenceNumber]);
        var inputHandler = new InputHandler();
        sentence.redraw();


        //context.fillText (sentences[sentenceNumber], 500, 80);
        //var rectWidth = 0;
        //var letters = getLetters(sentences[sentenceNumber])

        if (!paused)
        {
            $(window).keypress(function(e) {
                var letter = game.getUserLetter(e);
                // prevent scrolling when space bar is hit
                console.log(letter);
                if (letter == " ")
                    e.preventDefault();
                if (letter == sentence.letters[sentence.correctCount])
                {
                    console.log("good job"); 
                }
                // if the wrong letter in input
                else
                {
                     
                }
            });
        }
    }

    function handleCorrectInput() {
        redrawSentence(sentences[sentenceNumber]);
        correctCount += 1;
        var currentSnippet = letters.slice(0, correctCount).join("");
        rectWidth = -(context.measureText(currentSnippet).width);
        setHighlightState();
        context.fillRect(500, 55, rectWidth, 30);
        
        // user completes a sentence
        if (correctCount == letters.length)
        {
            moveToNextSentence();   
        }
    }

    function moveToNextSentence() {
        sentenceNumber += 1;
        correctCount = 0;
        letters = getLetters(sentences[sentenceNumber])
        context.clearRect(0, 0, canvasWidth, canvasHeight);
        redrawSentence(sentences[sentenceNumber]);
    }

    function handleIncorrectInput() {
        console.log("wrong letter"); 
        // need a sound here and some kind of error symbol maybe?
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

