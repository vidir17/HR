var current = 'cross';
var cross = 'cross';
var circle = 'circle';
var turns = 0;
var xbreyta = 0;
var obreyta = 0;
var boxes = $('.box');
    
$(document).ready(function() {
    $('li').unbind('click').on('click', function(e){
        /*$(this).toggleClass('click');*/
        if ( (!document.getElementById(e.target.id).classList.contains(cross) && 
        !document.getElementById(e.target.id).classList.contains(circle))  ){
            document.getElementById(e.target.id).classList.add(current);
            if(current === cross){ /*ber saman það sem er inn í */
                
                current = circle;
                document.getElementById(e.target.id).innerHTML = "X";
                document.getElementById(e.target.id).style.fontSize = "400%";
                document.getElementById('whos_turn').innerHTML = "O, it's your turn!";
                turns++;
                document.getElementById('turn').innerHTML = "Turns: " + turns;
                
            }else{
                current = cross;
                document.getElementById(e.target.id).innerHTML = "O";
                document.getElementById(e.target.id).style.fontSize = "400%";
                document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
                turns++;
                document.getElementById('turn').innerHTML = "Turns: " + turns;
            }
        }

        if(($("#1").hasClass(cross) && $("#2").hasClass(cross)
        && $("#3").hasClass(cross)) || (($("#4").hasClass(cross) && $("#5").hasClass(cross)
        && $("#6").hasClass(cross))) || (($("#7").hasClass(cross) && $("#8").hasClass(cross)
        && $("#9").hasClass(cross))) || (($("#1").hasClass(cross) && $("#4").hasClass(cross)
        && $("#7").hasClass(cross))) || (($("#2").hasClass(cross) && $("#5").hasClass(cross)
        && $("#8").hasClass(cross))) || (($("#3").hasClass(cross) && $("#6").hasClass(cross)
        && $("#9").hasClass(cross))) || (($("#1").hasClass(cross) && $("#5").hasClass(cross)
        && $("#9").hasClass(cross))) || (($("#3").hasClass(cross) && $("#5").hasClass(cross)
        && $("#7").hasClass(cross))))
        {
        setTimeout(alert('X WINS'), 10000);
        
        current = 0;
        turns = 0;
        xbreyta++;
        if(xbreyta === 1){
            document.getElementById('turnx').innerHTML = "X has " + xbreyta + " point!";
        }
        if(xbreyta > 1)
        {
            document.getElementById('turnx').innerHTML = "X has " + xbreyta + " points!";
        }
        
        document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
        document.getElementById('turn').innerHTML = "Turns: " + turns;
        
        $('#play-again').click(function(){
        boxes.each(function() {
            $(this).empty();
            $(this).removeClass(cross);
            $(this).removeClass(circle);
            current = cross;
            
        });
        })
        $('#start-again').click(function(){
            boxes.each(function() {
                $(this).empty();
                $(this).removeClass(cross);
                $(this).removeClass(circle);
                current = cross;
                obreyta = 0;
                xbreyta = 0;
                document.getElementById('turnx').innerHTML = "X has " + obreyta + " points!";
                document.getElementById('turno').innerHTML = "O has " + obreyta + " points!";
                document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
            });
            })
        }
        else if(($("#1").hasClass(circle) && $("#2").hasClass(circle)
        && $("#3").hasClass(circle)) || (($("#4").hasClass(circle) && $("#5").hasClass(circle)
        && $("#6").hasClass(circle))) || (($("#7").hasClass(circle) && $("#8").hasClass(circle)
        && $("#9").hasClass(circle))) || (($("#1").hasClass(circle) && $("#4").hasClass(circle)
        && $("#7").hasClass(circle))) || (($("#2").hasClass(circle) && $("#5").hasClass(circle)
        && $("#8").hasClass(circle))) || (($("#3").hasClass(circle) && $("#6").hasClass(circle)
        && $("#9").hasClass(circle))) || (($("#1").hasClass(circle) && $("#5").hasClass(circle)
        && $("#9").hasClass(circle))) || (($("#3").hasClass(circle) && $("#5").hasClass(circle)
        && $("#7").hasClass(circle))))
        {
            setTimeout(alert('O WINS'), 10000);
            current = 0;
            turns = 0;
            obreyta++;
            if(obreyta === 1){
                document.getElementById('turno').innerHTML = "O has " + obreyta + " point!";
            }
            if(obreyta > 1)
            {
                document.getElementById('turno').innerHTML = "O has " + obreyta + " points!";
            }

            document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
            document.getElementById('turn').innerHTML = "Turns: " + turns;
            $('#play-again').click(function(){
                boxes.each(function() {
                    $(this).empty();
                    $(this).removeClass(cross);
                    $(this).removeClass(circle);
                    current = cross;
                    
                });
                })
                $('#start-again').click(function(){
                    boxes.each(function() {
                        $(this).empty();
                        $(this).removeClass(cross);
                        $(this).removeClass(circle);
                        current = cross;
                        obreyta = 0;
                        xbreyta = 0;
                        document.getElementById('turnx').innerHTML = "X has " + obreyta + " points!";
                        document.getElementById('turno').innerHTML = "O has " + obreyta + " points!";
                        document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
                        
                    });
                    })
        }
        else if(turns === 9)
        {
            alert('draw');
            document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
            turns = 0;
            document.getElementById('turn').innerHTML = "Turns: " + turns;
            $('#play-again').click(function(){
        boxes.each(function() {
            $(this).empty();
            $(this).removeClass(cross);
            $(this).removeClass(circle);
            current = cross;
            
        });
        })
        $('#start-again').click(function(){
            boxes.each(function() {
                $(this).empty();
                $(this).removeClass(cross);
                $(this).removeClass(circle);
                current = cross;
                obreyta = 0;
                xbreyta = 0;
                document.getElementById('turnx').innerHTML = "X has " + obreyta + " points!";
                document.getElementById('turno').innerHTML = "O has " + obreyta + " points!";
                document.getElementById('whos_turn').innerHTML = "X, it's your turn!";
                
            });
            })
        }
        /*document.getElementById(e.target.id).classList.add('click');
        console.log(document.getElementById(e.target.id));
        console.log(e.target.id);*/
        /*$('#1').click(function() {
            alert("test");
        })*/
    });


   
});
