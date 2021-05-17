% Cool White Paper class
%
% This class has been downloaded from:
% https://github.com/nitrogl/snippets/LaTeX/
%
% Author:
% Roberto Metere <roberto@metere.it>
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%

% ______________
% Identification
% 
\ProvidesClass{cool-white-paper}[2021/05/07 v1.0 Cool White Paper Class]
\NeedsTeXFormat{LaTeX2e}

% _____________
% Class options
% 
\usepackage[table]{xcolor}

\definecolor{palette15}{HTML}{312f38}%
\definecolor{palette25}{HTML}{205066}%
\definecolor{palette35}{HTML}{3a8aa6}%
\definecolor{palette45}{HTML}{53c5d5}%
\definecolor{palette55}{HTML}{d3d39f}%

% Violet
\DeclareOption{violet}{%
  \definecolor{palette15}{HTML}{312f38}%
  \definecolor{palette25}{HTML}{545066}%
  \definecolor{palette35}{HTML}{9a8aa6}%
  \definecolor{palette45}{HTML}{e3c5d5}%
  \definecolor{palette55}{HTML}{e4d39f}%
}

% Mountain
\DeclareOption{mountain}{%
  \definecolor{palette15}{HTML}{0f211a}%
  \definecolor{palette25}{HTML}{666b3a}%
  \definecolor{palette35}{HTML}{adab76}%
  \definecolor{palette45}{HTML}{aca69f}%
  \definecolor{palette55}{HTML}{dcdfe4}%
}

% Desert
\DeclareOption{desert}{%
  \definecolor{palette15}{HTML}{312f38}%
  \definecolor{palette25}{HTML}{8a2016}%
  \definecolor{palette35}{HTML}{c05033}%
  \definecolor{palette45}{HTML}{e08033}%
  \definecolor{palette55}{HTML}{f4d39f}%
}

% 
\DeclareOption{sky}{%
  \definecolor{palette15}{HTML}{312f38}%
  \definecolor{palette25}{HTML}{205066}%
  \definecolor{palette35}{HTML}{3a8aa6}%
  \definecolor{palette45}{HTML}{53c5d5}%
  \definecolor{palette55}{HTML}{d3d39f}%
}


% Inherit options of extreport
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extreport}}
\ProcessOptions\relax
\LoadClass{extreport}

\usepackage[sfdefault]{FiraSans} % Easy to read and versatile font
\usepackage{titlesec}
\usepackage{tocloft}
\usepackage[export]{adjustbox}
\usepackage{lipsum}
\usepackage{xifthen}
\usepackage{geometry}
\usepackage{varwidth}
\usepackage{setspace}
\usepackage{tabularx}
\usepackage{longtable}
\usepackage[document]{ragged2e}
\usepackage{lastpage}
\usepackage{arydshln}
\usepackage{pdfpages}
\usepackage{fancyhdr}
\usepackage{hyphenat}
\usepackage[most]{tcolorbox}
\usepackage{caption}
\captionsetup[figure]{width=0.9\textwidth,font=smaller,labelfont=smaller}
\captionsetup[table]{width=0.9\textwidth,font=smaller,labelfont=smaller}
\usetikzlibrary{backgrounds}

