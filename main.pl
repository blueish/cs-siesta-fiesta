


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





%% PROP TRIPLES

% CPSC is the example for all of these prop vals

% prop(courseID, number, X) is true when a course exists with X being the courseID
prop(cpsc312, number, 312).

% prop(courseID, completed, X) is true when a course has been completed with X being one of {true, false}
prop(cpsc312, completed, false).
% prop(courseID, faculty, X) is true when a course is part of faculty X
prop(cpsc312, faculty, scie). 

% prop(courseID, satisfies_req, X) is true when a course satisfies part of the requirement of X
prop(cpsc312, satisfies_req, third_and_fourth_cpsc_reqs).

% prop(courseID, satisfies_req, true) is true when courseID satisfies the requirement for satisfies_req

%prop(engl100, completed, true).
%prop(engl121, completed, true).

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