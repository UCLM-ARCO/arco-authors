% -*- mode:latex -*-
%
% author: David Villa Alises <David.Villa@gmail.com>
%
% LaTeX2ε for class and package writers:
%   http://www.latex-project.org/guides/clsguide.pdf
%
% Initial template taken from:
%   http://stackoverflow.com/questions/581916/how-do-you-extend-article-document-class-in-latex

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cedv-book}[2015/12/03 class for books]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\PassOptionsToClass{a4paper, twoside}{book}
\ProcessOptions\relax
\LoadClass{book}


\RequirePackage{arco-fonts}

\RequirePackage{arco-basics}
\RequirePackage{arco-acronym}
\RequirePackage{arco-hyper}
\RequirePackage{arco-appendix}
\RequirePackage{arco-bib}

\RequirePackage{arco-color}
\RequirePackage{arco-semantic}
\RequirePackage{arco-admonition}
\RequirePackage{arco-listings}

\RequirePackage{datetime}

% FIXME: quitar del estilo (específico de documento)
\RequirePackage{tikz-uml}

%%-- class config --

\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{%
  \renewcommand{\@subtitle}{#1}}

\newcommand{\@chapterauthors}{}
\newcommand{\chapterauthors}[1]{%
  \renewcommand{\@chapterauthors}{#1}}

\RequirePackage[
  paperwidth=159.175mm,
  paperheight=240.35mm,
  left=19.8mm,right=14.4mm,
  top=21mm, bottom=21mm,
  marginparwidth=1cm, marginparsep=1cm]{geometry}

\RequirePackage[sf,bf,compact,clearempty,pagestyles]{titlesec}  % [rigidchapters]
\RequirePackage[strict]{changepage}

\setlist{
  topsep=1pt,
  itemsep=3pt}

\RequirePackage[scaled=.73]{beramono}

\def\line#1{{\bfseries línea\,#1}}
\def\lines#1{{\bfseries líneas~#1}}

\captionsetup{margin=10pt}
\setcounter{secnumdepth}{3}


%%-- TOC style --

\RequirePackage[dotinlabels]{titletoc}
\contentsmargin{-0.5em}

\titlecontents{chapter}
              [1.5em]
              {\vspace*{3mm}}
              {\contentslabel{1.5em}\bfseries}
              {}
              {\titlerule*[1pc]{.}\contentspage}

\titlecontents{section}
              [4.4em] % ie, 1.5em (chapter) + 2.3em
              {}
              {\contentslabel{2.7em}}
              {\hspace*{-2.3em}}
              {\titlerule*[1pc]{.}\contentspage}

\titlecontents{subsection}
              [7.5em]
              {} % note that 3.8 = 1.5 + 2.3
              {\contentslabel{3em}}
              {}
              {\titlerule*[1pc]{.}\contentspage}


%%-- page style --

\newcommand{\chapterformat}[1]{%
  \fontsize{22}{22}\selectfont\sffamily #1%
}

\titleformat{\chapter}[display]
  {\normalfont\large\sffamily}
  {\chaptertitlename\ \thechapter}
  {0mm}
  {\chapterformat}
  [\filleft\normalsize\textnormal\@chapterauthors\chapterauthors{}]

\titlespacing{\chapter}{0cm}{1cm}{1.5cm}

\newcommand{\pagenumber}{\colorbox{black}{\footnotesize\color{white}{\bf\thepage}}}

\renewpagestyle{plain}[\small]{
  \setfoot{}{\pagenumber}{}
}

\newpagestyle{main}[\small]{
  \widenhead*{0pt}{0.7cm}
  \setheadrule{.55pt}%
  \sethead[\pagenumber~~\sc\chaptertitle][][] % even
          {}{}{\sc\sectiontitle~~\pagenumber} % odd
}
\pagestyle{main}


%%-- side content --

% \RequirePackage{picins}
% \RequirePackage{picinpar}
\RequirePackage{wrapfig}

%%%% http://www.nicolashoening.de/?blog&nr=64
%%%% usage: \wrapnote{<title>}{<text>}
% \newcommand{\wrapnote}[2]{
%   \parpic(0.43\textwidth, 0pt)[r]{
%     \parbox[b]{0.4\textwidth}{
%       \vspace*{4pt plus 2pt minus 2pt}
%       {\footnotesize {\bf #1} \\[-5pt]
%         \textcolor{black!50}{\rule{0.4\textwidth}{1.7pt}}
%         \begin{spacing}{0.88}
%           #2
%         \end{spacing}
%       }
%       \vspace{6pt plus 2pt minus 2pt}
%     }
%   }
% }

% \newcommand{\wrapnote2}[2]{
%   \begin{figwindow}[2,r,{
%       \unitlength1cm
%       \begin{picture}(3,1.4)
%         \put(0.7,0.7){\circle*{0.2}} \put(0.7,0.7){\circle{1.2}}
%         \put(0.7,0.7){\vector(0,1){0.6}} \put(2.5,0.7){\circle*{0.5}}
%       \end{picture}
%     },{Kreise und Pfeile}]
%     Was leisten nun diese Macros ...
%     ... sieht hierbei wie folgt aus:
%   \end{figwindow}
% }

\newcommand{\wrapnote}[2]{
\begin{wrapfigure}{r}{0.4\textwidth}
\parbox[b]{0.4\textwidth}{
  \vspace*{-3mm}
   {\footnotesize {\bf #1} \\[-5pt]
     \textcolor{black!50}{\rule{0.4\textwidth}{1.7pt}}
     \begin{spacing}{0.88}
       #2
     \end{spacing}
   }
  \vspace*{-1mm}
}
\end{wrapfigure}
}



% \newcommand{\wrapimage}[3]{
% \begin{wrapfigure}{o}{.33\textwidth}
%   \vspace*{-7pt}
%   \begin{center}
%     \includegraphics[width=.28\textwidth]{#1}
%   \end{center}
%   \vspace{-15pt}
%   \caption{#3\label{#2}}
%   \vspace*{-7pt}
% \end{wrapfigure}
% }

\newcommand{\wrapimage}[3]{}


%-- margin notes --
% \newcommand{\sidebar}[2]{
%   \marginpar{
%     \vspace*{0.6cm}
%     {\large \bfseries #1} \\[1.2mm]
%     \fontsize{7.5}{7} \selectfont #2
%   }
% }



%%-- special pages --

\renewcommand\maketitle{%
  \begin{titlepage}
    \let\footnotesize\small%
    \let\footnoterule\relax%
    \let \footnote \thanks%
    \null\pagestyle{empty}
    \titlepagecontent
    \vfil\null
  \end{titlepage}%

  \setcounter{footnote}{0}%

  \global\let\maketitle\relax

  \global\let\@thanks\@empty
  \global\let\thanks\relax

  \global\let\@author\@empty
  \global\let\author\relax

  \global\let\@date\@empty
  \global\let\date\relax

  \global\let\@title\@empty
  \global\let\title\relax

  \global\let\and\relax

}

\newcommand{\titlepagecontent}{%
  \begin{center}
    \vspace*{\stretch{1}}

    \begin{huge}\textbf{\@title}\end{huge}\\[0.4cm]
    \begin{Large}\textit{\textbf{\@subtitle}}\end{Large}\\[0.9cm]

    \vspace*{\stretch{1}}

    \includegraphics[width=.2\textwidth]{/usr/share/arco/figures/uclm_shield.jpg}

    {\bf Universidad de Castilla-La Mancha}\par
    Escuela Superior de Informática\\de Ciudad Real

    \vspace*{\stretch{.4}}

    \begin{large}\textbf{\@author}\end{large}\\

    \vspace*{\stretch{1}}
    {\small\@date}
  \end{center}

  \newpage

  \mbox{}
  \vfill

  \noindent
    Escuela Superior de Informática\\[0.3cm]
    \begin{tabular}{ll}
      {\it e-mail} & {\tt esi@uclm.es} \\[0.1cm]
      {\it Teléfono} & {\tt 926 29 53 00} \\[0.1cm]
      {\it Web} & {\tt http://www.esi.uclm.es}\\[0.1cm]
    \end{tabular}

    \vspace{0.5cm}

    \begin{singlespace}
    \begin{small}
      \noindent
      \copyright~ Los autores del documento. Se permite la copia,
      distribución y/o modificación de este documento bajo los
      términos de la licencia de documentación libre GNU, versión 1.1
      o cualquier versión posterior publicada por la {\em Free
        Software Foundation}, sin secciones invariantes. Puede
      consultar esta licencia en http://www.gnu.org.
    \end{small}
  \end{singlespace}
}

\endinput
