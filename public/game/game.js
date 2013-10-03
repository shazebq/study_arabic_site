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
        this.points = 0;
        this.gameDisplay = new GameDisplay();

        this.addPoints = function() {
            this.points += 5;
            this.gameDisplay.updateScore(this.points);
        }
        
        this.getUserLetter = function(e) {
            var charCode = e.which; // charCode will contain the code of the character inputted
            var letter = String.fromCharCode(charCode); // theChar will contain the actual character
            return letter;
        }

        this.clearCanvas = function() {
          context.clearRect(0, 0, canvasWidth, canvasHeight);
        }
    }

    var GameDisplay = function() {
        
        this.updateScore = function(points) {
            // update the UI to display the new score
            $("#score").html(points);
        }

        this.updateLevel = function() {
        }
    }

    var cover = function() {
        this.x = 0;
        this.y = 0;

        this.setState = function() {
            context.fillStyle = "rgba(0, 195, 209, 1)"; 
        }

        this.clearCover = function() {
            
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
            context.fillText (sentenceString, 500, 200);
        }

        this.getCurrentSnippet = function() {
            return this.letters.slice(0, this.correctCount).join("");
        }
    }

    var Highlighter = function() {
        this.width = 0;

        this.setState = function() {
            context.fillStyle = "rgba(255, 204, 0, 0.5)"; 
        }

        this.highlight = function(currentSnippet) {
            this.width = -(context.measureText(currentSnippet).width);
            this.setState();
            context.fillRect(500, 175, this.width, 30);
        }
    }

    var InputHandler = function() {
        this.handleCorrectInput = function(game, sentence, highlighter) {
            game.clearCanvas();
            sentence.redraw();
            sentence.correctCount += 1;
            currentSnippet = sentence.getCurrentSnippet();
            highlighter.highlight(currentSnippet);
            // user completes a sentence
        }

        // check if user has completed the sentence such that a new sentence is necessary
        this.checkForNextSentence = function(game, sentence) {
            if (sentence.correctCount == sentence.letters.length)
            {
                game.sentenceNumber += 1;
                sentence = new Sentence(game.sentences[game.sentenceNumber]);
                game.clearCanvas();
                game.addPoints();
                sentence.redraw();
            }  
            return sentence;
        }

        this.handleIncorrectInput = function() {
          console.log("wrong letter");
        }
    }

    function runGame() {
        var game = new Game();
        var sentence = new Sentence(game.sentences[game.sentenceNumber]);
        var inputHandler = new InputHandler();
        var highlighter = new Highlighter();
        sentence.redraw();

        if (!paused)
        {
            $(window).keypress(function(e) {
                var letter = game.getUserLetter(e);
                // prevent scrolling when space bar is hit
                if (letter == " ")
                    e.preventDefault();
                if (letter == sentence.letters[sentence.correctCount])
                {
                    inputHandler.handleCorrectInput(game, sentence, highlighter);
                    sentence = inputHandler.checkForNextSentence(game, sentence);
                    console.log("points: " + game.points);
                }
                // if the wrong letter in input
                else
                {
                    inputHandler.handleIncorrectInput(); 
                }
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

