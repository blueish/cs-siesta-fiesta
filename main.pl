%% ----------------------------------------------------------------
%% 						TOP LEVEL REQUIREMENTS 
%% ----------------------------------------------------------------
% Graduation requirements
%% graduated :-
%% 	communications, % done
%% 	arts, % joel
%% 	electives, %sam 
%% 	first_year_reqs,  %sam  todo
%% 	second_year_cpsc_reqs,  %sam  done
%% 	second_year_math_stats_reqs,  %sam done
%% 	third_and_fourth_cpsc_reqs. % joel done


% transcriptA = [cpsc110, cpsc121, math100, math101, cpsc210, cpsc213, cpsc221, math200, math221, stat241,  cpsc310, cpsc313, cpsc320, cpsc311, cpsc312, cpsc317, cpsc420, cpsc410, cpsc420, stats241, engl100, engl112, phil220, engl153, crwr230].
% completetranscript: [engl100,engl110,phil120,phil220,psyc101,psyc102,cpsc110,cpsc121,math100,math101,phys101,chem101]

graduated(Transcript, NotUsed) :-
	new_graduated(Transcript, _, _, _, _, _, NotUsed).
% try
% 
new_graduated(Transcript, First_Year_Courses, Second_Year_CPSC_Courses, Second_Year_MATH_STAT_Courses, Third_Fourth_Year_CPSC_Courses, Communications_Courses,Electives) :-
	first_year_reqs(Transcript, R1),
	courses_removed_from_transcript(Transcript, First_Year_Courses, R1),
	second_year_cpsc_reqs(R1, R2),
	courses_removed_from_transcript(R1, Second_Year_CPSC_Courses, R2),
	second_year_math_stats_reqs(R2, R3),
	courses_removed_from_transcript(R2, Second_Year_MATH_STAT_Courses, R3),
	third_and_fourth_cpsc_reqs(R3, R4),
	courses_removed_from_transcript(R3, Third_Fourth_Year_CPSC_Courses, R4),
	communications_reqs(R4, R5),
	courses_removed_from_transcript(R4, Communications_Courses, R5),
	electives(R5, R6),
	courses_removed_from_transcript(R5, Electives, R6).


%arts is true when Result is Transcript - (4 courses that satisfy arts reqs)
arts(Transcript, Result) :-
	pull_arts_course_from_trans(Transcript, ResultCourse1, ResultTrans1),
	pull_arts_course_from_trans(ResultTrans1, ResultCourse2, ResultTrans2),
	pull_arts_course_from_trans(ResultTrans2, ResultCourse3, ResultTrans3),
	pull_arts_course_from_trans(ResultTrans3, ResultCourse4, Result),
	remove_courses_from_transcript(Transcript,[ResultCourse1,ResultCourse2,ResultCourse3,ResultCourse4],Result).

first_year_reqs(Transcript, R3) :-
	% the two comp scis
	remove_courses_from_transcript(Transcript, [ cpsc110, cpsc121 ], R1),
	math100_eqs(R1, R2),
	math101_eqs(R2, R3),
	physical_science_req,
	bio_req.


second_year_cpsc_reqs(Transcript, RestOfTranscript) :- 
	remove_courses_from_transcript(Transcript, [ cpsc210, cpsc213, cpsc221, math200, math221 ], RestOfTranscript).


% two options: STAT200 & MATH/STAT 302, or STAT241 and 1 extra elective (can count all credits)
% second_year_math_stats_reqs(T, R) is true when R is T minus the required math/stats courses 
second_year_math_stats_reqs(Transcript, RestOfTranscript) :- remove_courses_from_transcript( Transcript, [ stat200, math302 ], RestOfTranscript).
second_year_math_stats_reqs(Transcript, RestOfTranscript) :- remove_courses_from_transcript( Transcript, [ stat200, stat302 ], RestOfTranscript).
second_year_math_stats_reqs(Transcript, RestOfTranscript) :- remove_courses_from_transcript( Transcript, [ stat241 ], RestOfTranscript).

electives(Transcript, R2) :-
	breadth_credits(Transcript, R1).
	credits_earned_extra(R1, R2).


%% ----------------------------------------------------------------
%% 						NLP
%% ----------------------------------------------------------------

% lets try the simple case, we only want to be able to ask:
% can I graduate
% am i finished with first year
% am i finished with second year
% am i finished with communications requirements
% am i finished with math requirements
% am i finished with upper year courses

