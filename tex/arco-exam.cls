% -*- mode:latex -*-
%
% author: David Villa Alises <David.Villa@gmail.com>
%
% LaTeX2ε for class and package writers:
%   http://www.latex-project.org/guides/clsguide.pdf
%
% Initial template taken from:
%   http://stackoverflow.com/questions/581916/how-do-you-extend-article-document-class-in-latex


\RequirePackage{arco-internal}

%% -- Variables de la clase ------------------------------------
\gdef\@arcoTopic{\texcmd{arcoTopic}}
\def\arcoTopic#1{\gdef\@arcoTopic{#1}}
\gdef\@arcoExamDesc{\texcmd{arcoExamDesc}}
\def\arcoExamDesc#1{\gdef\@arcoExamDesc{#1}}
\gdef\@arcoExamDate{\texcmd{arcoExamDate}}
\def\arcoExamDate#1{\gdef\@arcoExamDate{#1}}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arco-exam}[2012/03/16 class for student exercises]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\PassOptionsToClass{pdftex,10pt,a4paper,color}{exam}
\ProcessOptions\relax
\LoadClass{exam}

\RequirePackage{times}
\RequirePackage{multicol}
\RequirePackage{tikz}
\RequirePackage{marginnote}

\RequirePackage[margin=1.8cm,top=3cm,bottom=2cm]{geometry}

\RequirePackage{arco-basics}

\RequirePackage[%
  colorlinks=true,
  linkcolor=black,
  citecolor=blue,
  urlcolor=blue]{hyperref}

\RequirePackage[%
% colorgrid,
  texcoord]{eso-pic}

\RequirePackage{amssymb}
\RequirePackage{ifthen}
\RequirePackage{xargs}

\let\headrule\@undefined
\let\footrule\@undefined
\RequirePackage{titlesec}

\RequirePackage{atbeginend}
\AfterBegin{document}{
  \pointname{p}
  \addpoints
  \boxedpoints
}

\BeforeEnd{document}{
  \label{arco:lastpage}
}

\RequirePackage{arco-color}
\RequirePackage{transparent}

\newcommand{\ESIname}{\textbf{\textsf{Escuela Superior de Informática}}}

\newcommand{\UclmWatermark}{%
  \begin{picture}(0,0)
    \put(-55,-820){
      \uclmcolor{\includegraphics[width=1.1\textwidth]{%
          /usr/share/arco/figures/uclm_logo_watermark.pdf}}}
  \end{picture}}


\newcommand{\UCLMhead}[2]{
  \setlength{\unitlength}{1cm}
  \begin{picture}(0,0)
    \put(-1.3,0){\includegraphics[width=4cm]{%
        /usr/share/arco/figures/uclm_logomarca_1.pdf}}
    \put(3,1.6){\makebox(0,0)[l]{\textsf{\textbf{\Large #1}}}}
    \put(3,1.1){\makebox(0,0)[l]{#2}}
    \put(3,0.14){\makebox(0,0)[l]{\textsf{\textbf{\large \textcolor{uclmred}{\ESIname}}}}}
  \end{picture}
}

% localization
\newcommand{\localeScore}{
  \iflanguage{english}{score}{calificación}
}

\newcommand{\localeSurname}{
  \iflanguage{english}{Surname:}{Apellidos:}
}

\newcommand{\localeFirstname}{
  \iflanguage{english}{Firstname:}{Nombre:}
}

\newcommand{\localeGroup}{
  \iflanguage{english}{Group:}{Grupo:}
}


\newcommand{\qualificationBox}{
  \setlength{\unitlength}{1cm}
  \begin{picture}(0,0)
    \put(10,1.2){
      \makebox(0,0)[r]{%
        \parbox{0.7\textwidth}{
          \fcolorbox{gray50}{white}{%
            \textcolor{gray50}{\hspace{.5cm}\localeScore}
            \rule{0cm}{2cm}
            \rule{0.3cm}{0cm}
          }}}
    }
  \end{picture}
}

\newpagestyle{firstpage}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\@arcoExamDesc}} %
          {\UclmWatermark} %
          {\qualificationBox}
  \setfoot{\@arcoExamDate}{}{\thepage{}/\numpages}
}

\newpagestyle{main}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\@arcoExamDesc}} %
          {\UclmWatermark} %
          {}
  \setfoot{\@arcoExamDate}{}{\thepage{}/\numpages}
}

\pagestyle{main}
\thispagestyle{firstpage}

\newcommand{\arcoExamAdvice}[1]{
  \null
  \begin{center}
    \parbox{.92\textwidth}{\emph{\noindent
        #1
      }}
  \end{center}
  \medskip
}

