allListsOk([],[]) :-
    false.
allListsOk([_ | _],[]) :-
    false.
allListsOk([Xss | []],Ys) :-
    msort(Xss, Sorted1),
    msort(Ys, Sorted2),
    Sorted1 == Sorted2.
allListsOk([Xss | Xs],Ys) :-
    msort(Xss, Sorted1),
    msort(Ys, Sorted2),
    Sorted1 == Sorted2,
    allListsOk(Xs,Ys).

isOf(Xss,[Yss | _]) :-
    Xss == Yss.
isOf(Xss,[_ | Ys]) :-
    isOf(Xss,Ys).

allElementsIsOf([Xss | Xs],Ys) :-
    isOf(Xss,Ys),
    allElementsIsOf(Xs,Ys).
allElementsIsOf([],[_ | _]).

:- begin_tests(prologPartAss5).
:- use_module('q3').
:- use_module('q6').
:- use_module('ex5-aux').

/*
 * **********************************************
 * page_in_category tests
 * **********************************************
 */

test(page_in_category1) :-
    findall(X, page_in_category(cnn, X), Xs),
    msort(Xs, Sorted1),
    msort([786983,786983], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category2) :-
    findall(X, page_in_category(X, 564677), Xs),
    msort(Xs, Sorted1),
    msort([ocpc,nbc], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category3) :-
    findall(X, page_in_category(metropolitan, X), Xs),
    msort(Xs, Sorted1),
    msort([], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category4) :-
    page_in_category(cnn, 786983),!.

test(page_in_category5) :-
    categorylinks(858585, bbc),
    category(689969, bbc, true),
    page(858585, 0, acid, 34546),!.

test(page_in_category6,[fail]) :-
    page_in_category(acid, 689969),!.

test(page_in_category7) :-
    categorylinks(558585, nbc),
    category(578483, nbc, true),
    page(558585, 0, aisi, 5656),!.

test(page_in_category8,[fail]) :-
    page_in_category(aisi, 578483),!.

test(page_in_category9) :-
    categorylinks(464236, foxnews),
    category(564677, foxnews, false),
    page(464236, 118, ocpc, 350),!.

test(page_in_category10) :-
    page_in_category(ocpc, 564677),!.

test(page_in_category11) :-
    categorylinks(578483, foxnews),
    category(564677, foxnews, false),
    page(578483, 14, nbc, 9),!.

test(page_in_category12) :-
    page_in_category(nbc, 564677),!.

test(page_in_category13) :-
    findall(X, page_in_category(nbc, X), Xs),
    msort(Xs, Sorted1),
    msort([564677], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category14) :-
    findall(X, page_in_category(ocpc, X), Xs),
    msort(Xs, Sorted1),
    msort([564677], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category15) :-
    findall(X, page_in_category(cnn, X), Xs),
    msort(Xs, Sorted1),
    msort([786983,786983], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category15) :-
    findall(X, page_in_category(X, 786983), Xs),
    msort(Xs, Sorted1),
    msort([cnn,cnn,adp], Sorted2),
    Sorted1 == Sorted2.

test(page_in_category15) :-
    findall(X, page_in_category(X, 689969), Xs),
    msort(Xs, Sorted1),
    msort([], Sorted2),
    Sorted1 == Sorted2.

/*
 * **********************************************
 * splitter_category tests
 * **********************************************
 */

test(splitter_category1) :-
    splitter_category(689969),!.

test(splitter_category2) :-
    splitter_category(564677),!.

test(splitter_category3, [fail]) :-
    splitter_category(858585),!.

test(splitter_category4) :-
    findall(X, splitter_category(X), Xs),
    allElementsIsOf(Xs,[689969,786983,564677]),
    allElementsIsOf([689969,786983,564677],Xs),!.

test(splitter_category5) :-
    splitter_category(786983),!.

/*
 * **********************************************
 * splitter_category tests
 * **********************************************
 */
/**
test(namespace_list1) :-
    findall(X, namespace_list(article, X), Xs),
    allListsOk(Xs,[558585, 689695, 858585]),!.

test(namespace_list2) :-
    findall(X, namespace_list(category, X), Xs),
    allListsOk(Xs,[689969, 786983, 578483,564677]),!.
*/
test(namespace_list3) :-
    findall(X, namespace_list(category_conversation, X), Xs),
    allListsOk(Xs,[786984]),!.

test(namespace_list4) :-
    findall(X, namespace_list(module_conversation, X), Xs),
    allListsOk(Xs,[]),!.

test(namespace_list5) :-
    findall(X, namespace_list(file, X), Xs),
    allListsOk(Xs,[568585]),!.

test(namespace_list6) :-
    findall(X, namespace_list(module, X), Xs),
    allListsOk(Xs,[]),!.

test(namespace_list7) :-
    namespace_list(mediawiki_conversation, []),!.

test(namespace_list8) :-
    namespace_list(template, [858485]),!.

test(namespace_list9) :-
    namespace_list(dd, []),!.

/*
 * **********************************************
 * sub tests
 * **********************************************
 */

test(sub1) :-
    findall(X, sub(X, [1, 2, 3]), Xs),
    allElementsIsOf(Xs,[[1, 2, 3],[1, 2],[1, 3],[2, 3],[1],[2],[3],[]]),
    allElementsIsOf([[1, 2, 3],[1, 2],[1, 3],[2, 3],[1],[2],[3],[]],Xs),!.

test(sub2) :-
    findall(X, sub(X, [1, 2]), Xs),
    allElementsIsOf(Xs,[[1, 2],[1],[2],[]]),
    allElementsIsOf([[1, 2],[1],[2],[]],Xs),!.

test(sub3) :-
        findall(X, sub(X, [1]), Xs),
        allElementsIsOf(Xs,[[1],[]]),
        allElementsIsOf([[1],[]],Xs),!.

test(sub4) :-
        findall(X, sub(X, []), Xs),
        allElementsIsOf(Xs,[[1],[]]),
        allElementsIsOf([[]],Xs),!.

test(sub5) :-
        findall(X, sub(X, [1, 1]), Xs),
        allElementsIsOf(Xs,[[1],[1],[1,1],[]]),
        allElementsIsOf([[1],[1],[1,1],[]],Xs),!.

test(sub6) :-
    sub([1, 2, 3], [1, 2, 3]),!.

test(sub7,[fail]) :-
        sub([1, 1], [1, 2, 3]),!.

test(sub8) :-
        sub([1, 2], [1, 2, 3]),!.

:- end_tests(prologPartAss5).

?-run_tests.

