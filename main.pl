




%% ----------------------------------------------------------------
%% 						TOP LEVEL REQUIREMENTS 
%% ----------------------------------------------------------------
% Graduation requirements
graduated :-
<<<<<<< HEAD
	communications,
	arts, % joel
	electives, %sam 
	first_year_reqs,  %sam  todo
	second_year_cpsc_reqs,  %sam  done
	second_year_math_stats_reqs,  %sam done
=======
	communications_reqs,
	arts_reqs, % joel
	electives_reqs, %sam 
	first_year_reqs,  %sam 
	second_year_cpsc_reqs,  %sam 
	second_year_math_stats_reqs,  %sam 
>>>>>>> 542734ed59dab122c9c453e261c75062b9b4fdbc
	third_and_fourth_cpsc_reqs. % joel


% sub requirements in graduation
communications_reqs :-
	prop(A, satisfies_req, communications),
	prop(B, satisfies_req, communications),
	prop(A, completed, true),
	prop(B, completed, true),
	dif(A,B).

%arts requirement
%All courses in the Faculty of Arts are eligible to fulfill the Arts Requirement.
arts_reqs :- 
	arts_helper(NumberOfCreditsEarned, [0]),
	NumberOfCreditsEarned >= 12.

arts_helper(Acc, CoursesLookedAt) :-
	member(M, CoursesLookedAt),
	dif(M,A),
	prop(A, completed, X),
	prop(A, faculty, arts),
	arts_helper(X + Acc, [A | CoursesLookedAt]).


fourth :-
	fourth_helper(NumberOfCreditsEarned, [0]),
	NumberOfCreditsEarned > 3.

fourth_helper(Acc, CoursesLookedAt) :-
	member(M, CoursesLookedAt).
	dif(M, A),
	prop(A, completed, X),
	three_h_level(A),
<<<<<<< HEAD
	CreditsGotten is X + Acc,
	fourth_helper(CreditsGotten, [ A | CoursesLookedAt ]). 


first_year_reqs :-
	prop(cpsc110, completed, 4),
	prop(cpsc121, completed, 4),
	math100_eqs,
	math101_eqs,
	physical_science_req,
	bio_req.

second_year_cpsc_reqs :-
	prop(cpsc210, completed, 4),
	prop(cpsc213, completed, 4),
	prop(cpsc221, completed, 4),
	prop(math200, completed, 3),
	prop(math221, completed, 3).

% two options: STAT200 & MATH/STAT 302, or STAT241 and 1 extra elective (can count all credits)
second_year_math_stats_reqs :-
	prop(stat200, completed, 3),
	prop(math302, completed, 3).

second_year_math_stats_reqs :-
	prop(stat200, completed, 3),
	prop(stat302, completed, 3).

second_year_math_stats_reqs :-
	prop(stat241, completed, 4).


electives :-
	breadth_credits.
	credits_earned_extra.

breadth_credits :-
	prop(A, department, C),
	dif(C, cpsc),
	dif(C, math),
	dif(C, stats).

=======
	fourth_helper(X + Acc, [ A | CoursesLookedAt ]). 
>>>>>>> 542734ed59dab122c9c453e261c75062b9b4fdbc
	

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


% First Year requirements helpers

math100_eqs :- prop(math100, completed, 3).
math100_eqs :- prop(math102, completed, 3).
math100_eqs :- prop(math104, completed, 3).
math100_eqs :- prop(math110, completed, 3).
math100_eqs :- prop(math111, completed, 3).
math100_eqs :- prop(math120, completed, 3).
math100_eqs :- prop(math180, completed, 3).
math100_eqs :- prop(math184, completed, 3).

math101_eqs :- prop(math101, completed, 3).
math101_eqs :- prop(math103, completed, 3).
math101_eqs :- prop(math105, completed, 3).
math101_eqs :- prop(math121, completed, 3).


% TODO
% physical science req
% 100-Level CHEM or PHYS courses. PHYS100 and CHEM111 do not count for this requirement. Students without high school Chemistry 12 must also take CHEM111. Students without high school Physics 12 must also take PHYS100.
physical_science_req.

% Students without high school Biology 11 or 12 must complete BIOL111. Students with high school Biology 11 or 12 must take 3 credits in any ASTR, ATSC, BIOL, EOSC, or GEOB lecture course.
bio_req.



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

