% U. Penn proposal class.  Version 0.5, 5/i13/2014
% Original was reimplementation based on penndiss.sty (a local adaptation of suthesis.sty)
% Alexis Dimitriadis 12/28/99 (alexis@ling.upenn.edu)
%
% A sample input file is appended below, after the command \endinput
%
% Use: \documentclass{upenndiss}
% Options: 
%   Most report class options; no additional ones.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upennprop}[2000/5/24 U. Penn Dissertation Class for LaTeX2e]

% The default point size is 12pt, not 10pt.
% Otherwise the mandated margins result in lines that are much too long
% You can specify another size with, e.g., the [11pt] class option.
\def\@sizeopt{12pt}
\DeclareOption{10pt}{\def\@sizeopt{10pt}}
\DeclareOption{11pt}{\def\@sizeopt{11pt}}
 
% Ignore [(no)titlepage] option (should we warn?)
\DeclareOption{titlepage}{\relax}
\DeclareOption{notitlepage}{\relax}
% I used to pass [notitlepage] to the report class, but its effects seem
% to have been voided by the reimplementation of the front matter.
% (Restore if it causes any problems)
%\PassOptionsToClass{notitlepage}{report}

% Pass all other options to the parent class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions 

% Invoke the parent class with appropriate font size (default 12pt).
% Options given to \PassOptionsToClass above are implicitly passed.
\LoadClass[\@sizeopt]{report}
\usepackage[colorlinks=True,
            linkcolor=blue,
            urlcolor=blue,
            citecolor=blue,
            anchorcolor=blue]{hyperref}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%           START OF CUSTOMIZABLE SECTION
%
% Redefining or overriding these settings should allow adaptation of
% this style file to other dissertation specifications.
%

% For letter-size paper: 8.5 in x 11 in
% Latex Origin is 1''/1'', so measurements are relative to this.
% Proposal Margins: 1in inside, outside, top, bottom

%\textwidth=6in
%\oddsidemargin=0.5in \evensidemargin=0.5in
%\topmargin=-0.5in
%\textheight=9in  % 9in must include page numbers
%\advance\textheight by -1\footskip \relax
\usepackage[top=0.5in, bottom=0.5in, left=0.5in, right=0.5in]{geometry}

\usepackage{setspace}
%\doublespacing

%%%% Content of text labels; can be overridden from document preamble  %%%%

% Position titles given with the signatures on the title page
\def\supervisorname{Supervisor of Dissertation}
\def\chairname{Graduate Group Chair}

% Select one in your document: \copyrighttrue or \copyrightfalse
% Controls whether to create a copyright page.
\newif\ifcopyright \copyrighttrue 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         Definitions of front matter contents

% Front matter elements are defined in the preamble and assembled in
% the proper order by \FrontMatter.

% The following commands should be used in the preamble to provide the
% appropriate text or \input commands.  Some are optional; if not sure,
% you can always just try leaving them out. The style will complain if they
% are obligatory!

\def\department#1{\gdef\@department{#1}}
\def\school#1{\gdef\@school{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}} % Separate joint supervisors with \and
\let\superviser=\supervisor 
\let\advisor=\supervisor
\let\supervisors=\supervisor
\let\supervisers=\supervisor

\def\copyrightyear#1{\gdef\@copyrightyear{#1}}  
\copyrightyear{\number\year}         % may be overridden in the document

\def\abstract#1{\def\@abstract{#1}}
\def\aims#1{\def\@aims{#1}}

% Contrive to \include a file without starting a new page (by temporarily
% disabling \clearpage).  A new page is still begun at the end of the include.
\def\@includehere#1{\bgroup\let\clearpage=\egroup\include{#1}}
\def\abstractfile#1{\abstract{\@includehere{#1}}}
\def\aimsfile#1{\aims{\@includehere{#1}}}

