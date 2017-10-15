




%% ----------------------------------------------------------------
%% 						TOP LEVEL REQUIREMENTS 
%% ----------------------------------------------------------------
% Graduation requirements
graduated :-
	communications,
	arts, 
	electives,
	first_year_reqs, 
	second_year_cpsc_reqs, 
	second_year_math_stats_reqs, 
	third_and_fourth_cpsc_reqs.


% sub requirements in graduation
communications :-
	prop(A, satisfies_req, communications),
	prop(B, satisfies_req, communications),
	prop(A, completed, true),
	prop(B, completed, true),
	dif(A,B).

fourth :-
	fourth_helper(NumberOfCreditsEarned, [0]),
	NumberOfCreditsEarned > 3.

fourth_helper(Acc, CoursesLookedAt) :-
	member(M, CoursesLookedAt).
	dif(M, A),
	prop(A, completed, X),
	three_h_level(A),
	CreditsGotten is X + Acc,
	fourth_helper(CreditsGotten, [ A | CoursesLookedAt ]). 
	

%% ----------------------------------------------------------------
%% 						PROPERTY TRIPLES FORM 
%% ----------------------------------------------------------------

% CPSC is the example for all of these prop vals

% prop(courseID, number, X) is true when a course exists with X being the courseID
prop(cpsc312, number, 312).

% prop(courseID, completed, X) is true when a course has been completed with X being one of {true, false}
prop(cpsc312, completed, false).

% prop(courseID, department, X) is true when a course is part of department X
prop(cpsc312, department, scie). 

% prop(courseID, satisfies_req, X) is true when a course satisfies part of the requirement of X
prop(cpsc312, satisfies_req, third_and_fourth_cpsc_reqs).

% prop(courseID, satisfies_req, true) is true when courseID satisfies the requirement for satisfies_req




%% ----------------------------------------------------------------
%% 					COURSE SPECIFICATION REQUIREMENTS 
%% ----------------------------------------------------------------

% communications requirement:
% ENGL 100, 110, 111, 112 (recommended), 120, 121; SCIE 113, 300; APSC 176; ASTU 100, 150; WRDS 150 
prop(engl100, satisfies_req, communications).
prop(engl110, satisfies_req, communications).
prop(engl111, satisfies_req, communications).
prop(engl112, satisfies_req, communications).
prop(engl120, satisfies_req, communications).
prop(engl121, satisfies_req, communications).
prop(scie113, satisfies_req, communications).
prop(scie300, satisfies_req, communications).
prop(apsc176, satisfies_req, communications).
prop(astu100, satisfies_req, communications).
prop(astu150, satisfies_req, communications).
prop(wrds150, satisfies_req, communications). 







%% ----------------------------------------------------------------
%% 						COURSE DECLARATIONS
%% ----------------------------------------------------------------

%% CPSC COURSE DECLARATIONS

%% CPSC 100 levels

prop(cpsc100,number,100).
prop(cpsc100,department,cpsc).

prop(cpsc103,number,103).
prop(cpsc103,department,cpsc).

prop(cpsc110,number,110).
prop(cpsc110,department,cpsc).

prop(cpsc121,number,121).
prop(cpsc121,department,cpsc).


% CPSC 200 levels

prop(cpsc210, number, 210).
prop(cpsc210, department, cpsc). 

prop(cpsc213, number, 213).
prop(cpsc213, department, cpsc). 



% CPSC 300 levels


% CPSC 400 levels

prop(cpsc404,number,404).
prop(cpsc404,department,cpsc).

prop(cpsc406,number,406).
prop(cpsc406,department,cpsc).

prop(cpsc410,number,410).
prop(cpsc410,department,cpsc).

prop(cpsc411,number,411).
prop(cpsc411,department,cpsc).

prop(cpsc415,number,415).
prop(cpsc415,department,cpsc).

prop(cpsc416,number,416).
prop(cpsc416,department,cpsc).

prop(cpsc418,number,418).
prop(cpsc418,department,cpsc).

prop(cpsc420,number,420).
prop(cpsc420,department,cpsc).

prop(cpsc421,number,421).
prop(cpsc421,department,cpsc).

prop(cpsc422,number,422).
prop(cpsc422,department,cpsc).

prop(cpsc424,number,424).
prop(cpsc424,department,cpsc).

prop(cpsc436D,number,436).
prop(cpsc436D,department,cpsc).

prop(cpsc444,number,444).
prop(cpsc444,department,cpsc).

prop(cpsc445,number,445).
prop(cpsc445,department,cpsc).

prop(cpsc448,number,448).
prop(cpsc448,department,cpsc).

prop(cpsc449,number,449).
prop(cpsc449,department,cpsc).

prop(cpsc490,number,490).
prop(cpsc490,department,cpsc).