prop(cpsc221, number, 221).
prop(cpsc221, department, cpsc). 


% CPSC 300 levels
prop(cpsc301, number, 301).
prop(cpsc301, department, cpsc). 

prop(cpsc302, number, 302).
prop(cpsc302, department, cpsc). 

prop(cpsc303, number, 303).
prop(cpsc303, department, cpsc). 

prop(cpsc304, number, 304).
prop(cpsc304, department, cpsc). 

prop(cpsc310, number, 310).
prop(cpsc310, department, cpsc). 

prop(cpsc311, number, 311).
prop(cpsc311, department, cpsc). 

prop(cpsc312, number, 312).
prop(cpsc312, department, cpsc). 

prop(cpsc313, number, 313).
prop(cpsc313, department, cpsc). 

prop(cpsc314, number, 314).
prop(cpsc314, department, cpsc). 

prop(cpsc317, number, 317).
prop(cpsc317, department, cpsc). 

prop(cpsc319, number, 319).
prop(cpsc319, department, cpsc). 

prop(cpsc320, number, 320).
prop(cpsc320, department, cpsc). 

prop(cpsc322, number, 322).
prop(cpsc322, department, cpsc). 

prop(cpsc340, number, 340).
prop(cpsc340, department, cpsc). 

prop(cpsc344, number, 344).
prop(cpsc344, department, cpsc). 

prop(cpsc349, number, 349).
prop(cpsc349, department, cpsc). 


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


%% ----------------------------------------------------------------
%% 						DEPARTMENT DECLARATIONS
%% ----------------------------------------------------------------

%Course A is in the faculty of B if A is in the 
%department of C, and C is in B (Transitive Law)
%prop(A,faculty,B) :- prop(A,department C).

%departments in the faculty of science
prop(A,faculty,scie) :- prop(A, department, cpsc).
prop(A,faculty,scie) :- prop(A, department, envr).
prop(A,faculty,scie) :- prop(A, department, arc).
prop(A,faculty,scie) :- prop(A, department, fish).
prop(A,faculty,scie) :- prop(A, department, biot).
prop(A,faculty,scie) :- prop(A, department, bota).
prop(A,faculty,scie) :- prop(A, department, math).
prop(A,faculty,scie) :- prop(A, department, astr).
prop(A,faculty,scie) :- prop(A, department, enph).
prop(A,faculty,scie) :- prop(A, department, res).
prop(A,faculty,scie) :- prop(A, department, mrne).
prop(A,faculty,scie) :- prop(A, department, gsat).
prop(A,faculty,scie) :- prop(A, department, atsc).
prop(A,faculty,scie) :- prop(A, department, zool).
prop(A,faculty,scie) :- prop(A, department, stat).
prop(A,faculty,scie) :- prop(A, department, dsci).
prop(A,faculty,scie) :- prop(A, department, asic).
prop(A,faculty,scie) :- prop(A, department, scie).
prop(A,faculty,scie) :- prop(A, department, isci).
prop(A,faculty,scie) :- prop(A, department, cspw).
prop(A,faculty,scie) :- prop(A, department, cogs).
prop(A,faculty,scie) :- prop(A, department, chem).
prop(A,faculty,scie) :- prop(A, department, phys).
prop(A,faculty,scie) :- prop(A, department, biol).
prop(A,faculty,scie) :- prop(A, department, micb).