% The format and order of the preliminary pages.
% Optional pages are only created if requested.
% List of Figures and List of Tables pages are only created if there are
% figures or tables. 
% Dedication, acknowledgements and abstract macros are cleared after use
% to save space.
% Syntax: 
%    \FrontMatter 
% or 
%    \FrontMatter* 
%    <additional preliminary sections, e.g., \include{Abbreviations}> 
%    \MainMatter
%
\def\FrontMatter{%
  \pagenumbering{roman}\pagestyle{plain}%
  \@titlepage 
  \ifcopyright \@copyrightpage \fi 
  % The abstract and TOC are obligatory
  \@abstractpage \newpage \let\@abstract=\@undefined
  \@aimspage \newpage \let\@aimspage=\@undefined
  \tableofcontents
  \@ifundefined{pd@list@tables} \relax 
      \listoftables 
  \@ifundefined{pd@list@figures} \relax 
      \listoffigures
  \@ifstar{}{\MainMatter}
}


% Start the regularly-numbered part of the dissertation.  Must be given
% explicitly if \FrontMatter* was used.
%
\def\MainMatter{\newpage\pagenumbering{arabic}}


% \@titlepage is modular so that its parts can be redefined as necessary.
% The main macro sets the title and names; \@signatureblock creates the
% signature lines.

\def\@titlepage{%
  \thispagestyle{empty}\enlargethispage{\the\footskip}%
  \null\vskip.1in%
  \begin{center}
      {\setstretch{1.5} \textsc{\large{\@title}}\par }%
      \vskip.4in
      \@author
      \vskip .4in
      A DISSERTATION PROPOSAL in \\[.2in]
      \@department, \@school \\[.2in]
      \@copyrightyear
      \bgroup \parindent=0pt \par \@signatureblock \egroup
  \end{center}

  \newpage}
% (There is no point to making ``University of Pennsylvania'' a macro: other
% schools are sure to have a different format for the title page anyway).


% Format the signatures at the bottom of the title page.
% If the default signature layout is inappropriate, just override it:
% Redefine \@signatureblock and lay out the names by hand, either using
% \@widesig and/or \@narrowsig, or just drawing lines in your favorite way.
% Example:
\def\@signatureblock{\vskip 0pt plus 0.5 fill
    \@mainsig{\supervisorname}{Brian Litt \vskip 0.1in Professor of \\ Neurology \& Bioengineering}
    \@mainsig{\chairname}{Daniel A. Hammer \vskip 0.1in Alfred G. and Meta A. Ennis Professor of \\ Bioengineering \& Chemical and Biomolecular Engineering}
    \@narrowsig{Gershon Buchsbaum, Professor of Bioengineering \\
                Danielle S. Bassett, Skirkanich Assistant Professor of Innovation of Bioengineering \& Electrical and Systems Engineering \\
                Timothy H. Lucas, Assistant Professor of Neurosurgery, Perelman School of Medicine \\
                James C. Gee, Associate Professor of Radiologic Science, Perelman School of Medicine}
    \@contactsig{Supervisor Contact}{Brian Litt, M.D. \\ 301 Hayden Hall, University of Pennsylvania \\ 3320 Smith Walk, Philadelphia, PA 19104 \\ \href{mailto:littb@mail.med.upenn.edu}{littb@mail.med.upenn.edu}}
    \@contactsig{Personal Contact}{Ankit Khambhati \\ 301 Hayden Hall, University of Pennsylvania \\ 3320 Smith Walk, Philadelphia, PA 19104 \\ \href{mailto:ankk@seas.upenn.edu}{ankk@seas.upenn.edu}}
}

