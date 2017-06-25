:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).

:- use_module(form).
:- use_module(queens).

:- http_handler(root(queens), handler_queens, []).
:- http_handler(root(solution), handler_solution, []).
:- http_handler(root(.), http_reply_from_files('pic', []), [prefix]).

% server(+Port) uruchomienie serwera na danym porcie
%
server(Port) :-
	http_server(http_dispatch, [port(Port)]).

handler_queens(_Request) :-
	format('Content-type: text/html~n~n'),
	format('<!DOCTYPE html><html><head><title>Form</title>~n', []),
	format('<meta http-equiv="content-type" content="text/html; charset=UTF-8">~n', []),
	format('</head><body>~n', []),
	build_form([action(action), method(post)],
		   [	h1('Hellow in QPSS!'),
		   	h1('(Queens Problem Solving Site)'),br ,
		   	label(size, 'Size of board:'), input(text, size), br,
			input(submit)]),
			build_row(3,7),
	format('</body></html>~n', []).

handler_solution(Request) :-
	member(method(post), Request), !,
	http_read_data(Request, Data, []),
	reply_html_page(title('Action'),
			[h1('Fields and values'),
			 table([ \header | \data(Data)])
			]).
			
empty_fileds(0,[]) :-
	!.
empty_fields(N,[pictur(empty) | L]) :- 
	N2 is N-1, empty_fields(N2,L).

build_row(N,Size) :-
	N1 is N-1 , 
	N2 is Size - N,
	empty_fields(N1,L1),
	empty_fields(N2,L2),
	build_elements(L1),
	build_element([picture(queen)]),
	build_elements(L2).
	
% DOPISZ REGULY GRAMATYKI METAMORFICZNEJ DO WYGENEROWANIA HTML.

header -->
	html(tr([th('Field'), th('Value')])).

data([]) --> [].
data([Name=Value | Tail]) -->
	html(tr([td(Name), td(Value)])),
	data(Tail).
