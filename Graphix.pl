:-use_module(library(tabular)).


board_color:-
	new(D,dialog('connect four')),
	new(T,tabular),
	send(D,background,blue),
	send(D,display,T),
	send(T,border,0),
	send(T,cell_spacing,-9),
	send(T,rules,all),
	board(List),
	connect_color(1,1,T,List,D),
	send(D,open_centered).



connect_color(7,8,_,_,_).



connect_color(Line,8,T,List,D):-
	send(T,next_row),
	NewLine is Line+1,
	connect_color(NewLine,1,T,List,D).


connect_color(1,Col,T,List,D):-
       	not(member(soldier(2,Col,_),List)),
       	new(B,bitmap('arrow1.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	send(B,recogniser,click_gesture(left,'',single,and(message(D,destroy),message(@prolog,drop,Col)))),
	connect_color(1,NewCol,T,List,D).



connect_color(1,Col,T,List,D):-
	member(soldier(2,Col,_),List),
       	new(B,bitmap('smiley.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color(1,NewCol,T,List,D).




connect_color(Line,Col,T,List,D):-
	member(soldier(Line,Col,yellow),List),
	new(B,bitmap('yellow.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color(Line,NewCol,T,List,D).



connect_color(Line,Col,T,List,D):-
	member(soldier(Line,Col,red),List),
	new(B,bitmap('red.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color(Line,NewCol,T,List,D).

connect_color(Line,Col,T,List,D):-
	new(B,bitmap('blank.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color(Line,NewCol,T,List,D).




changeturn(red):-
	retract(turn(_)),
	assert(turn(yellow)).


changeturn(yellow):-
	retract(turn(_)),
	assert(turn(red)).




drop(Col):-
	board(Board),
	putPiece(Col),
	writeln('drop'),
	(  ((winner);(isFull(Board,1)));
      	    (changeturn(yellow),
	     computer_move)).


putPiece(Col):-
	turn(Turn),
	board(List),
	not(member(soldier(_,Col,_),List)),
	retract(board(_)),
	assert(board([soldier(7,Col,Turn)|List])).


putPiece(Col):-
	turn(Turn),
	board(List),
	member(soldier(Line,Col,_),List),
	not((member(soldier(Line2,Col,_),List),Line2<Line)),
	Line1 is Line-1,
	retract(board(_)),
	assert(board([soldier(Line1,Col,Turn)|List])).


end:-
       	board_color1,
	turn(Turn),
	new(W,window('Winner!')),
	new(B,bitmap('winner.bmp')),
       	send(W,background,B),
       	new(Text,text(Turn,center,font(ariel,bold,12))),
	new(Text,text(' player wins the game!',center,font(ariel,bold,12))),
	new(Text,colour(green)).

endTie:-
	board_color1,
	new(W,window('Tie!')),
       	new(B,bitmap('tie.bmp')),
	send(W,background,B),
	new(Text,text('Tie.',center,font(ariel,bold,12))),
	new(Text,colour(blue)).




board_color1:-
	new(D,dialog('Winner!')),
       	new(T,tabular),
	send(D,background,blue),
	send(D,display,T),
	send(T,border,0),
	send(T,cell_spacing,-9),
	send(T,rules,all),
	board(List),
	connect_color1(1,1,T,List,D),
	send(D,open_centered).




connect_color1(7,8,_,_,_).



connect_color1(Line,8,T,List,D):-
	send(T,next_row),
	NewLine is Line+1,
	connect_color1(NewLine,1,T,List,D).


connect_color1(1,Col,T,List,D):-
	new(B,bitmap('smiley.bmp')),
	send(T,append,B),
	NewCol is Col+1,
      	connect_color1(1,NewCol,T,List,D).


connect_color1(Line,Col,T,List,D):-
	member(soldier(Line,Col,yellow),List),
	new(B,bitmap('yellow.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color1(Line,NewCol,T,List,D).

connect_color1(Line,Col,T,List,D):-
	member(soldier(Line,Col,red),List),
	new(B,bitmap('red.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color1(Line,NewCol,T,List,D).

connect_color1(Line,Col,T,List,D):-
	new(B,bitmap('blank.bmp')),
	send(T,append,B),
	NewCol is Col+1,
	connect_color1(Line,NewCol,T,List,D).
