\usepackage{calc}

% \newlength{\remaining}
% \newcommand{\titleline}[1]{%
%   \setlength{\remaining}{(\textwidth-\widthof{\textsc{#1}})/2}
%   \noindent\underline{\hspace*{\remaining}#1\hspace*{\remaining}}\par}

\newlength{\remaining}
\newcommand{\undertitleline}[1]{%
% \setlength{\remaining}{(\textwidth-\widthof{\textsc{#1}})/2}
  \setlength{\remaining}{0.15\textwidth}
  \noindent\underline{\hspace*{\remaining}#1\hspace*{\remaining}}}

\newcommand\atmargin[1]{%
\strut\vadjust{\kern-\dp\strutbox\llap{\smash{\parbox[t]{\marginparwidth}{\raggedleft#1}}\kern\marginparsep}}}


\newcommand*\squared[1]{
  \atmargin{
  \tikz[baseline=(char.base)]{
            \node[shape=rectangle,fill,inner sep=2pt] (char)
            {\sffamily\bfseries\textcolor{white}{#1}};}}
        }

\newcommand{\atside}[1]{
      \fboxsep=2pt%
      \fcolorbox{black}{black}{%
        \textcolor{white}{\sffamily\bfseries #1}%
      }}

\newcommand{\putsideindex}[2] {
  \begin{textblock}{0}(#1,#2)
    \atside{Q\,\arabic{questionIndex}}
  \end{textblock}
}

\newcommand{\arcoExamStudentForm}{
  \noindent
  \localeSurname
  \ifprintanswers
  \undertitleline{\large SOLUCIÓN}
%  \enspace\rule{0.15\textwidth}{.5pt}{\Large SOLUCIÓN}\rule{0.15\textwidth}{.5pt}
  \else
%  \enspace\rule{0.44\textwidth}{.5pt} \enspace
  \underline{\hspace*{0.44\textwidth}}
  \fi
  \enspace \localeFirstname    \underline{\hspace*{0.23\textwidth}}%
  \enspace \localeGroup        \underline{\hspace*{1cm}}
  \mbox{}
  \medskip
}

\newcounter{choicecounter}

\newenvironment{simpleQuestion}[1]{
  \setcounter{choicecounter}{0}
  \stepcounter{questionIndex}
  \putsideindex{-0.86}{0.04}
  \begin{minipage}{.95\textwidth}
    \question[#1]
}
{
  \end{minipage}
  \null \\[0.3cm]
}

\newenvironment{multiQuestion}{
  \setcounter{choicecounter}{0}
  \begin{minipage}{.95\textwidth}
    \question
}
{
  \end{minipage}
  \null \\[0.3cm]
}

\newcounter{questionIndex}


\newcommand{\subQuestion}[1][]{
  \setcounter{choicecounter}{0}
  \stepcounter{questionIndex}
  \putsideindex{-1.32}{0.13}
  \part[#1]
  }



\newcommand{\arcoAnswer}[1]{%
\ifprintanswers #1 \else \phantom{88} \fi }

\newcommand{\arcoChoiceMark}{$\square$}
\newcommand{\arcoCorrectChoiceMark}{ %
\ifprintanswers $\blacksquare$ \hspace{-7.5pt} \else \arcoChoiceMark \fi }

\newcommand{\arcoEmptyChoice}[2]{
  \stepcounter{choicecounter}
  {\fontsize{15pt}{15pt}\selectfont #1 }\hspace{2pt}
  \textbf{\alph{choicecounter}})\hspace{4pt}\parbox[t]{.9\textwidth}{#2\\[-.3cm]}%
  % DO NOT REMOVE THESE LINES

}

\newcommand{\choice}[1]{\arcoEmptyChoice{\arcoChoiceMark}{#1}}
\newcommand{\correctChoice}[1]{\arcoEmptyChoice{\arcoCorrectChoiceMark}{#1}}

\newlength{\altolinea}
\addtolength{\altolinea}{5mm minus 2mm}

\newcommand{\arcoSolutionorbox}[2]{
  \fcolorbox{gray90}{white}{
    \transparent{0.5}
    \parbox{.97\textwidth}{
      \ifprintanswers
      #2
      \else
      \rule{0mm}{#1\altolinea}
      \rule{.9\textwidth}{0mm}
      \fi
    }}
}

\newcommand{\arcoFigureWithAnswer}[3]{
  \ifprintanswers
  \includegraphics[width=#1\textwidth]{#3}
  \else
  \includegraphics[width=#1\textwidth]{#2}
  \fi
}

\RequirePackage{arco-listings}

\endinput
