%we remove and p
% we don't visit any point we visited before because we tried all solutions from this point of the path
% and we don't need to try it again
%row first
can([X,Y] , Visited ):-
	dim(R,C) , X>=0 , Y >=0 , X<R , Y <C ,
	not(member([X,Y] , Visited)),
	not(bomb([X,Y])).


play(Moves , Stars):-
	end(End) , start(Start) , play(Start , End , 0 , Stars , [Start],[] , Moves).
play(End , End , CurrentStars , CurrentStars , _ , CurrentSequence , CurrentSequence):-!.


play([X,Y] , End ,CurrentStars, Stars,Visited ,CurrentSequence, Sequence):-
	NewX1 is X+1 ,NewX2 is X -1 , NewY1 is Y+1 , NewY2 is Y -1,

	(
		star([X,Y]) -> 
			NewStar is CurrentStars +1 ;
			NewStar is CurrentStars
	),
	(
		(	%(x , y+1) right
			can([X , NewY1] , Visited),
			append(Visited,[[X, NewY1]] , NewVisited),
			append(CurrentSequence , [right] , NewCurrentSequence),
			play([X , NewY1] , End ,NewStar , Stars , NewVisited , NewCurrentSequence , Sequence )
		);
		(	%(x , y-1) left
			can([X , NewY2] , Visited),
			append(Visited,[[X, NewY2]] , NewVisited),
			append(CurrentSequence , [left] , NewCurrentSequence),
			play([X , NewY2] , End ,NewStar , Stars , NewVisited , NewCurrentSequence , Sequence )
		);
		(	%(x+1 , y) down
			can([NewX1 , Y] , Visited),
			append(Visited,[[NewX1, Y]] , NewVisited),
			append(CurrentSequence , [down] , NewCurrentSequence),
			play([NewX1 , Y] , End ,NewStar , Stars , NewVisited , NewCurrentSequence , Sequence )
		);
		(	%(x-1 , y) up
			can([NewX2 , Y] , Visited),
			append(Visited,[[NewX2, Y]] , NewVisited),
			append(CurrentSequence , [up] , NewCurrentSequence),
			play([NewX2 , Y] , End ,NewStar , Stars , NewVisited , NewCurrentSequence , Sequence )
		)
	).


%move(location , End ,Stars , Visited )


%% move([X,Y],[NewX,NewY] , End , Stars , Visited, Sequence):-
	
%% 	append([visited] , [[NewX,NewY]] , NewVisited),
%% 	(
%% 		(	star([X , Y]),NewStar is Stars + 1,
%% 			play([NewX,NewY] ,End , NewStar , NewVisited )
%% 		);
%% 		play([NewX,NewY] ,End , Stars , NewVisited )

%% 	).