% NLP 

% try the following
% question([cpsc110, cpsc121, math100, math101, cpsc210, cpsc213, cpsc221, math200, math221, stat241,  cpsc310, cpsc313, cpsc320, cpsc311, cpsc312, cpsc317, cpsc420, cpsc410, cpsc420, stats241, engl100, engl112, phil220, engl153, crwr230], [can,i,graduate], R).
%  question([cpsc110, cpsc121, math100, math101, cpsc210, cpsc213, cpsc221, math200, math221, stat241,  cpsc310, cpsc313, cpsc320, cpsc311, cpsc312, cpsc317, cpsc420, cpsc410, cpsc420, stats241, engl100, engl112, phil220, engl153, crwr230], [am, i, finished, with, communications, requirements], R).
%  question([cpsc110, cpsc121, math100, math101, cpsc210, cpsc213, cpsc221, math200, math221, stat241,  cpsc310, cpsc313, cpsc320, cpsc311, cpsc312, cpsc317, cpsc420, cpsc410, cpsc420, stats241, engl100, engl112, phil220, engl153, crwr230], [am, i, finished, with, second, year], R).

question(Transcript, [can, i, graduate], [yes]) :- graduated(Transcript, _).

question(Transcript, [am, i, finished,with | QTail], [yes]) :-
	requirements_noun(QTail, Transcript).

requirements_noun([first_year_reqs, year],        Transcript) :- first_year_reqs(Transcript, _).
requirements_noun([second, year],                 Transcript) :- second_year_cpsc_reqs(Transcript, _).
requirements_noun([communications, requirements], Transcript) :- communications_reqs(Transcript, _).
requirements_noun([math, requirements],           Transcript) :- second_year_math_stats_reqs(Transcript, _).
requirements_noun([upper, year, courses],         Transcript) :- third_and_fourth_cpsc_reqs(Transcript, _).

%% ----------------------------------------------------------------
%% 						HELPER METHODS
%% ----------------------------------------------------------------

% remove_courses_from_transcript(T, C, R) is true when C is a subset of T and R is T - C (set difference)
remove_courses_from_transcript(R, [], R).
remove_courses_from_transcript(Transcript, [ Acourse | RestRequired ], X) :-
	select(Acourse, Transcript, DeleteResult),
	remove_courses_from_transcript(DeleteResult, RestRequired, X).

%courses_removed_from_transcript(A,B,C) is true when B = A - C.
courses_removed_from_transcript(Transcript, [], Transcript).
courses_removed_from_transcript(Transcript, CoursesUsed, ResultTrans) :- 
	subtract(Transcript, ResultTrans, CoursesUsed).


breadth_credits(Transcript, R3) :-
	pull_breadth_course(Transcript, _, R1),
	pull_breadth_course(R1,         _, R2),
	pull_breadth_course(R2,         _, R3).

pull_breadth_course(Transcript, C, R) :-
	prop(C, department, D),
	dif(D, cpsc),
	dif(D, math),
	dif(D, stats),
	select(C, Transcript, R).
	
credits_earned_extra(Transcript, Result) :-
	pull_any_course(Transcript,   _, ResultTrans1),
	pull_any_course(ResultTrans1, _, ResultTrans2),
	pull_any_course(ResultTrans2, _, ResultTrans3),
	pull_any_course(ResultTrans3, _, ResultTrans4),
	pull_any_course(ResultTrans4, _, ResultTrans5),
	pull_any_course(ResultTrans5, _, Result).

pull_any_course(Transcript, Course, Result) :-
	select(Course, Transcript, Result).

%arts requirement
%All courses in the Faculty of Arts are eligible to fulfill the Arts Requirement.

%pull_arts_course_from_trans is true when ResultTrans is Transcript - ResultCourse where ResultCourse is faculty of arts
pull_arts_course_from_trans(Transcript, ResultCourse, ResultTrans) :-
	prop(ResultCourse, faculty, arts),
	member(ResultCourse, Transcript),
	select(ResultCourse, Transcript, ResultTrans).


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


% -----------------------   First Year requirements 

% any of these math courses fulfill math100 
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math100], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math102], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math104], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math110], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math111], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math120], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math180], R).
math100_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math184], R).


% any of these math courses fulfill math101
math101_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math101], R).
math101_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math103], R).
math101_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math105], R).
math101_eqs(Transcript, R) :- remove_courses_from_transcript(Transcript, [math121], R).