%departments in the faculty of arts
prop(A,faculty,arts) :- prop(A, department, seal).
prop(A,faculty,arts) :- prop(A, department, geog).
prop(A,faculty,arts) :- prop(A, department, arbc).
prop(A,faculty,arts) :- prop(A, department, korn).
prop(A,faculty,arts) :- prop(A, department, wrds).
prop(A,faculty,arts) :- prop(A, department, ling).
prop(A,faculty,arts) :- prop(A, department, japn).
prop(A,faculty,arts) :- prop(A, department, arcl).
prop(A,faculty,arts) :- prop(A, department, itst).
prop(A,faculty,arts) :- prop(A, department, ital).
prop(A,faculty,arts) :- prop(A, department, nest).
prop(A,faculty,arts) :- prop(A, department, info).
prop(A,faculty,arts) :- prop(A, department, indo).
prop(A,faculty,arts) :- prop(A, department, anth).
prop(A,faculty,arts) :- prop(A, department, iest).
prop(A,faculty,arts) :- prop(A, department, iar).
prop(A,faculty,arts) :- prop(A, department, arth).
prop(A,faculty,arts) :- prop(A, department, urst).
prop(A,faculty,arts) :- prop(A, department, ukrn).
prop(A,faculty,arts) :- prop(A, department, hist).
prop(A,faculty,arts) :- prop(A, department, tibt).
prop(A,faculty,arts) :- prop(A, department, thtr).
prop(A,faculty,arts) :- prop(A, department, swed).
prop(A,faculty,arts) :- prop(A, department, hinu).
prop(A,faculty,arts) :- prop(A, department, heso).
prop(A,faculty,arts) :- prop(A, department, span).
prop(A,faculty,arts) :- prop(A, department, hebr).
prop(A,faculty,arts) :- prop(A, department, ccst).
prop(A,faculty,arts) :- prop(A, department, cdst).
prop(A,faculty,arts) :- prop(A, department, arts).
prop(A,faculty,arts) :- prop(A, department, cens).
prop(A,faculty,arts) :- prop(A, department, asia).
prop(A,faculty,arts) :- prop(A, department, soci).
prop(A,faculty,arts) :- prop(A, department, chil).
prop(A,faculty,arts) :- prop(A, department, chin).
prop(A,faculty,arts) :- prop(A, department, mdvl).
prop(A,faculty,arts) :- prop(A, department, asla).
prop(A,faculty,arts) :- prop(A, department, clch).
prop(A,faculty,arts) :- prop(A, department, clst).
prop(A,faculty,arts) :- prop(A, department, grsj).
prop(A,faculty,arts) :- prop(A, department, cnrs).
prop(A,faculty,arts) :- prop(A, department, cnto).
prop(A,faculty,arts) :- prop(A, department, grek).
prop(A,faculty,arts) :- prop(A, department, soal).
prop(A,faculty,arts) :- prop(A, department, gpp).
prop(A,faculty,arts) :- prop(A, department, germ).
prop(A,faculty,arts) :- prop(A, department, acam).
prop(A,faculty,arts) :- prop(A, department, geob).
prop(A,faculty,arts) :- prop(A, department, visa).
prop(A,faculty,arts) :- prop(A, department, slav).
prop(A,faculty,arts) :- prop(A, department, crwr).
prop(A,faculty,arts) :- prop(A, department, csis).
prop(A,faculty,arts) :- prop(A, department, astu).
prop(A,faculty,arts) :- prop(A, department, ctln).
prop(A,faculty,arts) :- prop(A, department, dani).
prop(A,faculty,arts) :- prop(A, department, pers).
prop(A,faculty,arts) :- prop(A, department, latn).
prop(A,faculty,arts) :- prop(A, department, scan).
prop(A,faculty,arts) :- prop(A, department, phil).
prop(A,faculty,arts) :- prop(A, department, dmed).
prop(A,faculty,arts) :- prop(A, department, sans).
prop(A,faculty,arts) :- prop(A, department, fren).
prop(A,faculty,arts) :- prop(A, department, russ).
prop(A,faculty,arts) :- prop(A, department, fnis).
prop(A,faculty,arts) :- prop(A, department, fnel).
prop(A,faculty,arts) :- prop(A, department, fnel).
prop(A,faculty,arts) :- prop(A, department, fmst).
prop(A,faculty,arts) :- prop(A, department, fist).
prop(A,faculty,arts) :- prop(A, department, afst).
prop(A,faculty,arts) :- prop(A, department, last).
prop(A,faculty,arts) :- prop(A, department, rmst).
prop(A,faculty,arts) :- prop(A, department, poli).
prop(A,faculty,arts) :- prop(A, department, rgla).
prop(A,faculty,arts) :- prop(A, department, engl).
prop(A,faculty,arts) :- prop(A, department, relg).
prop(A,faculty,arts) :- prop(A, department, laso).
prop(A,faculty,arts) :- prop(A, department, punj).
prop(A,faculty,arts) :- prop(A, department, psyc).
prop(A,faculty,arts) :- prop(A, department, fipr).
prop(A,faculty,arts) :- prop(A, department, fhis).
prop(A,faculty,arts) :- prop(A, department, port).
prop(A,faculty,arts) :- prop(A, department, pols).
prop(A,faculty,arts) :- prop(A, department, fact).