% ______________________
% Set title and subtitle
\makeatletter
\newcommand*\insertTitle{}
\newcommand*\setTitle[1]{\def\insertTitle{#1}}
\newcommand*\insertSubtitle{}
\newcommand*\setSubtitle[1]{\def\insertSubtitle{#1}}
\makeatother

\colorlet{text}{palette15}
\colorlet{titles}{palette25}
\colorlet{subtitles}{palette35}
\colorlet{subsubtitles}{palette45}


\usepackage{glossaries}

% Beautify
\widowpenalty10000
\clubpenalty10000

% Do not reset footnote counting at each chapter
\counterwithout*{footnote}{chapter}

% _______________
% Fancy quotation
\usepackage{framed}

% conditional for xetex or luatex [borrowed from somewhere in the Internet]
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi
%
\ifxetexorluatex%
  \usepackage{fontspec}
  \usepackage{libertine} % or use \setmainfont to choose any font on your system
  \newfontfamily\quotefont[Ligatures=TeX]{Linux Libertine O} % selects Libertine as the quote font
\else
  \usepackage[utf8]{inputenc}
  \usepackage[T1]{fontenc}
  \usepackage{libertine} % or any other font package
  \newcommand*\quotefont{\fontfamily{LinuxLibertineT-LF}} % selects Libertine as the quote font
\fi

\newcommand*\quotesize{60} % if quote size changes, need a way to make shifts relative
% Make commands for the quotes
\newcommand*{\openquote}
   {\tikz[remember picture,overlay,xshift=-4ex,yshift=-2.5ex]
   \node (OQ) {\quotefont\fontsize{\quotesize}{\quotesize}\selectfont``};\kern0pt}

\newcommand*{\closequote}[1]
  {\tikz[remember picture,overlay,xshift=4ex,yshift={#1}]
   \node (CQ) {\quotefont\fontsize{\quotesize}{\quotesize}\selectfont''};}

% select a colour for the shading
\colorlet{shadecolor}{white!98!black}

\newcommand*\shadedauthorformat{\emph} % define format for the author argument

% Now a command to allow left, right and centre alignment of the author
\newcommand*\authoralign[1]{%
  \if#1l
    \def\authorfill{}\def\quotefill{\hfill}
  \else
    \if#1r
      \def\authorfill{\hfill}\def\quotefill{}
    \else
      \if#1c
        \gdef\authorfill{\hfill}\def\quotefill{\hfill}
      \else\typeout{Invalid option}
      \fi
    \fi
  \fi}
% wrap everything in its own environment which takes one argument (author) and one optional argument
% specifying the alignment [l, r or c]
%
\newenvironment{shadequote}[2][r]%
{\authoralign{#1}
\ifblank{#2}
   {\def\shadequoteauthor{}\def\yshift{-2ex}\def\quotefill{\hfill}}
   {\def\shadequoteauthor{\par\authorfill\shadedauthorformat{#2}}\def\yshift{2ex}}
\begin{snugshade}\begin{quote}\openquote}
{\shadequoteauthor\quotefill\closequote{\yshift}\end{quote}\end{snugshade}}

% The above uses a very nice font for serif, very bad for ttfamily
\renewcommand{\ttdefault}{lmtt}

% _____
% Notes
\newcommand{\sidenote}[1]{\todo[size=\scriptsize,color=black!20!blue!10!white,bordercolor=black!20]{#1}}
\newcommand{\sn}[2][]{{\ifthenelse{\isempty{#1}}{\sidenote{#2}}{\sidenote{{\bf #1:} #2}}}}
\newcommand{\csn}[3][]{{\setulcolor{red}\ul{#3}}{\ifthenelse{\isempty{#1}}{\sidenote{#2}}{\sidenote{{\bf #1:} #2}}}}

% ____
% Misc
\newcommand{\parspace}{\vskip 0.5em}
\newcommand{\hr}{\hbox to\headwidth{\color{palette55}\leaders\hrule height \headrulewidth\hfill}}
\newcommand{\uld}[1]{\parbox[b][-1pt][l]{0pt}{\color{palette55}\leavevmode\makebox[\widthof{#1\,}]{\xleaders\hbox{.}\hfill\kern0pt}}#1}
\newcommand{\well}[2][]{\bgroup\small\noindent%
\renewcommand{\arraystretch}{1.5}
\begin{tabular*}{\textwidth}{m{0.00001\textwidth}m{0.013\textwidth}m{0.87\textwidth}p{0.001\textwidth}}%
& \cellcolor{palette45}\color{white}\centering\rotatebox{90}{\textsc{\bfseries #1}}%
& {\color{gray}#2}%
& %\cellcolor{palette55}
\end{tabular*}%
\egroup}

% ____
% Page
\geometry{top=3cm,right=2cm,bottom=3cm,left=2cm}
\setlength{\parskip}{0.6em}
\titlespacing\subsubsection{0pt}{1em}{-0.1em}

% _________
% New lines
\tolerance = 5000
\hbadness = \tolerance
\pretolerance = 2000

% ______
% Titles
% \titleformat{\section}
%   {\normalfont\Large\bfseries\color{sectitlecolor}}{\llap{\makebox[3em][l]{\colorbox{sectboxcolor}{\textcolor{secnumcolor}{\thesection}}}}}{0em}{}
\makeatletter
% \patchcmd{<cmd>}{<search>}{<replace>}{<success>}{<failure>}
\patchcmd{\@makechapterhead}{#1}{\hyphenpenalty=10000 #1}{}{}% Patch \chapter
\patchcmd{\@makeschapterhead}{#1}{\hyphenpenalty=10000 #1}{}{}% Patch \chapter*
\makeatother
\newcommand{\chsep}{\hspace{20pt}}
\newcommand{\chrule}{{\color{palette55}\vrule width 3pt}}
\titleformat{\chapter}[hang]{\color{titles}\huge\bfseries}{\thechapter\chsep\chrule\chsep}{0pt}{}
\titleformat{\section}[hang]{\color{subtitles}\Large\bfseries}{\thesection\chsep}{0pt}{}
\titleformat{\subsection}[hang]{\color{subtitles}\large\bfseries}{\thesubsection\chsep}{0pt}{}
\titleformat{\subsubsection}[hang]{\color{subsubtitles}\normalsize\bfseries}{}{0pt}{}
\newcommand{\tnl}{\\\hspace{2.1cm}}
\newcommand{\stnl}{\\\hspace{1.5cm}}

% ___
% ToC
\setlength{\cftsecindent}{0pt}% Remove indent for \section
\setlength{\cftsubsecindent}{0pt}% Remove indent for \subsection
% \setlength{\cftsubsubsecindent}{0pt}% Remove indent for \subsubsection
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % for chapters
\renewcommand{\cfttoctitlefont}{\Huge\bfseries\color{titles}} % tocloft
\renewcommand{\cftloftitlefont}{\Huge\bfseries\color{titles}} % tocloft
\renewcommand{\cftchapfont}{\bfseries\color{titles}} % tocloft
\renewcommand{\cftsecfont}{\color{titles}} % tocloft
\renewcommand{\cftsubsecfont}{\color{titles}} % tocloft
\renewcommand{\cftchappagefont}{\color{titles}} % tocloft

% _________________
% Header and footer
\renewcommand{\headrule}{\vspace{-.5em}\hr}
% \renewcommand{\footrule}{\hbox to\headwidth{\color{palette55}\leaders\hrule height \headrulewidth\hfill}}
\newcommand{\pagecounter}{\vspace{0.1cm}\ooalign{%
  \color{text} % background box color
  \rule{3cm}{1.9cm} % background box raise, width, height
  \cr
  \hfil\strut\raisebox{0.6cm}{% number raise
  \sffamily\bfseries\color{palette55}% number color
  \Huge% number fontsize
  \thepage
  \kern0.1em% distance number-bar
  \rule{1pt}{1.4ex}% bar size
  \kern0.15em% distance bar-totalnumber
  \Large% totalnumber fontsize
  \pageref*{LastPage}}\hfil
}}
\fancypagestyle{coolpagestyle}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{2pt}
  \fancyhead[L,R]{}
  \fancyhead[C,C]{\color{titles}\bfseries\textsc{\leftmark}}
  \fancyhead[R,L]{}
  \renewcommand{\footrulewidth}{0pt}
  \fancyfoot[R,L]{\vspace{1.5em}
      \begin{varwidth}{0.65\paperwidth}
        \color{titles}\sc{\insertTitle}
      \end{varwidth}}
  \fancyfoot[C,C]{}
  \fancyfoot[R]{\pagecounter}
}
\fancypagestyle{plain}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{2pt}
  \fancyhead[L,R]{}
  \fancyhead[C,C]{}
  \fancyhead[R,L]{}
  \renewcommand{\footrulewidth}{0pt}
  \fancyfoot[R,L]{\vspace{1.5em}
      \begin{varwidth}{0.65\paperwidth}
        \color{titles}\sc{\insertTitle}
      \end{varwidth}}
  \fancyfoot[C,C]{}
  \fancyfoot[R]{\pagecounter}
}

% ______
% Tables
\colorlet{evenrows}{white}
\colorlet{oddrows}{palette55!20!white}
\newcommand{\logot}[3][\textwith]{\begin{minipage}{#1}\centering\includegraphics[width=\textwidth,max height=#2]{#3}\end{minipage}}
\newcommand{\rotation}{60}
\newcommand{\thr}[2][\rotation]{\rotatebox{#1}{\bfseries\color{titles}#2}}
\newcommand{\thh}[1]{\bfseries\color{titles}#1}
\newcommand{\thc}[2][\centering]{\cellcolor{oddrows}#1#2}
\newcommand{\continuetable}[1]{\multicolumn{#1}{r}{\cellcolor{white}\color{subtitles}{\small \em continued on next page}}}
\newcommand{\continuedtable}[1]{\multicolumn{#1}{r}{\cellcolor{white}\color{subtitles}{\small \em continued from previous page}}}

% Table results
\newcommand{\rna}{\sim}
\newcommand{\rve}{\checkmark}
\newcommand{\rfa}{\cdot}
\newcommand{\run}{?}
\newcommand{\rb}{\footnotesize\circletfill}
\newcommand{\rh}{\footnotesize\circletfillhb}
\newcommand{\icon}[2][inline]{%
\ifthenelse{\equal{#1}{inline}}{% THEN
\hspace{1.4em}%
\begin{tikzpicture}[remember picture,overlay]
  \node[] at (-0.9em,0.4em) { \includegraphics[width=1.3em]{#2} };
\end{tikzpicture}%
}{% ELSE
\begin{tikzpicture}[remember picture,overlay]
  \node[] at (#1) { \includegraphics[width=1.3em]{#2} };
\end{tikzpicture}%
}}

\newtcbox{\pill}[1][palette55]{nobeforeafter,tcbox raise base,arc=0.6em,outer arc=0.6em,top=0.1em,bottom=0.1em,left=0.2em,right=0.2em,leftrule=0mm,rightrule=0mm,toprule=0mm,bottomrule=0mm,boxsep=0.1em,colback=#1,colframe=#1,coltext=white,fontupper=\bfseries}
\newcommand{\refpill}[2][palette55]{\pill[#1]{§\ref{#2}}}

% ________
% Glossary
\newcommand{\acr}[1]{\hypertarget{#1}{#1}}
\newcommand{\gl}[1]{\protect\hyperlink{#1}{\uld{#1}}}

% Acronyms
\newcolumntype{T}{>{\raggedleft\arraybackslash\color{titles}\bfseries}p{0.22\textwidth}} % Title
\newcolumntype{F}{>{\raggedright\arraybackslash\color{text}}p{0.78\textwidth}} % Content

% Definitions
\newcolumntype{U}{>{\raggedleft\arraybackslash\color{titles}\bfseries}p{0.2\textwidth}} % Title
\newcolumntype{G}{>{\raggedright\arraybackslash\color{text}}p{0.8\textwidth}} % Content

% ____________________
% Front and back pages
\newcommand{\frontpage}[3][\today]{
  \color{text}
  \thispagestyle{empty}
  \begin{tikzpicture}[remember picture,overlay]
    \node[] (picture) at (current page.center) { \includegraphics[width=\paperwidth]{#2} };
    \node[] (frontpage) at (current page.center) { \includegraphics[width=\paperwidth]{#3} };
    
    \node[anchor=north west,xshift=3em,yshift=-4em] (names) at (current page.north west) {
      \begin{varwidth}{0.7\paperwidth}
        \setstretch{0.7}
        \color{titles}\Huge\bfseries \nohyphens{\textsc{\insertTitle}}
      \end{varwidth}
    };
    \node[anchor=north west,xshift=3em,yshift=-13em] (names) at (current page.north west) {
      \begin{varwidth}{0.5\paperwidth}
        {\color{subtitles}\Large\bfseries \nohyphens{\textsc{\insertSubtitle}}}
      \end{varwidth}
    };
    
    \node[anchor=north west,minimum height=4cm] (names) at ([xshift=1em,yshift=4.2cm]current page.south west) {
      \begin{tabularx}{0.7\paperwidth}{cccc}
        \institutionLogos
      \end{tabularx}
      };

    \node[anchor=north east] (names) at ([xshift=-1em,yshift=2.4em]current page.south east) { \color{palette55!70!black}\bfseries #1 };
  \end{tikzpicture}
  \pagestyle{coolpagestyle}
  \newpage
}
% _________
% Last page
\newcommand{\lastpage}[1]{
  \newpage
  \thispagestyle{empty}
  \begin{tikzpicture}[remember picture,overlay,background rectangle/.style={fill=palette55!70!white}, show background rectangle]
    \node[] (frontpage) at (current page.center) { \includegraphics[width=\paperwidth]{#1} };
    
    \node[anchor=north west,xshift=3em,yshift=-8em] (names) at (current page.north west) {
      \begin{varwidth}{0.6\paperwidth}
        {\color{titles}\bfseries \nohyphens{\textsc{\authors}}}
      \end{varwidth}
    };
    \node[anchor=north west,xshift=3em,yshift=-13em] (names) at (current page.north west) {
      \begin{varwidth}{0.5\paperwidth}
        {\color{subtitles}\Large\bfseries \nohyphens{\textsc{\insertTitle}}}
      \end{varwidth}
    };
    
    \node[anchor=north west,minimum height=4cm] (names) at ([xshift=1em,yshift=4.2cm]current page.south west) {
      \begin{tabularx}{0.7\paperwidth}{cccc}
        \institutionLogos
      \end{tabularx}
      };

  \end{tikzpicture}
}

% Adding institution logos
\makeatletter
\newcommand*\institutionLogos{}
\newcommand*\addInstitutionLogo[1]{%
  \ifx\institutionLogos\empty
    \def\institutionLogos{\includegraphics[height=1.2cm,valign=b]{#1}}%
  \else
    \g@addto@macro\institutionLogos{& \includegraphics[height=1.2cm,valign=b]{#1}}%
  \fi%
}
\makeatother

% Adding authors' biography
\makeatletter
\newcommand*\plainAuthors{}
\newcommand*\authors{}
\newcommand*\authorBios{}
\newcommand*\addAuthor[2]{%
  \ifthenelse{\isempty{\plainAuthors}}{
    \def\plainAuthors{#1}%
    \def\authors{#1}%
    \def\authorBios{%
    poba%
\begin{minipage}[t]{0.49\textwidth}\subsubsection*{#1}{#2}\end{minipage}%
\begin{minipage}[t]{0.02\textwidth}\strut\end{minipage}
    }%
  }{%
    \g@addto@macro\plainAuthors{ #1}
    \g@addto@macro\authors{\quad #1}
    \g@addto@macro\authorBios{%
\begin{minipage}[t]{0.49\textwidth}\subsubsection*{#1}{#2}\end{minipage}%
\begin{minipage}[t]{0.02\textwidth}\strut\end{minipage}
    }%
  }%
}
\makeatother