% TODO
% physical science req
% 100-Level CHEM or PHYS courses. PHYS100 and CHEM111 do not count for this requirement. Students without high school Chemistry 12 must also take CHEM111. Students without high school Physics 12 must also take PHYS100.
physical_science_req.

% Students without high school Biology 11 or 12 must complete BIOL111. Students with high school Biology 11 or 12 must take 3 credits in any ASTR, ATSC, BIOL, EOSC, or GEOB lecture course.
% for simplicity we will assume the student took bio 11 or bio 12
bio_req.


%% --------------- THIRD AND FOURTH REQS

% try:
% third_and_fourth_cpsc_reqs([ cpsc310, cpsc313, cpsc320, cpsc311, cpsc312, cpsc317, cpsc420, cpsc410, cpsc420, stats241 ], R).
third_and_fourth_cpsc_reqs(Transcript, R3) :-
	remove_courses_from_transcript(Transcript, [cpsc310, cpsc313, cpsc320], R1),
	three_h_levels(R1, R2),
	four_h_levels(R2, R3).
	

three_h_levels(Transcript, R3) :-
	pull_three_level(Transcript, _, R1),
	pull_three_level(R1, _, R2),
	pull_three_level(R2, _, R3).

% pull_three_level(T, C, R) is true when a course that is a three hundred level cpsc course is C and R is T with C removed
pull_three_level(Transcript, Course, R) :-
	prop(Course, number, CourseNumber),
	prop(Course, department, cpsc),
	CourseNumber >= 300,
	CourseNumber < 400,
	select(Course, Transcript, R).


four_h_levels(Transcript, R3) :-
	pull_four_level(Transcript, _, R1),
	pull_four_level(R1,         _, R2),
	pull_four_level(R2,         _, R3).

pull_four_level(Transcript, Course, R) :-
	prop(Course, number, CourseNumber),
	prop(Course, department, cpsc),
	CourseNumber >= 400,
	select(Course, Transcript, R).



% ------------------ communications reqs 

communications_reqs(Transcript, R) :-
	prop(A, satisfies_req, communications),
	prop(B, satisfies_req, communications),
	dif(A,B),
	remove_courses_from_transcript(Transcript, [ A, B ], R).

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

% ARTS DECLARATIONS
%Note: for simplicity, arts course declarations will be limited to a reasonable number to satisfy the query
prop(engl100 ,number, 100).
prop(engl100 ,department, engl).

prop(engl112 ,number,112).
prop(engl112 ,department, engl).

prop(psyc102,number,102).
prop(psyc102,department,psyc).

prop(psyc101,number,101).
prop(psyc101,department,psyc).

prop(phil120 ,number,120).
prop(phil120 ,department, phil).

prop(phil220 ,number,220).
prop(phil220 ,department, phil).

prop(engl153 ,number,153).
prop(engl153 ,department, engl).

prop(psyc314 ,number,314).
prop(psyc314 ,department, psyc).

prop(crwr230 ,number,230).
prop(crwr230 ,department,crwr ).

prop(phil321 ,number,321).
prop(phil321 ,department,phil).

% CHEM AND PHYS 100 levels (and bio 111)

prop(biol111, number, 111).
prop(biol111, department, biol).

prop(phys100, number, 100).
prop(phys100, department, phys).

prop(phys101, number, 101).
prop(phys100, department, phys).

prop(phys107, number, 107).
prop(phys107, department, phys).

prop(phys108, number, 108).
prop(phys108, department, phys).

prop(phys109, number, 109).
prop(phys109, department, phys).

prop(phys117, number, 117).
prop(phys117, department, phys).

prop(phys118, number, 118).
prop(phys118, department, phys).

prop(phys119, number, 119).
prop(phys119, department, phys).

prop(phys157, number, 157).
prop(phys157, department, phys).

prop(phys158, number, 158).
prop(phys158, department, phys).

prop(phys159, number, 159).
prop(phys159, department, phys).

prop(phys170, number, 170).
prop(phys170, department, phys).


prop(chem111, number, 111).
prop(chem111, department, chem).

prop(chem121, number, 121).
prop(chem121, department, chem).

prop(chem123, number, 123).
prop(chem123, department, chem).

prop(chem154, number, 154).
prop(chem154, department, chem).









% OTHER DECLARATIONS

prop(chem101, number, 101).
prop(chem101, department, chem).

prop(phys101, number, 101).
prop(phys101, department, phys).


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