\def\@narrowsig#1{\parbox[t]{\textwidth}{\parindent=0pt \vskip 0.25in
    \flushleft
    \par \vskip .1in \footnotesize{\underline{Dissertation Committee}}
    \par \vskip .1in \footnotesize{#1}}\hfill}

\def\@contactsig#1#2{\parbox[t]{7cm}{\parindent=0pt \vskip 0.25in
    \flushleft
    \par \vskip .1in \footnotesize{\underline{#1}}
    \par \vskip .1in \footnotesize{#2}}\hfill}

\def\@mainsig#1#2{\parbox[t][4cm][t]{7cm}{\parindent=0pt \vskip 0.25in
  \flushright
  \par \vskip \baselineskip \hrule
  \par \vskip .1in \footnotesize{#2}
  \vfill
  \par \vskip .1in {#1}}\hfill}


% Do a sig line for each name in the list #1, with title #2
% The output is formatted in the format Name, Title (you can change it here)
% Example: \@siglist{\@committee}{Committee Member}
%\def\@siglist#1#2{\def\@aloopuse##1{\@eachsig{##1, \penalty-1 #2}}\@alooprun#1}

% Alternative format: put title below the name, with no comma
\def\@siglist#1#2{\def\@aloopuse##1{\@eachsig{##1\\ #2}}\@alooprun#1}

% The format of the copyright page
\def\@copyrightpage{%
  \thispagestyle{empty}%
  \null\vfill
  \begin{center} % -- all this fucked around w/ by KG
    \MakeUppercase{\@title} \\[0.3in]
    COPYRIGHT \\[0.3in]
    \@copyrightyear \\[0.3in]
    \@author
  \end{center}
  \vfill\newpage
}

% The format of the abstract heading
\def\@abstractpage{\addcontentsline{toc}{chapter}{Abstract}%
  \begin{center}
      \large{\textbf{ABSTRACT}} \vskip 0.4in
    \MakeUppercase{\@title} \vskip 0.4in
    \@author \\
    \@supervisor
  \end{center}
  \vskip 10pt
  \par\noindent \@abstract }

% The format of the specific aims heading
\def\@aimspage{\addcontentsline{toc}{chapter}{Specific Aims}%
  \begin{center}
      \large{\textbf{SPECIFIC AIMS}}
  \end{center}
  \vskip 10pt
  \par\noindent \@aims }


% The TOC Formatting
\renewcommand*{\contentsname}{Table of Contents}

% List of figs and tables formatting
\renewcommand*{\listfigurename}{List of figures}
\renewcommand*{\listtablename}{List of tables}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                  END OF CUSTOMIZABLE SECTION
%
%  LaTeX magic beyond this point-- Use extreme care if you have to
%  make changes!
%

% Looping macros for name lists.
% The elements of \arglist must be separated by <space>\and
% Syntax: \@alooprun\arglist
%
\def\@alooprun#1{\ifx #1\undefined \else 
  \bgroup \let\@aloopend=\egroup 
  \def\and{\@ifnextchar\@aloopend \relax \@loopa}%
  \def\@loopa##1 \and{\@aloopuse{##1}\and}%
  \expandafter\and #1 \and\@aloopend \fi}

% Define \@aloopuse to do whatever we want with each partial argument
% Example: \def\@aloopuse#1{\@eachsig{#1, Committee Member}}

% Count the names in the \and-separated list #2, and ADD the result into 
% the counter #1
% Syntax: \@count@names\counter\list
\def\@count@names#1#2{%
  \def\@aloopuse##1{\global\advance#1 by 1\relax}% count and discard argument
  \@alooprun#2}


% Make a note of whether there were figures and tables
\let\up@svd@caption=\caption
\def\caption
  {\expandafter\gdef\csname pd@have\@captype s\endcsname{1} \up@svd@caption}

% The following code appends; I need to prepend or the implicit argument of
% \caption (the name of the figure or table) is lost!
%% (no \protect needed when defining directly)
%\g@addto@macro\caption
%  {\protect\expandafter\gdef\csname pd@have\@captype s\endcsname{1}}

% Save a *different* flag in .aux (so it can turn off if the tables go away).
\AtEndDocument{
  \@ifundefined{pd@havetables} \relax
     {\immediate\write\@mainaux{\string\gdef\string\pd@list@tables{1}}}
  \@ifundefined{pd@havefigures} \relax
     {\immediate\write\@mainaux{\string\gdef\string\pd@list@figures{1}}}}


% Start a section in the front matter, adding it to the TOC
% Syntax: \PreSection[TOC title]{Actual title}
%
\def\PreSection{\chapter*}
% (This is trivial thanks to the following modification to default LaTeX
% behavior: 


% Modify handler for \chapter* so that the title is automatically added to the
% toc.  Lines obviated by this in earlier code are commented out with %c.
% Let me know if this feature causes problems; it can be removed if
% necessary.

% This also extends the \chapter[TOCtitle]{actual title} syntax to \chapter*.
%
\let\orig@@schapter=\@schapter
% If no optional argument in [ ] follows, \@dblarg copies the obligatory one
\def\@schapter{\@dblarg{\up@schapter}}
\def\up@schapter[#1]#2{\addcontentsline{toc}{chapter}{#1}\orig@@schapter{#2}}

% If you need to restore the default behavior of \chapter*, just say:
%     \let\@schapter=\orig@@schapter
% You should almost certainly not do this until after the front matter!


\endinput
