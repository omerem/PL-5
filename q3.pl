
/*
 * **********************************************
 * aux predicates (see ex5-aux.pl documentation)
 * **********************************************
 */

:- module('q3',
	[page_in_category/2,
	splitter_category/1,
	namespace_list/2]).
:- use_module('ex5-aux').
/*
 * **********************************************
 * Question 3:
 *
 * A relational database for Wikipedia management.
 *
 * The database contains the tables: page, namespaces,
 * category and categorylinks.
 * **********************************************
 */

% Signature: page_in_category(PageName, CategoryId)/2
% Purpose: Relation between a page name and a category id,
%          so that the page is included in the category.
%          and the category is not hidden.
% Examples:
% ?- page_in_category(cnn, X).
% X = 786983;
% X = 786983
%
% ?- page_in_category(X, 564677).
% X = ocpc;
% X = nbc.
%
% ?- page_in_category(metropolitan, X).
% false.
%
page_in_category(PName, CatId):-
    page(Page_Id, _, PName, _),
    categorylinks(Page_Id, Cat_name),
    category(CatId, Cat_name, false).




% Signature: splitter_category(CategoryId)/1
% Purpose: A category that has at least two pages.
%          Multiple right answers may be given.
%
% Examples:
% ?- splitter_category(689969).
% true.
%
% ?- splitter_category(564677).
% true.
%
% ?- splitter_category(858585).
% false.
%
splitter_category(CatId) :-

    category(CatId, Cat_Title, _),
    categorylinks(Page_Number1, Cat_Title),
    categorylinks(Page_Number2, Cat_Title),
    dif(Page_Number1, Page_Number2).





% Signature: namespace_list(NamespaceName, PageList)/2
% Purpose: PageList includes all the pages in namespace NamespaceName.
%          The order of list elements is irrelevant.
% Examples:
% ?- namespace_list(article, X).
% X = [558585, 689695, 858585].
%
%

namespace_list(NS,[]):-
    not(namespaces(_,NS)).
namespace_list(Name, PageList) :-
    not_twice(PageList),
    namespaces(Ns_number, Name),
    list_in_namespace(Ns_number, PageList),
    not(not_all_namespace_in_list(Ns_number, PageList)).

not_twice([]).
not_twice([N|R]):-
    not_in(N,R).
not_in(_,[]).
not_in(N1,[N2|_]):-
    dif(N1,N2).

list_in_namespace(_, []).
list_in_namespace(Ns_number, [Page_id|Rest]):-
    page(Page_id, Ns_number, _, _),
    list_in_namespace(Ns_number, Rest).

not_all_namespace_in_list(Ns_number, List):-
    page(Page_id, Ns_number, _, _),
    not_member(Page_id, List).

